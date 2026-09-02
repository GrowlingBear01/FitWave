import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen>
    with WidgetsBindingObserver {
  static const Color backgroundColor = Color(0xFFF0FAFC);
  static const Color primaryBlue = Color(0xFF2CB8D1);
  static const Color lightBlue = Color(0xFFBDEEF4);
  static const Color darkBlue = Color(0xFF173F5F);
  static const Color textBlue = Color(0xFF315B73);
  static const Color coral = Color(0xFFFF8585);
  static const Color softCoral = Color(0xFFFFE2E2);

  CameraController? _cameraController;
  Future<void>? _cameraInitialization;

  Timer? _workoutTimer;
  Timer? _repDemoTimer;

  int _elapsedSeconds = 0;
  int _reps = 0;

  String workoutState = 'Ready';
  String aiStatus = 'AI Ready';
  String formStatus = 'Waiting';

  bool _cameraError = false;
  String _cameraErrorMessage = '';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();

      if (cameras.isEmpty) {
        if (!mounted) return;

        setState(() {
          _cameraError = true;
          _cameraErrorMessage = 'No camera found on this device.';
        });

        return;
      }

      CameraDescription selectedCamera = cameras.first;

      for (final camera in cameras) {
        if (camera.lensDirection == CameraLensDirection.front) {
          selectedCamera = camera;
          break;
        }
      }

      final controller = CameraController(
        selectedCamera,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      _cameraController = controller;
      _cameraInitialization = controller.initialize();

      await _cameraInitialization;

      if (!mounted) return;

      setState(() {
        _cameraError = false;
      });
    } on CameraException catch (e) {
      if (!mounted) return;

      setState(() {
        _cameraError = true;
        _cameraErrorMessage = _cameraErrorText(e);
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _cameraError = true;
        _cameraErrorMessage = 'Unable to access the camera.';
      });
    }
  }

  String _cameraErrorText(CameraException error) {
    switch (error.code) {
      case 'CameraAccessDenied':
        return 'Camera permission was denied. Please allow camera access.';
      case 'CameraAccessDeniedWithoutPrompt':
        return 'Camera permission was previously denied. Please enable it in Settings.';
      case 'CameraAccessRestricted':
        return 'Camera access is currently restricted.';
      default:
        return 'Unable to access the camera.';
    }
  }

  void _startWorkout() {

    setState(() {
      workoutState = 'In Progress';
      aiStatus = 'Checking Form';
      formStatus = 'Correct Form';
    });

    _startTimer();
    _startDemoRepCounter();
  }

  void _startTimer() {
    _workoutTimer?.cancel();

    _workoutTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;

      setState(() {
        _elapsedSeconds++;
      });
    });
  }

  void _startDemoRepCounter() {
    _repDemoTimer?.cancel();

    _repDemoTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted || workoutState != 'In Progress') return;

      setState(() {
        _reps++;
      });
    });
  }

  void _pauseWorkout() {
    _workoutTimer?.cancel();
    _repDemoTimer?.cancel();

    setState(() {
      workoutState = 'Paused';
      aiStatus = 'Paused';
      formStatus = 'Waiting';
    });
  }

  void _resumeWorkout() {
    setState(() {
      workoutState = 'In Progress';
      aiStatus = 'Checking Form';
      formStatus = 'Correct Form';
    });

    _startTimer();
    _startDemoRepCounter();
  }

  void _stopWorkout() {
    _workoutTimer?.cancel();
    _repDemoTimer?.cancel();

    setState(() {
      workoutState = 'Completed';
      aiStatus = 'Workout Verified';
      formStatus = 'Completed';
    });
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: darkBlue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }

  String _formatTime() {
    final minutes = (_elapsedSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_elapsedSeconds % 60).toString().padLeft(2, '0');

    return '$minutes:$seconds';
  }

  void _exitWorkout() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Exit Workout?',
            style: TextStyle(
              color: darkBlue,
              fontWeight: FontWeight.w800,
            ),
          ),
          content: const Text(
            'Are you sure you want to leave this workout?',
            style: TextStyle(
              color: textBlue,
              fontSize: 13,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Just close the dialog.
                // The workout timers keep running.
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: textBlue,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Stop the workout timers only after
                // the user confirms the exit.
                _workoutTimer?.cancel();
                _repDemoTimer?.cancel();

                // Close the confirmation dialog.
                Navigator.pop(context);

                // Remove the entire challenge flow
                // and return directly to Home.
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/home',
                      (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: coral,
                foregroundColor: Colors.white,
                elevation: 0,
              ),
              child: const Text('Exit'),
            ),
          ],
        );
      },
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final controller = _cameraController;

    if (controller == null || !controller.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      controller.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initializeCamera();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    _workoutTimer?.cancel();
    _repDemoTimer?.cancel();

    _cameraController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;

    String goal = 'Fitness';
    String exercise = 'Full Body';
    String difficulty = 'Beginner';
    int duration = 7;

    if (arguments is Map) {
      goal = arguments['goal']?.toString() ?? 'Fitness';
      exercise = arguments['exercise']?.toString() ?? 'Full Body';
      difficulty = arguments['difficulty']?.toString() ?? 'Beginner';

      final dynamic durationValue = arguments['duration'];

      if (durationValue is int) {
        duration = durationValue;
      } else if (durationValue != null) {
        duration = int.tryParse(durationValue.toString()) ?? 7;
      }
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: _exitWorkout,
          icon: const Icon(Icons.close_rounded, color: darkBlue),
        ),
        title: const Text(
          'AI Workout',
          style: TextStyle(
            color: darkBlue,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 25),
          child: Column(
            children: [
              _buildCameraPreview(),

              const SizedBox(height: 14),

              _buildWorkoutHeader(exercise, difficulty),

              const SizedBox(height: 14),

              _buildStatsCard(),

              const SizedBox(height: 14),

              _buildAiStatus(),

              const SizedBox(height: 14),

              _buildFormStatus(),

              const SizedBox(height: 18),

              if (workoutState == 'Completed')
                _buildCompletionCard()
              else
                _buildWorkoutControls(),

              const SizedBox(height: 14),

              _buildChallengeInfo(goal, exercise, difficulty, duration),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCameraPreview() {
    return Container(
      width: double.infinity,
      height: 360,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: darkBlue.withOpacity(0.12),
            blurRadius: 18,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned.fill(child: _buildCameraContent()),

          Positioned(top: 14, left: 14, child: _cameraLabel()),

          Positioned(top: 14, right: 14, child: _aiLiveBadge()),

          if (workoutState == 'In Progress')
            Positioned(bottom: 14, left: 14, child: _liveBadge()),
        ],
      ),
    );
  }

  Widget _buildCameraContent() {
    if (_cameraError) {
      return Container(
        color: const Color(0xFF101820),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.no_photography_rounded,
                  color: Colors.white,
                  size: 50,
                ),
                const SizedBox(height: 14),
                const Text(
                  'Camera unavailable',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  _cameraErrorMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _initializeCamera,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Try Again'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final controller = _cameraController;

    if (controller == null ||
        !controller.value.isInitialized ||
        _cameraInitialization == null) {
      return Container(
        color: const Color(0xFF101820),
        child: const Center(
          child: CircularProgressIndicator(color: primaryBlue),
        ),
      );
    }

    return FutureBuilder<void>(
      future: _cameraInitialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Container(
            color: const Color(0xFF101820),
            child: const Center(
              child: CircularProgressIndicator(color: primaryBlue),
            ),
          );
        }

        if (snapshot.hasError) {
          return Container(
            color: const Color(0xFF101820),
            child: const Center(
              child: Text(
                'Unable to start camera preview.',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }

        return Center(
          child: AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: CameraPreview(controller),
          ),
        );
      },
    );
  }

  Widget _cameraLabel() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.55),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.camera_alt_rounded, color: Colors.white, size: 15),
          SizedBox(width: 6),
          Text(
            'Camera',
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _aiLiveBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
      decoration: BoxDecoration(
        color: primaryBlue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.smart_toy_rounded, color: Colors.white, size: 15),
          SizedBox(width: 5),
          Text(
            'AI',
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _liveBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
      decoration: BoxDecoration(
        color: coral,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.circle, color: Colors.white, size: 9),
          SizedBox(width: 6),
          Text(
            'LIVE',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutHeader(String exercise, String difficulty) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: primaryBlue.withOpacity(0.10)),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: lightBlue,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.fitness_center_rounded,
              color: darkBlue,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: darkBlue,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '$difficulty • AI Assisted Workout',
                  style: const TextStyle(
                    color: textBlue,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: darkBlue.withOpacity(0.045),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(child: _statItem(Icons.repeat_rounded, 'REPS', '$_reps')),
          Container(width: 1, height: 42, color: lightBlue),
          Expanded(
            child: _statItem(Icons.timer_rounded, 'TIME', _formatTime()),
          ),
          Container(width: 1, height: 42, color: lightBlue),
          Expanded(
            child: _statItem(Icons.flag_rounded, 'STATUS', workoutState),
          ),
        ],
      ),
    );
  }

  Widget _statItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: primaryBlue, size: 22),
        const SizedBox(height: 6),
        Text(
          value,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: darkBlue,
            fontSize: 15,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            color: textBlue,
            fontSize: 9,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildAiStatus() {
    final bool active = workoutState == 'In Progress';
    final bool completed = workoutState == 'Completed';

    final Color color = completed
        ? Colors.green
        : active
        ? primaryBlue
        : darkBlue;

    final Color background = completed
        ? Colors.green.withOpacity(0.10)
        : active
        ? lightBlue
        : const Color(0xFFF4F8F9);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(19),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: color.withOpacity(0.13),
              shape: BoxShape.circle,
            ),
            child: Icon(
              completed
                  ? Icons.verified_rounded
                  : active
                  ? Icons.smart_toy_rounded
                  : Icons.smart_toy_outlined,
              color: color,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'AI Verification',
                  style: TextStyle(
                    color: darkBlue,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  aiStatus,
                  style: TextStyle(
                    color: color,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          if (active)
            const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: primaryBlue,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFormStatus() {
    final bool correct = formStatus == 'Correct Form';
    final bool incorrect = formStatus == 'Incorrect Form';
    final bool completed = formStatus == 'Completed';

    Color color = textBlue;

    if (correct || completed) {
      color = Colors.green;
    } else if (incorrect) {
      color = coral;
    }

    Color background = Colors.white;

    if (correct || completed) {
      background = Colors.green.withOpacity(0.08);
    } else if (incorrect) {
      background = softCoral;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: color.withOpacity(0.12)),
      ),
      child: Row(
        children: [
          Icon(
            correct || completed
                ? Icons.check_circle_rounded
                : incorrect
                ? Icons.error_rounded
                : Icons.accessibility_new_rounded,
            color: color,
            size: 25,
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Form Detection',
                  style: TextStyle(
                    color: darkBlue,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  formStatus,
                  style: TextStyle(
                    color: color,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          if (correct)
            const Text(
              'GOOD',
              style: TextStyle(
                color: Colors.green,
                fontSize: 10,
                fontWeight: FontWeight.w900,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildWorkoutControls() {
    if (workoutState == 'Ready') {
      return SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton.icon(
          onPressed: _startWorkout,
          icon: const Icon(Icons.play_arrow_rounded, size: 23),
          label: const Text(
            'Start Workout',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryBlue,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(17),
            ),
          ),
        ),
      );
    }

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton.icon(
            onPressed: _stopWorkout,
            icon: const Icon(Icons.stop_rounded, size: 23),
            label: const Text(
              'Stop Workout',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: coral,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(17),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: OutlinedButton.icon(
            onPressed: workoutState == 'Paused'
                ? _resumeWorkout
                : _pauseWorkout,
            icon: Icon(
              workoutState == 'Paused'
                  ? Icons.play_arrow_rounded
                  : Icons.pause_rounded,
              size: 20,
            ),
            label: Text(
              workoutState == 'Paused' ? 'Resume Workout' : 'Pause Workout',
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: darkBlue,
              side: const BorderSide(color: lightBlue, width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCompletionCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.green.withOpacity(0.18)),
        boxShadow: [
          BoxShadow(
            color: darkBlue.withOpacity(0.055),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.10),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.emoji_events_rounded,
              color: Colors.green,
              size: 38,
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Workout Completed!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: darkBlue,
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 7),
          const Text(
            'Great job! Your workout has been verified by the AI system.',
            textAlign: TextAlign.center,
            style: TextStyle(color: textBlue, fontSize: 12, height: 1.4),
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _completionStat(Icons.repeat_rounded, '$_reps', 'Reps'),
              const SizedBox(width: 30),
              _completionStat(Icons.timer_rounded, _formatTime(), 'Time'),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/home',
                      (route) => false,
                );
              },
              icon: const Icon(Icons.home_rounded, size: 21),
              label: const Text(
                'Back to Home',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: darkBlue,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _completionStat(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: primaryBlue, size: 23),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            color: darkBlue,
            fontSize: 17,
            fontWeight: FontWeight.w900,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: textBlue,
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildChallengeInfo(
      String goal,
      String exercise,
      String difficulty,
      int duration,
      ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: primaryBlue.withOpacity(0.10)),
      ),
      child: Column(
        children: [
          _infoRow(Icons.track_changes_rounded, 'Goal', goal),
          const SizedBox(height: 12),
          _infoRow(Icons.fitness_center_rounded, 'Exercise', exercise),
          const SizedBox(height: 12),
          _infoRow(Icons.speed_rounded, 'Difficulty', difficulty),
          const SizedBox(height: 12),
          _infoRow(Icons.calendar_month_rounded, 'Challenge', '$duration days'),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          width: 39,
          height: 39,
          decoration: BoxDecoration(
            color: lightBlue,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: darkBlue, size: 19),
        ),
        const SizedBox(width: 11),
        Text(
          label,
          style: const TextStyle(
            color: textBlue,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: darkBlue,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}