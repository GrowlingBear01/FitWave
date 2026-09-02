import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    final endDate = now.add(Duration(days: duration));

    final challengeRef = _firestore.collection('challenges').doc();

    final challenge = Challenge(
      id: challengeRef.id,
      userId: user.uid,
      goal: goal,
      exercise: exercise,
      difficulty: difficulty,
      duration: duration,
      startDate: now,
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
  double calculateProgress(Challenge challenge) {
    final now = DateTime.now();

    // Challenge hasn't started yet.
    if (now.isBefore(challenge.startDate)) {
      return 0.0;
    }

    // Challenge has reached its end date.
    if (now.isAfter(challenge.endDate)) {
      return 1.0;
    }

    final totalDuration =
        challenge.endDate.difference(challenge.startDate).inSeconds;

    final elapsedDuration =
        now.difference(challenge.startDate).inSeconds;

    if (totalDuration <= 0) {
      return 1.0;
    }

    final progress = elapsedDuration / totalDuration;

    return progress.clamp(0.0, 1.0);
  }
  String calculateStatus(Challenge challenge) {
    final now = DateTime.now();

    if (now.isBefore(challenge.startDate)) {
      return 'upcoming';
    }

    if (now.isAfter(challenge.endDate)) {
      return 'completed';
    }

    return 'active';
  }
  Challenge updateChallengeProgress(Challenge challenge) {
    final progress = calculateProgress(challenge);
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
}