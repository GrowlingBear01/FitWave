import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../models/challenge.dart';

class ChallengeService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> createChallenge({
    required String goal,
    required String exercise,
    required String difficulty,
    required int duration,
  }) async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('User is not logged in.');
    }

    final now = DateTime.now();

    final startDate = DateTime(
      now.year,
      now.month,
      now.day,
    );

    final endDate = startDate.add(
      Duration(days: duration - 1),
    );

    final challengeRef = _firestore.collection('challenges').doc();

    final challenge = Challenge(
      id: challengeRef.id,
      userId: user.uid,
      goal: goal,
      exercise: exercise,
      difficulty: difficulty,
      duration: duration,
      startDate: startDate,
      endDate: endDate,
      status: 'active',
      progress: 0,
      createdAt: now,
    );

    await challengeRef.set(challenge.toMap());

    return challengeRef.id;
  }
  Stream<List<Challenge>> getUserChallenges() {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('User is not logged in.');
    }

    return _firestore
        .collection('challenges')
        .where('userId', isEqualTo: user.uid)
        .snapshots()
        .map(
          (snapshot) {
        return snapshot.docs.map(
              (doc) {
            return Challenge.fromMap(
              doc.id,
              doc.data(),
            );
          },
        ).toList();
      },
    );
  }
  Future<double> calculateProgress(Challenge challenge) async {
    final completedDays = await getCompletedWorkoutDays(challenge.id);

    if (challenge.duration <= 0) {
      return 1.0;
    }

    final progress = completedDays / challenge.duration;

    return progress.clamp(0.0, 1.0);
  }
  String calculateStatus(Challenge challenge) {
    // Keep terminal challenge states from being overwritten.
    if (challenge.status == 'failed') {
      return 'failed';
    }

    if (challenge.status == 'completed') {
      return 'completed';
    }

    final now = DateTime.now();

    if (now.isBefore(challenge.startDate)) {
      return 'upcoming';
    }

    return 'active';
  }
  Future<Challenge> updateChallengeProgress(
      Challenge challenge,
      ) async {
    final progress = await calculateProgress(challenge);
    final status = calculateStatus(challenge);

    return Challenge(
      id: challenge.id,
      userId: challenge.userId,
      goal: challenge.goal,
      exercise: challenge.exercise,
      difficulty: challenge.difficulty,
      duration: challenge.duration,
      startDate: challenge.startDate,
      endDate: challenge.endDate,
      status: status,
      progress: progress,
      createdAt: challenge.createdAt,
    );
  }
  Future<int> getCompletedWorkoutDays(String challengeId) async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('User is not logged in.');
    }

    final snapshot = await _firestore
        .collection('workouts')
        .where('userId', isEqualTo: user.uid)
        .where('challengeId', isEqualTo: challengeId)
        .where('verified', isEqualTo: true)
        .get();

    final completedDates = <String>{};

    for (final doc in snapshot.docs) {
      final data = doc.data();
      final timestamp = data['completedAt'];

      if (timestamp is Timestamp) {
        final date = timestamp.toDate();

        final dateKey =
            '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

        completedDates.add(dateKey);
      }
    }

    return completedDates.length;
  }
  Future<int> getCurrentStreak() async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('User is not logged in.');
    }

    final snapshot = await _firestore
        .collection('workouts')
        .where('userId', isEqualTo: user.uid)
        .where('verified', isEqualTo: true)
        .get();

    debugPrint('STREAK: Found ${snapshot.docs.length} verified workouts');

    final workoutDates = <DateTime>{};

    for (final doc in snapshot.docs) {
      final data = doc.data();
      final timestamp = data['completedAt'];

      debugPrint(
        'STREAK: workout=${doc.id}, '
            'verified=${data['verified']}, '
            'completedAt=$timestamp',
      );

      if (timestamp is Timestamp) {
        final localDate = timestamp.toDate().toLocal();

        final date = DateTime(
          localDate.year,
          localDate.month,
          localDate.day,
        );

        workoutDates.add(date);

        debugPrint('STREAK: workout date=$date');
      }
    }

    if (workoutDates.isEmpty) {
      debugPrint('STREAK: No workout dates found');
      return 0;
    }

    final today = DateTime.now();

    final todayDate = DateTime(
      today.year,
      today.month,
      today.day,
    );

    final yesterdayDate = todayDate.subtract(
      const Duration(days: 1),
    );

    debugPrint('STREAK: Today=$todayDate');
    debugPrint('STREAK: Yesterday=$yesterdayDate');
    debugPrint('STREAK: Workout dates=$workoutDates');

    final sortedDates = workoutDates.toList()
      ..sort((a, b) => b.compareTo(a));

    final latestWorkoutDate = sortedDates.first;

    debugPrint('STREAK: Latest workout=$latestWorkoutDate');

    if (latestWorkoutDate != todayDate &&
        latestWorkoutDate != yesterdayDate) {
      debugPrint('STREAK: Latest workout is not today/yesterday');
      return 0;
    }

    int streak = 1;
    DateTime previousDate = latestWorkoutDate;

    for (int i = 1; i < sortedDates.length; i++) {
      final currentDate = sortedDates[i];

      final difference =
          previousDate.difference(currentDate).inDays;

      debugPrint(
        'STREAK: Comparing $previousDate → $currentDate '
            '(difference=$difference)',
      );

      if (difference != 1) {
        break;
      }

      streak++;
      previousDate = currentDate;
    }

    debugPrint('STREAK: FINAL STREAK=$streak');

    return streak;
  }
  Future<void> updateChallengeFromWorkouts(
      String challengeId,
      ) async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('User is not logged in.');
    }

    final challengeRef =
    _firestore.collection('challenges').doc(challengeId);

    final challengeSnapshot = await challengeRef.get();

    if (!challengeSnapshot.exists) {
      throw Exception('Challenge not found.');
    }

    final challenge = Challenge.fromMap(
      challengeSnapshot.id,
      challengeSnapshot.data()!,
    );

    final progress = await calculateProgress(challenge);
    final status = calculateStatus(challenge);

    await challengeRef.update({
      'progress': progress,
      'status': status,
    });
  }
  Future<void> checkChallengeStatus(String challengeId) async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('User is not logged in.');
    }

    final challengeRef =
    _firestore.collection('challenges').doc(challengeId);

    final challengeSnapshot = await challengeRef.get();

    if (!challengeSnapshot.exists) {
      throw Exception('Challenge not found.');
    }

    final challenge = Challenge.fromMap(
      challengeSnapshot.id,
      challengeSnapshot.data()!,
    );

    // Do not change a challenge that has already finished.
    if (challenge.status == 'failed' ||
        challenge.status == 'completed') {
      return;
    }

    final now = DateTime.now();

    final today = DateTime(
      now.year,
      now.month,
      now.day,
    );

    final startDate = DateTime(
      challenge.startDate.year,
      challenge.startDate.month,
      challenge.startDate.day,
    );

    final endDate = DateTime(
      challenge.endDate.year,
      challenge.endDate.month,
      challenge.endDate.day,
    );

    // Get all verified workouts for this challenge.
    final snapshot = await _firestore
        .collection('workouts')
        .where('userId', isEqualTo: user.uid)
        .where('challengeId', isEqualTo: challengeId)
        .where('verified', isEqualTo: true)
        .get();

    final completedDates = <DateTime>{};

    for (final doc in snapshot.docs) {
      final data = doc.data();

      // Only the exercise selected for this challenge counts.
      final exercise =
      data['exercise']?.toString().trim().toLowerCase();

      if (exercise != challenge.exercise.trim().toLowerCase()) {
        continue;
      }

      final timestamp = data['completedAt'];

      if (timestamp is Timestamp) {
        final localDate = timestamp.toDate().toLocal();

        completedDates.add(
          DateTime(
            localDate.year,
            localDate.month,
            localDate.day,
          ),
        );
      }
    }

    // Only days before today can be considered "missed".
    final lastDayToCheck =
    today.isBefore(endDate) ? today.subtract(
      const Duration(days: 1),
    ) : endDate;

    // Check every required day that has already passed.
    DateTime checkDate = startDate;

    while (!checkDate.isAfter(lastDayToCheck)) {
      if (!completedDates.contains(checkDate)) {
        final completedDays = completedDates.length;

        final progress = challenge.duration <= 0
            ? 0.0
            : (completedDays / challenge.duration)
            .clamp(0.0, 1.0);

        await challengeRef.update({
          'progress': progress,
          'status': 'failed',
        });

        debugPrint(
          'CHALLENGE: $challengeId failed. '
              'Missed day: $checkDate',
        );

        return;
      }

      checkDate = checkDate.add(
        const Duration(days: 1),
      );
    }

    // If all challenge days have been completed, finish it.
    if (completedDates.length >= challenge.duration) {
      await challengeRef.update({
        'progress': 1.0,
        'status': 'completed',
      });

      debugPrint(
        'CHALLENGE: $challengeId completed.',
      );

      return;
    }

    // Otherwise the challenge is still active.
    await challengeRef.update({
      'status': 'active',
    });
  }
}