import 'package:flutter/material.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

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
                          'Rewards',
                          style: TextStyle(
                            color: darkBlue,
                            fontSize: 21,
                            fontWeight: FontWeight.w800,
                          ),
                        ),

                        SizedBox(height: 3),

                        Text(
                          'Celebrate your achievements',
                          style: TextStyle(color: textBlue, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // ==================================================
              // REWARD SUMMARY CARD
              // ==================================================
              _buildRewardSummaryCard(),

              const SizedBox(height: 25),

              // ==================================================
              // NEXT REWARD
              // ==================================================
              const Text(
                'Next Reward',
                style: TextStyle(
                  color: darkBlue,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 12),

              _buildNextRewardCard(),

              const SizedBox(height: 25),

              // ==================================================
              // EARNED REWARDS
              // ==================================================
              const Text(
                'Earned Rewards',
                style: TextStyle(
                  color: darkBlue,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 12),

              _buildEarnedReward(
                icon: Icons.local_fire_department_rounded,
                title: '7 Day Streak',
                description: 'Completed a 7 day workout streak',
                date: 'Earned Sep 1, 2026',
                iconColor: coral,
                backgroundColor: softCoral,
              ),

              const SizedBox(height: 12),

              _buildEarnedReward(
                icon: Icons.fitness_center_rounded,
                title: 'First Workout',
                description: 'Completed your first workout',
                date: 'Earned Aug 25, 2026',
                iconColor: primaryBlue,
                backgroundColor: lightBlue,
              ),

              const SizedBox(height: 12),

              _buildEarnedReward(
                icon: Icons.emoji_events_rounded,
                title: 'Challenge Starter',
                description: 'Started your first fitness challenge',
                date: 'Earned Aug 26, 2026',
                iconColor: darkBlue,
                backgroundColor: const Color(0xFFE5EEF3),
              ),

              const SizedBox(height: 25),

              // ==================================================
              // LOCKED REWARDS
              // ==================================================
              const Text(
                'More Rewards to Unlock',
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
                    child: _buildLockedReward(
                      icon: Icons.local_fire_department_rounded,
                      title: '14 Day Streak',
                      subtitle: 'Keep your streak alive',
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: _buildLockedReward(
                      icon: Icons.workspace_premium_rounded,
                      title: '30 Workouts',
                      subtitle: 'Complete 30 workouts',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _buildLockedReward(
                      icon: Icons.star_rounded,
                      title: 'Fitness Star',
                      subtitle: 'Earn 1000 points',
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: _buildLockedReward(
                      icon: Icons.military_tech_rounded,
                      title: 'Champion',
                      subtitle: 'Complete 5 challenges',
                    ),
                  ),
                ],
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
  // REWARD SUMMARY CARD
  // ============================================================

  Widget _buildRewardSummaryCard() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(22),

      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF173F5F), Color(0xFF285D7B)],
        ),

        borderRadius: BorderRadius.circular(25),

        boxShadow: [
          BoxShadow(
            color: darkBlue.withOpacity(0.20),
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
              Icon(
                Icons.workspace_premium_rounded,
                color: Colors.white,
                size: 24,
              ),

              SizedBox(width: 9),

              Text(
                'Your Achievements',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: _buildSummaryItem(value: '12', label: 'Rewards'),
              ),

              Container(
                width: 1,
                height: 45,
                color: Colors.white.withOpacity(0.20),
              ),

              Expanded(
                child: _buildSummaryItem(value: '420', label: 'Points'),
              ),

              Container(
                width: 1,
                height: 45,
                color: Colors.white.withOpacity(0.20),
              ),

              Expanded(
                child: _buildSummaryItem(value: '7', label: 'Day Streak'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SUMMARY ITEM
  // ============================================================

  Widget _buildSummaryItem({required String value, required String label}) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w900,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // NEXT REWARD CARD
  // ============================================================

  Widget _buildNextRewardCard() {
    const double progress = 0.70;

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,

                decoration: BoxDecoration(
                  color: lightBlue,
                  borderRadius: BorderRadius.circular(15),
                ),

                child: const Icon(
                  Icons.local_fire_department_rounded,
                  color: coral,
                  size: 27,
                ),
              ),

              const SizedBox(width: 13),

              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '14 Day Streak',
                      style: TextStyle(
                        color: darkBlue,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    SizedBox(height: 4),

                    Text(
                      '3 days remaining',
                      style: TextStyle(color: textBlue, fontSize: 11),
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
                '7 days completed',
                style: TextStyle(
                  color: textBlue,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),

              Text(
                '14 days goal',
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
  // EARNED REWARD
  // ============================================================

  Widget _buildEarnedReward({
    required IconData icon,
    required String title,
    required String description,
    required String date,
    required Color iconColor,
    required Color backgroundColor,
  }) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(
            color: darkBlue.withOpacity(0.05),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,

            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(15),
            ),

            child: Icon(icon, color: iconColor, size: 27),
          ),

          const SizedBox(width: 13),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: darkBlue,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  description,
                  style: const TextStyle(color: textBlue, fontSize: 10),
                ),

                const SizedBox(height: 4),

                Text(
                  date,
                  style: const TextStyle(
                    color: primaryBlue,
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          const Icon(Icons.check_circle_rounded, color: primaryBlue, size: 22),
        ],
      ),
    );
  }

  // ============================================================
  // LOCKED REWARD
  // ============================================================

  Widget _buildLockedReward({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(
            color: darkBlue.withOpacity(0.045),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 45,
            height: 45,

            decoration: BoxDecoration(
              color: const Color(0xFFF0F3F4),
              borderRadius: BorderRadius.circular(13),
            ),

            child: Icon(icon, color: Colors.grey.shade500, size: 23),
          ),

          const SizedBox(height: 12),

          Text(
            title,
            style: const TextStyle(
              color: darkBlue,
              fontSize: 13,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            subtitle,
            style: const TextStyle(color: textBlue, fontSize: 9, height: 1.3),
          ),

          const SizedBox(height: 10),

          const Row(
            children: [
              Icon(Icons.lock_outline_rounded, color: Colors.grey, size: 13),

              SizedBox(width: 4),

              Text(
                'Locked',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 9,
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
              'Every achievement is proof that you are getting stronger. Keep going! 💪',
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
    );
  }
}
