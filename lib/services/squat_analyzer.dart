import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:pose_detection/pose_detection.dart';

import '../models/workout_analysis_result.dart';
import 'exercise_analyzer.dart';

class SquatAnalyzer implements ExerciseAnalyzer {
  @override
  String get exerciseName => 'squat';

  int _reps = 0;

  String _state = 'standing';

  DateTime? _lastRepTime;

  // Store recent knee angles for smoothing.
  final List<double> _angleHistory = [];

  // Number of consecutive frames supporting the current movement.
  int _squatFrameCount = 0;
  int _standingFrameCount = 0;

  // Configuration.
  static const int _historySize = 5;

  static const int _requiredSquatFrames = 2;
  static const int _requiredStandingFrames = 2;

  static const double _squatAngle = 115.0;
  static const double _standingAngle = 155.0;

  static const double _minimumVisibility = 0.55;
  static const int _minimumRepIntervalMs = 800;

  int get reps => _reps;

  @override
  WorkoutAnalysisResult analyze(Pose pose) {
    final leftHip = pose.getLandmark(PoseLandmarkType.leftHip);
    final rightHip = pose.getLandmark(PoseLandmarkType.rightHip);

    final leftKnee = pose.getLandmark(PoseLandmarkType.leftKnee);
    final rightKnee = pose.getLandmark(PoseLandmarkType.rightKnee);

    final leftAnkle = pose.getLandmark(PoseLandmarkType.leftAnkle);
    final rightAnkle = pose.getLandmark(PoseLandmarkType.rightAnkle);

    if (leftHip == null ||
        rightHip == null ||
        leftKnee == null ||
        rightKnee == null ||
        leftAnkle == null ||
        rightAnkle == null) {
      return _invalidResult('Body not fully visible');
    }

    // Choose the side with the better knee visibility.
    final useLeft =
        leftKnee.visibility >= rightKnee.visibility;

    final hip = useLeft ? leftHip : rightHip;
    final knee = useLeft ? leftKnee : rightKnee;
    final ankle = useLeft ? leftAnkle : rightAnkle;

    final visibility = math.min(
      hip.visibility,
      math.min(
        knee.visibility,
        ankle.visibility,
      ),
    );

    // Do not change squat state when pose quality is poor.
    if (visibility < _minimumVisibility) {
      return _invalidResult(
        'Move so your full body is visible',
      );
    }

    final kneeAngle = _calculateAngle(
      hip.x,
      hip.y,
      knee.x,
      knee.y,
      ankle.x,
      ankle.y,
    );

    _addAngle(kneeAngle);

    final smoothedAngle = _getSmoothedAngle();

    debugPrint(
      'Knee angle: '
          '${smoothedAngle.toStringAsFixed(1)}°',
    );

    // --------------------------------------------------
    // SQUAT DETECTION
    // --------------------------------------------------

    if (smoothedAngle < _squatAngle) {
      _squatFrameCount++;
      _standingFrameCount = 0;

      // Require several frames before confirming squat.
      if (_state == 'standing' &&
          _squatFrameCount >= _requiredSquatFrames) {
        _state = 'squatting';
      }

      return WorkoutAnalysisResult(
        exercise: 'Squat',
        reps: _reps,
        targetReached: false,
        verified: _reps > 0,
        formMessage: _state == 'squatting'
            ? 'Good squat — come back up'
            : 'Keep going down',
        confidence: 0.0,
      );
    }

    // --------------------------------------------------
    // STANDING DETECTION
    // --------------------------------------------------

    if (smoothedAngle > _standingAngle) {
      _standingFrameCount++;
      _squatFrameCount = 0;

      // A rep is counted only after:
      //
      // standing
      //    ↓
      // confirmed squat
      //    ↓
      // confirmed standing
      //
      if (_state == 'squatting' &&
          _standingFrameCount >= _requiredStandingFrames) {
        final now = DateTime.now();

        if (_lastRepTime == null ||
            now
                .difference(_lastRepTime!)
                .inMilliseconds >=
                _minimumRepIntervalMs) {
          _reps++;
          _lastRepTime = now;

          _state = 'standing';

          return WorkoutAnalysisResult(
            exercise: 'Squat',
            reps: _reps,
            targetReached: false,
            verified: true,
            formMessage: 'Rep completed!',
            confidence: 1.0,
          );
        }

        _state = 'standing';
      }

      return WorkoutAnalysisResult(
        exercise: 'Squat',
        reps: _reps,
        targetReached: false,
        verified: _reps > 0,
        formMessage: 'Stand straight',
        confidence: 0.0,
      );
    }

    // --------------------------------------------------
    // BETWEEN POSITIONS
    // --------------------------------------------------

    _squatFrameCount = 0;
    _standingFrameCount = 0;

    return WorkoutAnalysisResult(
      exercise: 'Squat',
      reps: _reps,
      targetReached: false,
      verified: _reps > 0,
      formMessage: 'Keep going',
      confidence: 0.0,
    );
  }

  void _addAngle(double angle) {
    _angleHistory.add(angle);

    if (_angleHistory.length > _historySize) {
      _angleHistory.removeAt(0);
    }
  }

  double _getSmoothedAngle() {
    if (_angleHistory.isEmpty) {
      return 180;
    }

    final sum = _angleHistory.reduce(
          (value, element) => value + element,
    );

    return sum / _angleHistory.length;
  }

  WorkoutAnalysisResult _invalidResult(String message) {
    // Bad frames do NOT change the squat state.

    return WorkoutAnalysisResult(
      exercise: 'Squat',
      reps: _reps,
      targetReached: false,
      verified: _reps > 0,
      formMessage: message,
      confidence: 0.0,
    );
  }

  double _calculateAngle(
      double ax,
      double ay,
      double bx,
      double by,
      double cx,
      double cy,
      ) {
    final angle = math.atan2(
      cy - by,
      cx - bx,
    ) -
        math.atan2(
          ay - by,
          ax - bx,
        );

    var degrees = angle.abs() * 180 / math.pi;

    if (degrees > 180) {
      degrees = 360 - degrees;
    }

    return degrees;
  }

  @override
  void reset() {
    _reps = 0;
    _state = 'standing';

    _lastRepTime = null;

    _angleHistory.clear();

    _squatFrameCount = 0;
    _standingFrameCount = 0;
  }
}