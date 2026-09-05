import 'package:flutter/material.dart';

class StreakScreen extends StatelessWidget {
  const StreakScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: false,

        title: const Text(
          'Streak',
          style: TextStyle(
            color: darkBlue,
            fontSize: 21,
            fontWeight: FontWeight.w800,
          ),
        ),

        iconTheme: const IconThemeData(color: darkBlue),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),

          padding: const EdgeInsets.fromLTRB(20, 5, 20, 30),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              // ==================================================
              // CURRENT STREAK
              // ==================================================
              _buildCurrentStreakCard(),

              const SizedBox(height: 25),

              // ==================================================
              // STATS
              // ==================================================
              const Text(
                'Streak Stats',
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
                      icon: Icons.local_fire_department_rounded,
                      value: '7',
                      label: 'Current Streak',
                      iconColor: coral,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: _buildStatCard(
                      icon: Icons.emoji_events_rounded,
                      value: '14',
                      label: 'Best Streak',
                      iconColor: primaryBlue,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      icon: Icons.calendar_month_rounded,
                      value: '24',
                      label: 'Active Days',
                      iconColor: darkBlue,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: _buildStatCard(
                      icon: Icons.percent_rounded,
                      value: '86%',
                      label: 'Consistency',
                      iconColor: primaryBlue,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // ==================================================
              // WEEKLY ACTIVITY
              // ==================================================
              const Text(
                'This Week',
                style: TextStyle(
                  color: darkBlue,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 12),

              _buildWeeklyActivityCard(),

              const SizedBox(height: 25),

              // ==================================================
              // STREAK GOAL
              // ==================================================
              const Text(
                'Streak Goal',
                style: TextStyle(
                  color: darkBlue,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 12),

              _buildStreakGoalCard(),

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
  // CURRENT STREAK CARD
  // ============================================================

  Widget _buildCurrentStreakCard() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(24),

      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFF8585), Color(0xFFFFA0A0)],
        ),

        borderRadius: BorderRadius.circular(26),

        boxShadow: [
          BoxShadow(
            color: coral.withOpacity(0.22),
            blurRadius: 20,
            offset: const Offset(0, 9),
          ),
        ],
      ),

      child: Column(
        children: [
          Container(
            width: 75,
            height: 75,

            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.20),
              shape: BoxShape.circle,
            ),

            child: const Icon(
              Icons.local_fire_department_rounded,
              color: Colors.white,
              size: 43,
            ),
          ),

          const SizedBox(height: 15),

          const Text(
            'CURRENT STREAK',
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),

          const SizedBox(height: 4),

          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,

            children: [
              Text(
                '7',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 54,
                  fontWeight: FontWeight.w900,
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: 5, bottom: 10),

                child: Text(
                  'days',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          const Text(
            'Keep the momentum going! 🔥',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 18),

          Container(
            width: double.infinity,

            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),

            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(14),
            ),

            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Icon(Icons.bolt_rounded, color: Colors.white, size: 18),

                SizedBox(width: 6),

                Text(
                  'Next milestone: 10 days',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
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

      child: Column(
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

          const SizedBox(height: 10),

          Text(
            value,
            style: const TextStyle(
              color: darkBlue,
              fontSize: 19,
              fontWeight: FontWeight.w900,
            ),
          ),

          const SizedBox(height: 3),

          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: textBlue,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // WEEKLY ACTIVITY
  // ============================================================

  Widget _buildWeeklyActivityCard() {
    final List<Map<String, dynamic>> days = [
      {'day': 'M', 'active': true},
      {'day': 'T', 'active': true},
      {'day': 'W', 'active': true},
      {'day': 'T', 'active': true},
      {'day': 'F', 'active': true},
      {'day': 'S', 'active': true},
      {'day': 'S', 'active': false},
    ];

    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(20),

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
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Text(
                'Weekly Activity',
                style: TextStyle(
                  color: darkBlue,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),

              Text(
                '6 / 7 days',
                style: TextStyle(
                  color: primaryBlue,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: days.map((item) {
              final bool active = item['active'];

              return Column(
                children: [
                  Container(
                    width: 37,
                    height: 37,

                    decoration: BoxDecoration(
                      color: active ? primaryBlue : const Color(0xFFE7F3F5),
                      shape: BoxShape.circle,
                    ),

                    child: Icon(
                      active ? Icons.check_rounded : Icons.remove_rounded,
                      color: active ? Colors.white : textBlue.withOpacity(0.45),
                      size: 20,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    item['day'],
                    style: TextStyle(
                      color: active ? darkBlue : textBlue,
                      fontSize: 10,
                      fontWeight: active ? FontWeight.w800 : FontWeight.w500,
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
  // STREAK GOAL CARD
  // ============================================================

  Widget _buildStreakGoalCard() {
    const double progress = 0.70;

    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(20),

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
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              Container(
                width: 45,
                height: 45,

                decoration: BoxDecoration(
                  color: lightBlue,
                  borderRadius: BorderRadius.circular(14),
                ),

                child: const Icon(
                  Icons.flag_rounded,
                  color: primaryBlue,
                  size: 24,
                ),
              ),

              const SizedBox(width: 12),

              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      '10 Day Streak',
                      style: TextStyle(
                        color: darkBlue,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    SizedBox(height: 3),

                    Text(
                      '3 more days to reach your goal',
                      style: TextStyle(color: textBlue, fontSize: 10),
                    ),
                  ],
                ),
              ),

              const Text(
                '70%',
                style: TextStyle(
                  color: primaryBlue,
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),

          const SizedBox(height: 17),

          ClipRRect(
            borderRadius: BorderRadius.circular(20),

            child: LinearProgressIndicator(
              value: progress,
              minHeight: 9,
              backgroundColor: const Color(0xFFE5F3F6),
              valueColor: const AlwaysStoppedAnimation<Color>(primaryBlue),
            ),
          ),

          const SizedBox(height: 9),

          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Text(
                '7 days',
                style: TextStyle(
                  color: textBlue,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),

              Text(
                '10 days',
                style: TextStyle(
                  color: textBlue,
                  fontSize: 10,
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
  // MOTIVATION
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
              '"Consistency is the key to reaching your goals."',
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
