import 'package:flutter/material.dart';

class ChallengeSetupScreen extends StatefulWidget {
  const ChallengeSetupScreen({super.key});

  @override
  State<ChallengeSetupScreen> createState() => _ChallengeSetupScreenState();
}

class _ChallengeSetupScreenState extends State<ChallengeSetupScreen> {
  static const Color backgroundColor = Color(0xFFF0FAFC);
  static const Color primaryBlue = Color(0xFF2CB8D1);
  static const Color lightBlue = Color(0xFFBDEEF4);
  static const Color darkBlue = Color(0xFF173F5F);
  static const Color textBlue = Color(0xFF315B73);
  static const Color coral = Color(0xFFFF8585);

  int? selectedDuration;

  final List<int> durations = [7, 14, 21, 28];

  void continueToConfirmation() {
    if (selectedDuration == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please select a challenge duration first.'),
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
    String difficulty = 'Beginner';

    if (arguments is Map) {
      goal = arguments['goal']?.toString() ?? 'Fitness';
      exercise = arguments['exercise']?.toString() ?? 'Full Body';
      difficulty = arguments['difficulty']?.toString() ?? 'Beginner';
    }

    Navigator.pushNamed(
      context,
      '/challenge-confirmation',
      arguments: {
        'goal': goal,
        'exercise': exercise,
        'difficulty': difficulty,
        'duration': selectedDuration!,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;

    String goal = 'Fitness';
    String exercise = 'Full Body';
    String difficulty = 'Beginner';

    if (arguments is Map) {
      goal = arguments['goal']?.toString() ?? 'Fitness';
      exercise = arguments['exercise']?.toString() ?? 'Full Body';
      difficulty = arguments['difficulty']?.toString() ?? 'Beginner';
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
          'Challenge Setup',
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

          padding: const EdgeInsets.fromLTRB(20, 8, 20, 25),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const Text(
                'Set up your challenge',
                style: TextStyle(
                  color: darkBlue,
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Choose how long you want to stay committed.',
                style: TextStyle(color: textBlue, fontSize: 13, height: 1.4),
              ),

              const SizedBox(height: 22),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),

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
                    const Text(
                      'Your Challenge',
                      style: TextStyle(
                        color: darkBlue,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 15),

                    _summaryRow(Icons.track_changes_rounded, 'Goal', goal),

                    const SizedBox(height: 12),

                    _summaryRow(
                      Icons.fitness_center_rounded,
                      'Exercise',
                      exercise,
                    ),

                    const SizedBox(height: 12),

                    _summaryRow(Icons.speed_rounded, 'Difficulty', difficulty),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                'Challenge Duration',
                style: TextStyle(
                  color: darkBlue,
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 7),

              const Text(
                'Select the number of days for your challenge.',
                style: TextStyle(color: textBlue, fontSize: 12),
              ),

              const SizedBox(height: 15),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),

                itemCount: durations.length,

                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.35,
                ),

                itemBuilder: (context, index) {
                  final duration = durations[index];

                  final bool isSelected = selectedDuration == duration;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDuration = duration;
                      });
                    },

                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 220),

                      decoration: BoxDecoration(
                        color: isSelected
                            ? primaryBlue.withOpacity(0.10)
                            : Colors.white,

                        borderRadius: BorderRadius.circular(20),

                        border: Border.all(
                          color: isSelected ? primaryBlue : Colors.transparent,
                          width: 2,
                        ),

                        boxShadow: [
                          BoxShadow(
                            color: darkBlue.withOpacity(0.055),
                            blurRadius: 14,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),

                      child: Stack(
                        children: [
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                Text(
                                  '$duration',
                                  style: TextStyle(
                                    color: isSelected ? primaryBlue : darkBlue,
                                    fontSize: 29,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),

                                const SizedBox(height: 2),

                                const Text(
                                  'Days',
                                  style: TextStyle(
                                    color: textBlue,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          if (isSelected)
                            Positioned(
                              top: 10,
                              right: 10,

                              child: Container(
                                width: 25,
                                height: 25,

                                decoration: const BoxDecoration(
                                  color: primaryBlue,
                                  shape: BoxShape.circle,
                                ),

                                child: const Icon(
                                  Icons.check_rounded,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(17),

                decoration: BoxDecoration(
                  color: const Color(0xFFE5F7FA),
                  borderRadius: BorderRadius.circular(19),
                ),

                child: const Row(
                  children: [
                    Icon(Icons.auto_awesome_rounded, color: coral, size: 25),

                    SizedBox(width: 12),

                    Expanded(
                      child: Text(
                        'Consistency is the key. Pick a duration you can commit to!',
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

              const SizedBox(height: 22),

              SizedBox(
                width: double.infinity,
                height: 54,

                child: ElevatedButton(
                  onPressed: continueToConfirmation,

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
                        'Review Challenge',
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

  Widget _summaryRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          width: 38,
          height: 38,

          decoration: BoxDecoration(
            color: lightBlue,
            borderRadius: BorderRadius.circular(12),
          ),

          child: Icon(icon, color: darkBlue, size: 20),
        ),

        const SizedBox(width: 11),

        Text(
          '$label:',
          style: const TextStyle(
            color: textBlue,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(width: 5),

        Expanded(
          child: Text(
            value,
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
