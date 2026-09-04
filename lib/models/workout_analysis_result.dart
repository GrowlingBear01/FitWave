class WorkoutAnalysisResult {
  final String exercise;
  final int reps;
  final bool targetReached;
  final bool verified;
  final String formMessage;
  final double confidence;

  const WorkoutAnalysisResult({
    required this.exercise,
    required this.reps,
    required this.targetReached,
    required this.verified,
    required this.formMessage,
    required this.confidence,
  });
}