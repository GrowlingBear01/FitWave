import 'package:flutter/material.dart';

class ChallengeConfirmationScreen extends StatelessWidget {
  const ChallengeConfirmationScreen({super.key});

  static const Color backgroundColor = Color(0xFFF0FAFC);
  static const Color primaryBlue = Color(0xFF2CB8D1);
  static const Color lightBlue = Color(0xFFBDEEF4);
  static const Color darkBlue = Color(0xFF173F5F);
  static const Color textBlue = Color(0xFF315B73);
  static const Color coral = Color(0xFFFF8585);
  static const Color softCoral = Color(0xFFFFE2E2);

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
          icon: const Icon(Icons.arrow_back_rounded, color: darkBlue),
          onPressed: () => Navigator.pop(context),
        ),

        title: const Text(
          'Confirm Challenge',
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

          padding: const EdgeInsets.fromLTRB(20, 10, 20, 25),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Center(
                child: Container(
                  width: 82,
                  height: 82,

                  decoration: BoxDecoration(
                    color: lightBlue,
                    shape: BoxShape.circle,

                    boxShadow: [
                      BoxShadow(
                        color: primaryBlue.withOpacity(0.12),
                        blurRadius: 18,
                        offset: const Offset(0, 7),
                      ),
                    ],
                  ),

                  child: const Icon(
                    Icons.emoji_events_rounded,
                    color: primaryBlue,
                    size: 42,
                  ),
                ),
              ),

              const SizedBox(height: 18),

              const Center(
                child: Text(
                  'Ready to take the challenge?',
                  textAlign: TextAlign.center,

                  style: TextStyle(
                    color: darkBlue,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              const Center(
                child: Text(
                  'Review your challenge details before starting.',
                  textAlign: TextAlign.center,

                  style: TextStyle(color: textBlue, fontSize: 12, height: 1.4),
                ),
              ),

              const SizedBox(height: 25),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(19),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),

                  boxShadow: [
                    BoxShadow(
                      color: darkBlue.withOpacity(0.06),
                      blurRadius: 18,
                      offset: const Offset(0, 7),
                    ),
                  ],
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    const Text(
                      'Challenge Details',

                      style: TextStyle(
                        color: darkBlue,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 18),

                    _detailRow(
                      icon: Icons.track_changes_rounded,
                      label: 'Goal',
                      value: goal,
                      iconBackground: lightBlue,
                      iconColor: darkBlue,
                    ),

                    const SizedBox(height: 15),

                    _detailRow(
                      icon: Icons.fitness_center_rounded,
                      label: 'Exercise',
                      value: exercise,
                      iconBackground: lightBlue,
                      iconColor: darkBlue,
                    ),

                    const SizedBox(height: 15),

                    _detailRow(
                      icon: Icons.speed_rounded,
                      label: 'Difficulty',
                      value: difficulty,
                      iconBackground: softCoral,
                      iconColor: coral,
                    ),

                    const SizedBox(height: 15),

                    _detailRow(
                      icon: Icons.calendar_month_rounded,
                      label: 'Duration',
                      value: '$duration days',
                      iconBackground: lightBlue,
                      iconColor: primaryBlue,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(17),

                decoration: BoxDecoration(
                  color: const Color(0xFFE5F7FA),
                  borderRadius: BorderRadius.circular(19),
                ),

                child: const Row(
                  children: [
                    Icon(Icons.today_rounded, color: primaryBlue, size: 24),

                    SizedBox(width: 12),

                    Expanded(
                      child: Text(
                        'Your challenge will begin when you start it.',

                        style: TextStyle(
                          color: darkBlue,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(17),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(19),

                  border: Border.all(color: coral.withOpacity(0.12)),
                ),

                child: const Row(
                  children: [
                    Icon(Icons.favorite_rounded, color: coral, size: 24),

                    SizedBox(width: 12),

                    Expanded(
                      child: Text(
                        'Stay consistent, complete your daily workouts, and keep moving forward!',

                        style: TextStyle(
                          color: textBlue,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/workout',

                      arguments: {
                        'goal': goal,
                        'exercise': exercise,
                        'difficulty': difficulty,
                        'duration': duration,
                      },
                    );
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    foregroundColor: Colors.white,
                    elevation: 0,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17),
                    ),
                  ),

                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Icon(Icons.play_arrow_rounded, size: 22),

                      SizedBox(width: 8),

                      Text(
                        'Start Challenge',

                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                height: 50,

                child: TextButton(
                  onPressed: () => Navigator.pop(context),

                  child: const Text(
                    'Edit Challenge',

                    style: TextStyle(
                      color: textBlue,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
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

  Widget _detailRow({
    required IconData icon,
    required String label,
    required String value,
    required Color iconBackground,
    required Color iconColor,
  }) {
    return Row(
      children: [
        Container(
          width: 45,
          height: 45,

          decoration: BoxDecoration(
            color: iconBackground,
            borderRadius: BorderRadius.circular(14),
          ),

          child: Icon(icon, color: iconColor, size: 23),
        ),

        const SizedBox(width: 13),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                label,

                style: const TextStyle(
                  color: textBlue,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 3),

              Text(
                value,
                overflow: TextOverflow.ellipsis,

                style: const TextStyle(
                  color: darkBlue,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
