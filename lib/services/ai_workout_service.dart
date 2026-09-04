import 'package:pose_detection/pose_detection.dart';

import '../models/workout_analysis_result.dart';
import 'exercise_analyzer.dart';
import 'squat_analyzer.dart';

class AIWorkoutService {
  PoseDetector? _detector;

  final Map<String, ExerciseAnalyzer> _analyzers = {
    'squat': SquatAnalyzer(),
  };

  bool get isInitialized => _detector?.isInitialized ?? false;

  Future<void> initialize() async {
    if (isInitialized) {
      return;
    }

    _detector = await PoseDetector.create(
      mode: PoseMode.boxesAndLandmarks,
      landmarkModel: PoseLandmarkModel.lite,
      detectorConf: 0.5,
      minLandmarkScore: 0.5,
      maxDetections: 1,
    );
  }

  Future<List<Pose>> detectFromCameraImage(
      Object cameraImage,
      ) async {
    if (!isInitialized) {
      throw StateError(
        'AIWorkoutService is not initialized.',
      );
    }

    return _detector!.detectFromCameraImage(
      cameraImage,
      maxDim: 640,
    );
  }

  WorkoutAnalysisResult analyzeExercise({
    required String exercise,
    required Pose pose,
  }) {
    final analyzer = _getAnalyzer(exercise);

    if (analyzer == null) {
      return const WorkoutAnalysisResult(
        exercise: 'Unknown',
        reps: 0,
        targetReached: false,
        verified: false,
        formMessage: 'Exercise not supported yet',
        confidence: 0.0,
      );
    }

    return analyzer.analyze(pose);
  }

  void resetExercise(String exercise) {
    final analyzer = _getAnalyzer(exercise);

    analyzer?.reset();
  }

  ExerciseAnalyzer? _getAnalyzer(String exercise) {
    final key = exercise.trim().toLowerCase();

    // Direct match.
    if (_analyzers.containsKey(key)) {
      return _analyzers[key];
    }

    // Handle plural exercise names.
    if (key.endsWith('s')) {
      final singularKey = key.substring(0, key.length - 1);

      return _analyzers[singularKey];
    }

    return null;
  }

  void registerAnalyzer(ExerciseAnalyzer analyzer) {
    final key = analyzer.exerciseName.trim().toLowerCase();

    _analyzers[key] = analyzer;
  }

  Future<void> dispose() async {
    await _detector?.dispose();

    _detector = null;
  }
}