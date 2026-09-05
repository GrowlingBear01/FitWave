import 'package:flutter/material.dart';

class ChallengesScreen extends StatelessWidget {
  const ChallengesScreen({super.key});

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
        automaticallyImplyLeading: false,
        title: const Text(
          'Challenges',
          style: TextStyle(
            color: darkBlue,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Challenge filters coming soon')),
              );
            },
            icon: const Icon(Icons.tune_rounded, color: darkBlue),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCurrentChallenge(context),

              const SizedBox(height: 28),

              const Text(
                'Explore Challenges',
                style: TextStyle(
                  color: darkBlue,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 14),

              _buildChallengeCard(
                context: context,
                title: '14 Day Fitness Challenge',
                subtitle: 'Build a consistent workout habit',
                duration: '14 Days',
                progress: 0.0,
                icon: Icons.calendar_month_rounded,
                iconBackground: lightBlue,
                iconColor: primaryBlue,
                isActive: false,
              ),

              _buildChallengeCard(
                context: context,
                title: '21 Day Strength Challenge',
                subtitle: 'Improve strength and endurance',
                duration: '21 Days',
                progress: 0.0,
                icon: Icons.fitness_center_rounded,
                iconBackground: softCoral,
                iconColor: coral,
                isActive: false,
              ),

              _buildChallengeCard(
                context: context,
                title: '28 Day Fitness Journey',
                subtitle: 'Take your fitness to the next level',
                duration: '28 Days',
                progress: 0.0,
                icon: Icons.emoji_events_rounded,
                iconBackground: const Color(0xFFFFF0D9),
                iconColor: const Color(0xFFE59B22),
                isActive: false,
              ),

              const SizedBox(height: 18),

              _buildMotivationCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentChallenge(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [primaryBlue, Color(0xFF55C8D8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: primaryBlue.withOpacity(0.20),
            blurRadius: 15,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.20),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.emoji_events_rounded,
                  color: Colors.white,
                  size: 27,
                ),
              ),

              const SizedBox(width: 12),

              const Expanded(
                child: Text(
                  'Current Challenge',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.20),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  '68%',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          const Text(
            '7 Day Fitness Challenge',
            style: TextStyle(
              color: Colors.white,
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            'Keep going! You are doing great.',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),

          const SizedBox(height: 18),

          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: 0.68,
              minHeight: 9,
              backgroundColor: Colors.white.withOpacity(0.30),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),

          const SizedBox(height: 10),

          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '4 of 7 days completed',
                style: TextStyle(color: Colors.white, fontSize: 11),
              ),
              Text(
                '3 days left',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/workout');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: primaryBlue,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
              child: const Text(
                'Continue Challenge',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChallengeCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String duration,
    required double progress,
    required IconData icon,
    required Color iconBackground,
    required Color iconColor,
    required bool isActive,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: lightBlue.withOpacity(0.7)),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: iconBackground,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(icon, color: iconColor, size: 26),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: darkBlue,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: textBlue,
                        fontSize: 11,
                        height: 1.3,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        const Icon(
                          Icons.access_time_rounded,
                          color: textBlue,
                          size: 14,
                        ),

                        const SizedBox(width: 4),

                        Text(
                          duration,
                          style: const TextStyle(
                            color: textBlue,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                decoration: BoxDecoration(
                  color: lightBlue.withOpacity(0.45),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'New',
                  style: TextStyle(
                    color: primaryBlue,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          SizedBox(
            width: double.infinity,
            height: 42,
            child: OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/challenge-setup');
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: primaryBlue,
                side: const BorderSide(color: primaryBlue, width: 1.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Start Challenge',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
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
              'Choose a challenge that matches your fitness goal and stay consistent. Every workout counts! 💪',
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
