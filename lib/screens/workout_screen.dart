import 'package:flutter/material.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  static const Color backgroundColor = Color(0xFFF0FAFC);
  static const Color primaryBlue = Color(0xFF2CB8D1);
  static const Color lightBlue = Color(0xFFBDEEF4);
  static const Color darkBlue = Color(0xFF173F5F);
  static const Color textBlue = Color(0xFF315B73);
  static const Color coral = Color(0xFFFF8585);
  static const Color softCoral = Color(0xFFFFE2E2);

  String workoutState = 'Ready';

  void startWorkout() {
    setState(() {
      workoutState = 'In Progress';
    });
  }

  void pauseWorkout() {
    setState(() {
      workoutState = 'Paused';
    });
  }

  void resumeWorkout() {
    setState(() {
      workoutState = 'In Progress';
    });
  }

  void completeWorkout() {
    setState(() {
      workoutState = 'Completed';
    });
  }

  void exitWorkout() {
    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),

          title: const Text(
            'Exit Challenge?',
            style: TextStyle(color: darkBlue, fontWeight: FontWeight.w800),
          ),

          content: const Text(
            'Are you sure you want to leave this workout?',
            style: TextStyle(color: textBlue, fontSize: 13),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text(
                'Cancel',

                style: TextStyle(color: textBlue, fontWeight: FontWeight.w700),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
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

        leading: IconButton(
          onPressed: exitWorkout,

          icon: const Icon(Icons.close_rounded, color: darkBlue),
        ),

        title: const Text(
          'Challenge',

          style: TextStyle(
            color: darkBlue,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),

        centerTitle: true,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),

          padding: const EdgeInsets.fromLTRB(20, 10, 20, 25),

          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 9,
                ),

                decoration: BoxDecoration(
                  color: _statusBackground(),
                  borderRadius: BorderRadius.circular(30),
                ),

                child: Row(
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    Icon(_statusIcon(), color: _statusColor(), size: 18),

                    const SizedBox(width: 7),

                    Text(
                      workoutState,

                      style: TextStyle(
                        color: _statusColor(),
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              Container(
                width: 105,
                height: 105,

                decoration: BoxDecoration(
                  color: lightBlue,
                  shape: BoxShape.circle,

                  boxShadow: [
                    BoxShadow(
                      color: primaryBlue.withOpacity(0.15),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),

                child: const Icon(
                  Icons.fitness_center_rounded,
                  color: darkBlue,
                  size: 48,
                ),
              ),

              const SizedBox(height: 20),

              Text(
                '$exercise Challenge',

                textAlign: TextAlign.center,

                style: const TextStyle(
                  color: darkBlue,
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                ),
              ),

              const SizedBox(height: 7),

              Text(
                '$difficulty • $duration days',

                style: const TextStyle(
                  color: textBlue,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 25),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(19),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(21),

                  boxShadow: [
                    BoxShadow(
                      color: darkBlue.withOpacity(0.055),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        const Text(
                          'Today\'s Progress',

                          style: TextStyle(
                            color: darkBlue,
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),

                        Text(
                          workoutState == 'Completed' ? '100%' : '0%',

                          style: const TextStyle(
                            color: primaryBlue,
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 13),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),

                      child: LinearProgressIndicator(
                        value: workoutState == 'Completed' ? 1.0 : 0.0,

                        minHeight: 9,

                        backgroundColor: const Color(0xFFE5F3F6),

                        valueColor: const AlwaysStoppedAnimation<Color>(
                          primaryBlue,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      workoutState == 'Completed'
                          ? 'Workout completed! 🎉'
                          : 'Complete your workout to finish today\'s challenge.',

                      style: const TextStyle(
                        color: textBlue,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(21),

                  border: Border.all(color: primaryBlue.withOpacity(0.12)),
                ),

                child: Column(
                  children: [
                    _infoRow(Icons.track_changes_rounded, 'Goal', goal),

                    const SizedBox(height: 13),

                    _infoRow(
                      Icons.fitness_center_rounded,
                      'Exercise',
                      exercise,
                    ),

                    const SizedBox(height: 13),

                    _infoRow(Icons.speed_rounded, 'Difficulty', difficulty),

                    const SizedBox(height: 13),

                    _infoRow(
                      Icons.calendar_month_rounded,
                      'Duration',
                      '$duration days',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              _buildActionButton(),

              const SizedBox(height: 12),

              if (workoutState == 'In Progress')
                SizedBox(
                  width: double.infinity,
                  height: 48,

                  child: OutlinedButton.icon(
                    onPressed: pauseWorkout,

                    icon: const Icon(Icons.pause_rounded, size: 20),

                    label: const Text(
                      'Pause Workout',

                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
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

              if (workoutState == 'Paused')
                SizedBox(
                  width: double.infinity,
                  height: 48,

                  child: OutlinedButton.icon(
                    onPressed: resumeWorkout,

                    icon: const Icon(Icons.play_arrow_rounded, size: 20),

                    label: const Text(
                      'Resume Workout',

                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
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
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton() {
    String text;
    IconData icon;
    VoidCallback? action;
    Color color = primaryBlue;

    switch (workoutState) {
      case 'Ready':
        text = 'Start Workout';
        icon = Icons.play_arrow_rounded;
        action = startWorkout;
        break;

      case 'In Progress':
        text = 'Complete Workout';
        icon = Icons.check_rounded;
        action = completeWorkout;
        break;

      case 'Paused':
        text = 'Complete Workout';
        icon = Icons.check_rounded;
        action = completeWorkout;
        break;

      case 'Completed':
        text = 'Back to Home';
        icon = Icons.home_rounded;

        action = () {
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        };

        color = darkBlue;
        break;

      default:
        text = 'Start Workout';
        icon = Icons.play_arrow_rounded;
        action = startWorkout;
    }

    return SizedBox(
      width: double.infinity,
      height: 55,

      child: ElevatedButton.icon(
        onPressed: action,

        icon: Icon(icon, size: 22),

        label: Text(
          text,

          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
        ),

        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          elevation: 0,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(17),
          ),
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,

          decoration: BoxDecoration(
            color: lightBlue,
            borderRadius: BorderRadius.circular(12),
          ),

          child: Icon(icon, color: darkBlue, size: 20),
        ),

        const SizedBox(width: 12),

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

  Color _statusColor() {
    switch (workoutState) {
      case 'In Progress':
        return primaryBlue;

      case 'Paused':
        return coral;

      case 'Completed':
        return Colors.green;

      default:
        return darkBlue;
    }
  }

  Color _statusBackground() {
    switch (workoutState) {
      case 'In Progress':
        return lightBlue;

      case 'Paused':
        return softCoral;

      case 'Completed':
        return Colors.green.withOpacity(0.10);

      default:
        return Colors.white;
    }
  }

  IconData _statusIcon() {
    switch (workoutState) {
      case 'In Progress':
        return Icons.play_circle_rounded;

      case 'Paused':
        return Icons.pause_circle_rounded;

      case 'Completed':
        return Icons.check_circle_rounded;

      default:
        return Icons.flag_rounded;
    }
  }
}
