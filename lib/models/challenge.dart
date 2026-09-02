class Challenge {
  final String id;
  final String userId;
  final String goal;
  final String exercise;
  final String difficulty;
  final int duration;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final double progress;
  final DateTime createdAt;

  Challenge({
    required this.id,
    required this.userId,
    required this.goal,
    required this.exercise,
    required this.difficulty,
    required this.duration,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.progress,
    required this.createdAt,
  });

  factory Challenge.fromMap(
      String id,
      Map<String, dynamic> data,
      ) {
    return Challenge(
      id: id,
      userId: data['userId'] ?? '',
      goal: data['goal'] ?? '',
      exercise: data['exercise'] ?? '',
      difficulty: data['difficulty'] ?? '',
      duration: data['duration'] ?? 0,
      startDate: data['startDate'].toDate(),
      endDate: data['endDate'].toDate(),
      status: data['status'] ?? 'active',
      progress: (data['progress'] ?? 0).toDouble(),
      createdAt: data['createdAt'].toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'goal': goal,
      'exercise': exercise,
      'difficulty': difficulty,
      'duration': duration,
      'startDate': startDate,
      'endDate': endDate,
      'status': status,
      'progress': progress,
      'createdAt': createdAt,
    };
  }
}