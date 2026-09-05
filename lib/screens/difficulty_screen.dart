import 'package:flutter/material.dart';

class DifficultyScreen extends StatefulWidget {
  const DifficultyScreen({super.key});

  @override
  State<DifficultyScreen> createState() => _DifficultyScreenState();
}

class _DifficultyScreenState extends State<DifficultyScreen> {
  static const Color backgroundColor = Color(0xFFF0FAFC);
  static const Color primaryBlue = Color(0xFF2CB8D1);
  static const Color lightBlue = Color(0xFFBDEEF4);
  static const Color darkBlue = Color(0xFF173F5F);
  static const Color textBlue = Color(0xFF315B73);
  static const Color coral = Color(0xFFFF8585);

  String? selectedDifficulty;

  final List<Map<String, dynamic>> difficulties = [
    {
      'title': 'Beginner',
      'subtitle': 'Perfect for getting started',
      'description': 'Light intensity with simple exercises',
      'icon': Icons.directions_walk_rounded,
      'color': primaryBlue,
    },
    {
      'title': 'Intermediate',
      'subtitle': 'For an active fitness routine',
      'description': 'Moderate intensity with balanced exercises',
      'icon': Icons.directions_run_rounded,
      'color': darkBlue,
    },
    {
      'title': 'Advanced',
      'subtitle': 'For experienced fitness enthusiasts',
      'description': 'High intensity for a greater challenge',
      'icon': Icons.flash_on_rounded,
      'color': coral,
    },
  ];

  void continueToChallengeSetup() {
    if (selectedDifficulty == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please select a difficulty level first.'),
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
    String exercise = 'Full Body';

    if (arguments is Map) {
      goal = arguments['goal']?.toString() ?? 'Fitness';
      exercise = arguments['exercise']?.toString() ?? 'Full Body';
    }

    Navigator.pushNamed(
      context,
      '/challenge-setup',
      arguments: {
        'goal': goal,
        'exercise': exercise,
        'difficulty': selectedDifficulty!,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;

    String goal = 'Fitness';
    String exercise = 'Full Body';

    if (arguments is Map) {
      goal = arguments['goal']?.toString() ?? 'Fitness';
      exercise = arguments['exercise']?.toString() ?? 'Full Body';
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
          'Choose Difficulty',
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
                'How challenging should it be?',
                style: TextStyle(
                  color: darkBlue,
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Choose the intensity that feels right for you.',
                style: TextStyle(color: textBlue, fontSize: 13, height: 1.4),
              ),

              const SizedBox(height: 18),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 12,
                ),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: primaryBlue.withOpacity(0.12)),
                ),

                child: Row(
                  children: [
                    const Icon(
                      Icons.track_changes_rounded,
                      color: primaryBlue,
                      size: 20,
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: Text(
                        '$goal  •  $exercise',
                        style: const TextStyle(
                          color: textBlue,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),

                  itemCount: difficulties.length,

                  separatorBuilder: (_, __) => const SizedBox(height: 14),

                  itemBuilder: (context, index) {
                    final difficulty = difficulties[index];

                    final String title = difficulty['title'].toString();

                    final String subtitle = difficulty['subtitle'].toString();

                    final String description = difficulty['description']
                        .toString();

                    final IconData icon = difficulty['icon'] as IconData;

                    final Color color = difficulty['color'] as Color;

                    final bool isSelected = selectedDifficulty == title;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDifficulty = title;
                        });
                      },

                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 220),

                        padding: const EdgeInsets.all(18),

                        decoration: BoxDecoration(
                          color: isSelected
                              ? color.withOpacity(0.08)
                              : Colors.white,

                          borderRadius: BorderRadius.circular(21),

                          border: Border.all(
                            color: isSelected ? color : Colors.transparent,
                            width: 2,
                          ),

                          boxShadow: [
                            BoxShadow(
                              color: darkBlue.withOpacity(0.055),
                              blurRadius: 16,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),

                        child: Row(
                          children: [
                            Container(
                              width: 58,
                              height: 58,

                              decoration: BoxDecoration(
                                color: isSelected
                                    ? color
                                    : color.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(17),
                              ),

                              child: Icon(
                                icon,
                                color: isSelected ? Colors.white : color,
                                size: 29,
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
                                      fontSize: 17,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),

                                  const SizedBox(height: 4),

                                  Text(
                                    subtitle,
                                    style: const TextStyle(
                                      color: textBlue,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),

                                  const SizedBox(height: 5),

                                  Text(
                                    description,
                                    style: const TextStyle(
                                      color: textBlue,
                                      fontSize: 10,
                                      height: 1.3,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(width: 8),

                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),

                              width: 26,
                              height: 26,

                              decoration: BoxDecoration(
                                shape: BoxShape.circle,

                                color: isSelected ? color : Colors.transparent,

                                border: Border.all(
                                  color: isSelected
                                      ? color
                                      : textBlue.withOpacity(0.3),
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
                  onPressed: continueToChallengeSetup,

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
