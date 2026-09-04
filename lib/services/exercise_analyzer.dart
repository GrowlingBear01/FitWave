import 'package:pose_detection/pose_detection.dart';

import '../models/workout_analysis_result.dart';

abstract class ExerciseAnalyzer {
  String get exerciseName;

  WorkoutAnalysisResult analyze(Pose pose);

  void reset();
}