import 'package:flutter/material.dart';

class ChallengeCompletionScreen extends StatelessWidget {
  const ChallengeCompletionScreen({super.key});

  static const Color backgroundColor = Color(0xFFF0FAFC);
  static const Color primaryBlue = Color(0xFF2CB8D1);
  static const Color lightBlue = Color(0xFFBDEEF4);
  static const Color darkBlue = Color(0xFF173F5F);
  static const Color textBlue = Color(0xFF315B73);
  static const Color coral = Color(0xFFFF8585);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Challenge Complete',
          style: TextStyle(
            color: darkBlue,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
          child: Column(
            children: [
              _buildSuccessIcon(),

              const SizedBox(height: 22),

              const Text(
                'Amazing Work! 🎉',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: darkBlue,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'You have successfully completed your challenge!',
                textAlign: TextAlign.center,
                style: TextStyle(color: textBlue, fontSize: 14, height: 1.5),
              ),

              const SizedBox(height: 28),

              _buildChallengeCard(),

              const SizedBox(height: 18),

              _buildStatsSection(),

              const SizedBox(height: 18),

              _buildRewardsCard(),

              const SizedBox(height: 18),

              _buildMotivationCard(),

              const SizedBox(height: 28),

              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/home',
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Back to Home',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                height: 54,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/challenge-setup');
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: primaryBlue,
                    side: const BorderSide(color: primaryBlue, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Start Another Challenge',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessIcon() {
    return Container(
      width: 110,
      height: 110,
      decoration: BoxDecoration(
        color: lightBlue,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: primaryBlue.withOpacity(0.15),
            blurRadius: 20,
            spreadRadius: 4,
          ),
        ],
      ),
      child: const Icon(
        Icons.emoji_events_rounded,
        color: primaryBlue,
        size: 58,
      ),
    );
  }

  Widget _buildChallengeCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: lightBlue),
      ),
      child: Column(
        children: [
          const Text(
            '7 Day Fitness Challenge',
            style: TextStyle(
              color: darkBlue,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Challenge completed successfully',
            style: TextStyle(color: textBlue, fontSize: 13),
          ),

          const SizedBox(height: 20),

          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: 1.0,
              minHeight: 10,
              backgroundColor: lightBlue,
              valueColor: const AlwaysStoppedAnimation<Color>(primaryBlue),
            ),
          ),

          const SizedBox(height: 10),

          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '7 of 7 days',
                style: TextStyle(
                  color: textBlue,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '100%',
                style: TextStyle(
                  color: primaryBlue,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            icon: Icons.fitness_center_rounded,
            value: '7',
            label: 'Workouts',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            icon: Icons.timer_rounded,
            value: '2.4h',
            label: 'Active Time',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            icon: Icons.local_fire_department_rounded,
            value: '7',
            label: 'Day Streak',
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Icon(icon, color: primaryBlue, size: 25),

          const SizedBox(height: 8),

          Text(
            value,
            style: const TextStyle(
              color: darkBlue,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 3),

          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(color: textBlue, fontSize: 10),
          ),
        ],
      ),
    );
  }

  Widget _buildRewardsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFF3E8), Color(0xFFFFE8E8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.card_giftcard_rounded,
              color: coral,
              size: 30,
            ),
          ),

          const SizedBox(width: 15),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rewards Earned',
                  style: TextStyle(
                    color: darkBlue,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '+50 Coins • Challenge Badge',
                  style: TextStyle(color: textBlue, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMotivationCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: lightBlue.withOpacity(0.45),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.auto_awesome_rounded, color: primaryBlue, size: 25),

          SizedBox(width: 12),

          Expanded(
            child: Text(
              'Keep the momentum going! Start your next challenge and make your fitness journey even stronger. 💪',
              style: TextStyle(
                color: darkBlue,
                fontSize: 13,
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
