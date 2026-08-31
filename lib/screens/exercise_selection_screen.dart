import 'package:flutter/material.dart';

class ExerciseSelectionScreen extends StatefulWidget {
  const ExerciseSelectionScreen({super.key});

  @override
  State<ExerciseSelectionScreen> createState() =>
      _ExerciseSelectionScreenState();
}

class _ExerciseSelectionScreenState extends State<ExerciseSelectionScreen> {
  static const Color backgroundColor = Color(0xFFF0FAFC);
  static const Color primaryBlue = Color(0xFF2CB8D1);
  static const Color lightBlue = Color(0xFFBDEEF4);
  static const Color darkBlue = Color(0xFF173F5F);
  static const Color textBlue = Color(0xFF315B73);

  String? selectedExercise;

  final List<Map<String, dynamic>> exercises = [
    {
      'title': 'Full Body',
      'subtitle': 'Complete full body workout',
      'icon': Icons.accessibility_new_rounded,
    },
    {
      'title': 'Cardio',
      'subtitle': 'Improve stamina & endurance',
      'icon': Icons.directions_run_rounded,
    },
    {
      'title': 'Strength',
      'subtitle': 'Build strength & muscles',
      'icon': Icons.fitness_center_rounded,
    },
    {
      'title': 'Yoga',
      'subtitle': 'Improve flexibility & balance',
      'icon': Icons.self_improvement_rounded,
    },
    {
      'title': 'Core',
      'subtitle': 'Strengthen your core',
      'icon': Icons.sports_gymnastics_rounded,
    },
    {
      'title': 'Stretching',
      'subtitle': 'Improve mobility & flexibility',
      'icon': Icons.accessibility_rounded,
    },
  ];

  void continueToDifficulty() {
    if (selectedExercise == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please select an exercise first.'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: darkBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      );
      return;
    }

    final arguments = ModalRoute.of(context)?.settings.arguments;

    String goal = 'Fitness';

    if (arguments is Map) {
      goal = arguments['goal']?.toString() ?? 'Fitness';
    }

    Navigator.pushNamed(
      context,
      '/difficulty',
      arguments: {'goal': goal, 'exercise': selectedExercise!},
    );
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;

    String goal = 'Fitness';

    if (arguments is Map) {
      goal = arguments['goal']?.toString() ?? 'Fitness';
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
          'Choose Exercise',
          style: TextStyle(
            color: darkBlue,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const Text(
                'What do you want to focus on?',
                style: TextStyle(
                  color: darkBlue,
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Goal: $goal',
                style: const TextStyle(
                  color: textBlue,
                  fontSize: 13,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 24),

              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),

                  itemCount: exercises.length,

                  separatorBuilder: (_, __) => const SizedBox(height: 13),

                  itemBuilder: (context, index) {
                    final exercise = exercises[index];

                    final String title = exercise['title'].toString();

                    final String subtitle = exercise['subtitle'].toString();

                    final IconData icon = exercise['icon'] as IconData;

                    final bool isSelected = selectedExercise == title;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedExercise = title;
                        });
                      },

                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 220),

                        padding: const EdgeInsets.all(17),

                        decoration: BoxDecoration(
                          color: isSelected
                              ? lightBlue.withOpacity(0.55)
                              : Colors.white,

                          borderRadius: BorderRadius.circular(20),

                          border: Border.all(
                            color: isSelected
                                ? primaryBlue
                                : Colors.transparent,
                            width: 2,
                          ),

                          boxShadow: [
                            BoxShadow(
                              color: darkBlue.withOpacity(0.055),
                              blurRadius: 15,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),

                        child: Row(
                          children: [
                            Container(
                              width: 55,
                              height: 55,

                              decoration: BoxDecoration(
                                color: isSelected ? primaryBlue : lightBlue,
                                borderRadius: BorderRadius.circular(17),
                              ),

                              child: Icon(
                                icon,
                                color: isSelected ? Colors.white : darkBlue,
                                size: 27,
                              ),
                            ),

                            const SizedBox(width: 15),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Text(
                                    title,
                                    style: const TextStyle(
                                      color: darkBlue,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),

                                  const SizedBox(height: 4),

                                  Text(
                                    subtitle,
                                    style: const TextStyle(
                                      color: textBlue,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),

                              width: 26,
                              height: 26,

                              decoration: BoxDecoration(
                                shape: BoxShape.circle,

                                color: isSelected
                                    ? primaryBlue
                                    : Colors.transparent,

                                border: Border.all(
                                  color: isSelected
                                      ? primaryBlue
                                      : textBlue.withOpacity(0.35),
                                  width: 2,
                                ),
                              ),

                              child: isSelected
                                  ? const Icon(
                                      Icons.check_rounded,
                                      color: Colors.white,
                                      size: 17,
                                    )
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 15),

              SizedBox(
                width: double.infinity,
                height: 54,

                child: ElevatedButton(
                  onPressed: continueToDifficulty,

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
                      Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                        ),
                      ),

                      SizedBox(width: 8),

                      Icon(Icons.arrow_forward_rounded, size: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
