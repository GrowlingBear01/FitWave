import 'package:flutter/material.dart';
import 'calendar_history_screen.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  // ============================================================
  // FITWAVE COLORS
  // ============================================================

  static const Color backgroundColor = Color(0xFFF0FAFC);
  static const Color primaryBlue = Color(0xFF2CB8D1);
  static const Color lightBlue = Color(0xFFBDEEF4);
  static const Color darkBlue = Color(0xFF173F5F);
  static const Color textBlue = Color(0xFF315B73);
  static const Color coral = Color(0xFFFF8585);
  static const Color softCoral = Color(0xFFFFE2E2);

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),

          padding: const EdgeInsets.fromLTRB(20, 18, 20, 30),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              // ==================================================
              // HEADER
              // ==================================================
              Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: darkBlue.withOpacity(0.06),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.show_chart_rounded,
                      color: primaryBlue,
                      size: 25,
                    ),
                  ),

                  const SizedBox(width: 12),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Progress',
                          style: TextStyle(
                            color: darkBlue,
                            fontSize: 21,
                            fontWeight: FontWeight.w800,
                          ),
                        ),

                        SizedBox(height: 3),

                        Text(
                          'Track your fitness journey',
                          style: TextStyle(color: textBlue, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // ==================================================
              // OVERALL PROGRESS CARD
              // ==================================================
              _buildOverallProgressCard(),

              const SizedBox(height: 25),

              // ==================================================
              // QUICK STATS
              // ==================================================
              const Text(
                'Your Stats',
                style: TextStyle(
                  color: darkBlue,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      icon: Icons.check_circle_outline_rounded,
                      value: '24',
                      label: 'Workouts',
                      iconColor: primaryBlue,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: _buildStatCard(
                      icon: Icons.timer_outlined,
                      value: '8.5h',
                      label: 'Active Time',
                      iconColor: coral,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      icon: Icons.local_fire_department_outlined,
                      value: '3.2k',
                      label: 'Calories',
                      iconColor: coral,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: _buildStatCard(
                      icon: Icons.emoji_events_outlined,
                      value: '12',
                      label: 'Rewards',
                      iconColor: darkBlue,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // ==================================================
              // WEEKLY PROGRESS
              // ==================================================
              const Text(
                'Weekly Progress',
                style: TextStyle(
                  color: darkBlue,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 12),

              _buildWeeklyProgressCard(),

              const SizedBox(height: 25),

              // ==================================================
              // CHALLENGE PROGRESS
              // ==================================================
              const Text(
                'Challenge Progress',
                style: TextStyle(
                  color: darkBlue,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 12),

              _buildChallengeCard(),

              const SizedBox(height: 25),

              // ==================================================
              // CALENDAR & HISTORY
              // ==================================================
              const Text(
                'Workout History',
                style: TextStyle(
                  color: darkBlue,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 12),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CalendarHistoryScreen(),
                    ),
                  );
                },

                child: Container(
                  width: double.infinity,

                  padding: const EdgeInsets.all(18),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),

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
                      // Calendar Icon
                      Container(
                        width: 50,
                        height: 50,

                        decoration: BoxDecoration(
                          color: lightBlue,
                          borderRadius: BorderRadius.circular(15),
                        ),

                        child: const Icon(
                          Icons.calendar_month_rounded,
                          color: primaryBlue,
                          size: 27,
                        ),
                      ),

                      const SizedBox(width: 14),

                      // Text
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(
                              'Calendar & History',
                              style: TextStyle(
                                color: darkBlue,
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                              ),
                            ),

                            SizedBox(height: 5),

                            Text(
                              'View your workout history and activity',
                              style: TextStyle(
                                color: textBlue,
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Arrow
                      Container(
                        width: 34,
                        height: 34,

                        decoration: BoxDecoration(
                          color: const Color(0xFFEAF8FA),
                          borderRadius: BorderRadius.circular(10),
                        ),

                        child: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: primaryBlue,
                          size: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // ==================================================
              // MOTIVATION
              // ==================================================
              _buildMotivationCard(),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // OVERALL PROGRESS CARD
  // ============================================================

  Widget _buildOverallProgressCard() {
    const double progress = 0.68;

    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(22),

      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2CB8D1), Color(0xFF58C9DA)],
        ),

        borderRadius: BorderRadius.circular(25),

        boxShadow: [
          BoxShadow(
            color: primaryBlue.withOpacity(0.22),
            blurRadius: 20,
            offset: const Offset(0, 9),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          const Row(
            children: [
              Icon(Icons.insights_rounded, color: Colors.white, size: 23),

              SizedBox(width: 9),

              Text(
                'Overall Progress',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          Row(
            crossAxisAlignment: CrossAxisAlignment.end,

            children: [
              const Text(
                '68',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 46,
                  fontWeight: FontWeight.w900,
                ),
              ),

              const Padding(
                padding: EdgeInsets.only(bottom: 8, left: 3),

                child: Text(
                  '%',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),

              const Spacer(),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),

                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(12),
                ),

                child: const Text(
                  'Good job! 🔥',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 13),

          ClipRRect(
            borderRadius: BorderRadius.circular(20),

            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: Colors.white.withOpacity(0.25),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),

          const SizedBox(height: 11),

          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Text(
                'Keep going!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),

              Text(
                '32% remaining',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // STAT CARD
  // ============================================================

  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 12),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(
            color: darkBlue.withOpacity(0.055),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Row(
        children: [
          Container(
            width: 43,
            height: 43,

            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.11),
              borderRadius: BorderRadius.circular(13),
            ),

            child: Icon(icon, color: iconColor, size: 23),
          ),

          const SizedBox(width: 11),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  value,
                  style: const TextStyle(
                    color: darkBlue,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  label,
                  style: const TextStyle(
                    color: textBlue,
                    fontSize: 10,
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

  // ============================================================
  // WEEKLY PROGRESS CARD
  // ============================================================

  Widget _buildWeeklyProgressCard() {
    final List<Map<String, dynamic>> days = [
      {'day': 'M', 'value': 0.85, 'completed': true},
      {'day': 'T', 'value': 0.65, 'completed': true},
      {'day': 'W', 'value': 1.0, 'completed': true},
      {'day': 'T', 'value': 0.45, 'completed': true},
      {'day': 'F', 'value': 0.0, 'completed': false},
      {'day': 'S', 'value': 0.0, 'completed': false},
      {'day': 'S', 'value': 0.0, 'completed': false},
    ];

    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    'This Week',
                    style: TextStyle(
                      color: darkBlue,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  SizedBox(height: 4),

                  Text(
                    '4 workouts completed',
                    style: TextStyle(color: textBlue, fontSize: 11),
                  ),
                ],
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 7,
                ),

                decoration: BoxDecoration(
                  color: lightBlue,
                  borderRadius: BorderRadius.circular(10),
                ),

                child: const Text(
                  '4 / 7',
                  style: TextStyle(
                    color: darkBlue,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            crossAxisAlignment: CrossAxisAlignment.end,

            children: days.map((day) {
              final double value = day['value'];
              final bool completed = day['completed'];

              return Column(
                children: [
                  Container(
                    width: 30,
                    height: 90,

                    alignment: Alignment.bottomCenter,

                    decoration: BoxDecoration(
                      color: const Color(0xFFEAF7F9),
                      borderRadius: BorderRadius.circular(15),
                    ),

                    child: FractionallySizedBox(
                      heightFactor: value == 0 ? 0.04 : value,

                      child: Container(
                        decoration: BoxDecoration(
                          color: completed
                              ? primaryBlue
                              : const Color(0xFFD8EEF1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    day['day'],
                    style: TextStyle(
                      color: completed ? darkBlue : textBlue,
                      fontSize: 11,
                      fontWeight: completed ? FontWeight.w800 : FontWeight.w500,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // CHALLENGE CARD
  // ============================================================

  Widget _buildChallengeCard() {
    const double progress = 0.68;

    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),

        border: Border.all(color: primaryBlue.withOpacity(0.12)),

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
          Row(
            children: [
              Container(
                width: 48,
                height: 48,

                decoration: BoxDecoration(
                  color: softCoral,
                  borderRadius: BorderRadius.circular(14),
                ),

                child: const Icon(
                  Icons.emoji_events_rounded,
                  color: coral,
                  size: 25,
                ),
              ),

              const SizedBox(width: 12),

              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      '7 Day Fitness Challenge',
                      style: TextStyle(
                        color: darkBlue,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    SizedBox(height: 4),

                    Text(
                      'Stay consistent and complete your goal',
                      style: TextStyle(color: textBlue, fontSize: 10),
                    ),
                  ],
                ),
              ),

              const Text(
                '68%',
                style: TextStyle(
                  color: primaryBlue,
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          ClipRRect(
            borderRadius: BorderRadius.circular(20),

            child: LinearProgressIndicator(
              value: progress,
              minHeight: 9,
              backgroundColor: Color(0xFFE5F3F6),
              valueColor: AlwaysStoppedAnimation<Color>(primaryBlue),
            ),
          ),

          const SizedBox(height: 10),

          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Text(
                '4 of 7 days completed',
                style: TextStyle(
                  color: textBlue,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),

              Text(
                '3 days left',
                style: TextStyle(
                  color: coral,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // MOTIVATION CARD
  // ============================================================

  Widget _buildMotivationCard() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: const Color(0xFFE5F7FA),
        borderRadius: BorderRadius.circular(20),
      ),

      child: const Row(
        children: [
          Icon(Icons.auto_awesome_rounded, color: coral, size: 25),

          SizedBox(width: 12),

          Expanded(
            child: Text(
              '"Small steps every day lead to big changes."',
              style: TextStyle(
                color: darkBlue,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
