import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/workout.dart';

class WorkoutService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> saveWorkout({
    required String challengeId,
    required String exercise,
    required int reps,
    required int durationSeconds,
    required bool verified,
  }) async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('User is not logged in.');
    }

    final workoutRef = _firestore.collection('workouts').doc();

    final workout = Workout(
      id: workoutRef.id,
      userId: user.uid,
      challengeId: challengeId,
      exercise: exercise,
      reps: reps,
      durationSeconds: durationSeconds,
      verified: verified,
      completedAt: DateTime.now(),
    );

    await workoutRef.set(workout.toMap());

    return workoutRef.id;
  }

  Stream<List<Workout>> getUserWorkouts() {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('User is not logged in.');
    }

    return _firestore
        .collection('workouts')
        .where('userId', isEqualTo: user.uid)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Workout.fromMap(
          doc.id,
          doc.data(),
        );
      }).toList();
    });
  }

  Stream<List<Workout>> getChallengeWorkouts(
      String challengeId,
      ) {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('User is not logged in.');
    }

    return _firestore
        .collection('workouts')
        .where('userId', isEqualTo: user.uid)
        .where('challengeId', isEqualTo: challengeId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Workout.fromMap(
          doc.id,
          doc.data(),
        );
      }).toList();
    });
  }
  Future<List<Workout>> getVerifiedWorkouts() async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('User is not logged in.');
    }

    final snapshot = await _firestore
        .collection('workouts')
        .where('userId', isEqualTo: user.uid)
        .where('verified', isEqualTo: true)
        .get();

    return snapshot.docs.map((doc) {
      return Workout.fromMap(
        doc.id,
        doc.data(),
      );
    }).toList();
  }
}