import 'package:flutter/material.dart';

class GoalSelectionScreen extends StatefulWidget {
  const GoalSelectionScreen({super.key});

  @override
  State<GoalSelectionScreen> createState() => _GoalSelectionScreenState();
}

class _GoalSelectionScreenState extends State<GoalSelectionScreen> {
  int? selectedGoal;

  static const Color backgroundColor = Color(0xFFF0FAFC);
  static const Color primaryBlue = Color(0xFF2CB8D1);
  static const Color lightBlue = Color(0xFFBDEEF4);
  static const Color darkBlue = Color(0xFF173F5F);
  static const Color textBlue = Color(0xFF315B73);

  final List<Map<String, dynamic>> goals = [
    {
      'title': 'Build Strength',
      'subtitle': 'Get stronger and more powerful',
      'icon': Icons.fitness_center_rounded,
    },
    {
      'title': 'Lose Weight',
      'subtitle': 'Burn calories and stay active',
      'icon': Icons.local_fire_department_rounded,
    },
    {
      'title': 'Improve Fitness',
      'subtitle': 'Build stamina and endurance',
      'icon': Icons.directions_run_rounded,
    },
    {
      'title': 'Stay Healthy',
      'subtitle': 'Maintain a healthy lifestyle',
      'icon': Icons.favorite_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: true,

        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: darkBlue),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: const Text(
          'Choose Your Goal',
          style: TextStyle(
            color: darkBlue,
            fontSize: 19,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const Text(
                'What do you want to achieve?',
                style: TextStyle(
                  color: darkBlue,
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Select one goal to personalize your fitness challenge.',
                style: TextStyle(color: textBlue, fontSize: 13, height: 1.4),
              ),

              const SizedBox(height: 25),

              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: goals.length,

                  itemBuilder: (context, index) {
                    final goal = goals[index];
                    final isSelected = selectedGoal == index;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedGoal = index;
                        });
                      },

                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),

                        margin: const EdgeInsets.only(bottom: 14),
                        padding: const EdgeInsets.all(17),

                        decoration: BoxDecoration(
                          color: Colors.white,

                          borderRadius: BorderRadius.circular(20),

                          border: Border.all(
                            color: isSelected
                                ? primaryBlue
                                : Colors.transparent,
                            width: 2,
                          ),

                          boxShadow: [
                            BoxShadow(
                              color: darkBlue.withOpacity(0.06),
                              blurRadius: 14,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),

                        child: Row(
                          children: [
                            Container(
                              width: 55,
                              height: 55,

                              decoration: BoxDecoration(
                                color: isSelected
                                    ? primaryBlue.withOpacity(0.15)
                                    : lightBlue,
                                borderRadius: BorderRadius.circular(16),
                              ),

                              child: Icon(
                                goal['icon'],
                                color: primaryBlue,
                                size: 28,
                              ),
                            ),

                            const SizedBox(width: 15),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Text(
                                    goal['title'],
                                    style: const TextStyle(
                                      color: darkBlue,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),

                                  const SizedBox(height: 5),

                                  Text(
                                    goal['subtitle'],
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

                              width: 25,
                              height: 25,

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
                                      size: 16,
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

              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                height: 54,

                child: ElevatedButton(
                  onPressed: selectedGoal == null
                      ? null
                      : () {
                          final selectedGoalTitle =
                              goals[selectedGoal!]['title'].toString();

                          Navigator.pushNamed(
                            context,
                            '/exercise-selection',
                            arguments: {'goal': selectedGoalTitle},
                          );
                        },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    disabledBackgroundColor: primaryBlue.withOpacity(0.35),
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
