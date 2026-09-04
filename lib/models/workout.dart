class Workout {
  final String id;
  final String userId;
  final String challengeId;
  final String exercise;
  final int reps;
  final int durationSeconds;
  final bool verified;
  final DateTime completedAt;

  Workout({
    required this.id,
    required this.userId,
    required this.challengeId,
    required this.exercise,
    required this.reps,
    required this.durationSeconds,
    required this.verified,
    required this.completedAt,
  });

  factory Workout.fromMap(
      String id,
      Map<String, dynamic> data,
      ) {
    return Workout(
      id: id,
      userId: data['userId'] ?? '',
      challengeId: data['challengeId'] ?? '',
      exercise: data['exercise'] ?? '',
      reps: data['reps'] ?? 0,
      durationSeconds: data['durationSeconds'] ?? 0,
      verified: data['verified'] ?? false,
      completedAt: data['completedAt'].toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'challengeId': challengeId,
      'exercise': exercise,
      'reps': reps,
      'durationSeconds': durationSeconds,
      'verified': verified,
      'completedAt': completedAt,
    };
  }
}