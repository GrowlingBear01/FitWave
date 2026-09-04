import 'package:flutter/material.dart';

import 'profile_screen.dart';
import '../services/challenge_service.dart';
import '../models/challenge.dart';
import '../models/workout.dart';
import '../services/workout_service.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final ChallengeService _challengeService = ChallengeService();
  final WorkoutService _workoutService = WorkoutService();

  int _selectedIndex = 0;

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
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _animationController.forward();

    _checkActiveChallenge();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // ============================================================
  // ANIMATION
  // ============================================================

  Widget animatedItem({required Widget child, required int index}) {
    final animation = CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        (index * 0.07).clamp(0.0, 0.65),
        ((index * 0.07) + 0.35).clamp(0.35, 1.0),
        curve: Curves.easeOutCubic,
      ),
    );

    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (context, child) {
        return Opacity(
          opacity: animation.value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - animation.value)),
            child: child,
          ),
        );
      },
    );
  }

  // ============================================================
  // MOCK DATA
  // ============================================================

  final String userName = 'User';



  final int walletCoins = 00;

  // ============================================================
  // SNACKBAR
  // ============================================================

  void showComingSoon(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature will be connected soon.'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: darkBlue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: [
            _buildHomeContent(),
            _buildPlaceholder('Challenges', Icons.emoji_events_outlined),
            _buildPlaceholder('Progress', Icons.show_chart_rounded),
            _buildPlaceholder('Wallet', Icons.account_balance_wallet_outlined),
            const ProfileScreen(),
          ],
        ),
      ),

      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Future<void> _checkActiveChallenge() async {
    try {
      final challenges =
      await _challengeService.getUserChallenges().first;

      if (challenges.isEmpty) {
        return;
      }

      // Find the active challenge.
      final activeChallenges = challenges.where(
            (challenge) => challenge.status == 'active',
      );

      if (activeChallenges.isEmpty) {
        return;
      }

      // Use the most recent active challenge.
      final challenge = activeChallenges.last;

      await _challengeService.checkChallengeStatus(
        challenge.id,
      );
    } catch (e) {
      debugPrint(
        'Failed to check challenge status: $e',
      );
    }
  }

  // ============================================================
  // HOME CONTENT
  // ============================================================

  Widget _buildHomeContent() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),

      padding: const EdgeInsets.fromLTRB(20, 18, 20, 25),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          // ======================================================
          // TOP BAR
          // ======================================================
          animatedItem(
            index: 0,

            child: Row(
              children: [
                // Small FitWave wave icon
                Container(
                  width: 48,
                  height: 48,

                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,

                    boxShadow: [
                      BoxShadow(
                        color: primaryBlue.withOpacity(0.13),
                        blurRadius: 14,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),

                  child: const Icon(
                    Icons.favorite_rounded,
                    color: primaryBlue,
                    size: 25,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        'Good Morning, $userName 👋',

                        style: const TextStyle(
                          color: darkBlue,
                          fontSize: 19,
                          fontWeight: FontWeight.w800,
                        ),
                      ),

                      const SizedBox(height: 3),

                      const Text(
                        'Ready to move today?',
                        style: TextStyle(color: textBlue, fontSize: 12),
                      ),
                    ],
                  ),
                ),

                // Notification
                Container(
                  width: 44,
                  height: 44,

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),

                    boxShadow: [
                      BoxShadow(
                        color: darkBlue.withOpacity(0.06),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),

                  child: IconButton(
                    onPressed: () {
                      showComingSoon('Notifications');
                    },

                    icon: const Icon(
                      Icons.notifications_none_rounded,
                      color: darkBlue,
                      size: 23,
                    ),
                  ),
                ),

                const SizedBox(width: 10),


              ],
            ),
          ),

          const SizedBox(height: 25),

          // ======================================================
          // STREAK CARD
          // ======================================================
          FutureBuilder<int>(
            future: _challengeService.getCurrentStreak(),
            builder: (context, snapshot) {
              final int streak = snapshot.data ?? 0;

              return animatedItem(
                index: 1,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF2CB8D1),
                        Color(0xFF58C9DA),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: primaryBlue.withOpacity(0.22),
                        blurRadius: 20,
                        offset: const Offset(0, 9),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.20),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.local_fire_department_rounded,
                          color: Colors.white,
                          size: 34,
                        ),
                      ),

                      const SizedBox(width: 16),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Current Streak',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            const SizedBox(height: 2),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '$streak',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 31,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),

                                const SizedBox(width: 5),

                                const Padding(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    'days 🔥',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 11,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          streak > 0 ? 'Done today ✓' : 'Start today',
                          style: const TextStyle(
                            color: primaryBlue,
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          // ======================================================
          // SECTION TITLE
          // ======================================================
          animatedItem(
            index: 2,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                const Text(
                  "Today's Workout",

                  style: TextStyle(
                    color: darkBlue,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                TextButton(
                  onPressed: () {
                    showComingSoon('Workout section');
                  },

                  child: const Text(
                    'View all',
                    style: TextStyle(
                      color: primaryBlue,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // ======================================================
          // WORKOUT CARD
          // ======================================================
          animatedItem(
            index: 3,

            child: GestureDetector(
              onTap: () {
                showComingSoon('Workout');
              },

              child: Container(
                padding: const EdgeInsets.all(17),

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius: BorderRadius.circular(22),

                  boxShadow: [
                    BoxShadow(
                      color: darkBlue.withOpacity(0.07),
                      blurRadius: 18,
                      offset: const Offset(0, 7),
                    ),
                  ],
                ),

                child: Row(
                  children: [
                    Container(
                      width: 64,
                      height: 64,

                      decoration: BoxDecoration(
                        color: lightBlue,
                        borderRadius: BorderRadius.circular(18),
                      ),

                      child: const Icon(
                        Icons.fitness_center_rounded,
                        color: darkBlue,
                        size: 29,
                      ),
                    ),

                    const SizedBox(width: 15),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            'Full Body Strength',

                            style: TextStyle(
                              color: darkBlue,
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),

                          SizedBox(height: 5),

                          Text(
                            '20 min  •  6 exercises',

                            style: TextStyle(color: textBlue, fontSize: 12),
                          ),

                          SizedBox(height: 8),

                          Row(
                            children: [
                              Icon(Icons.bolt_rounded, color: coral, size: 15),

                              SizedBox(width: 4),

                              Text(
                                'Intermediate',
                                style: TextStyle(
                                  color: coral,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    Container(
                      width: 43,
                      height: 43,

                      decoration: BoxDecoration(
                        color: primaryBlue,
                        borderRadius: BorderRadius.circular(14),
                      ),

                      child: const Icon(
                        Icons.play_arrow_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 25),

          // ======================================================
          // CURRENT CHALLENGE
          // ======================================================
          animatedItem(
            index: 4,

            child: const Text(
              'Current Challenge',

              style: TextStyle(
                color: darkBlue,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),

          const SizedBox(height: 10),

          // ======================================================
          // CURRENT CHALLENGE CARD
          // ONLY CHANGE: GestureDetector + navigation
          // ======================================================
          StreamBuilder<List<Challenge>>(
            stream: _challengeService.getUserChallenges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return animatedItem(
                  index: 5,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              }

              if (snapshot.hasError) {
                return animatedItem(
                  index: 5,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: const Text(
                      'Unable to load your challenge.',
                      style: TextStyle(
                        color: textBlue,
                        fontSize: 12,
                      ),
                    ),
                  ),
                );
              }

              final challenges = snapshot.data ?? [];

              if (challenges.isEmpty) {
                return animatedItem(
                  index: 5,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/goal-selection');
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: primaryBlue.withOpacity(0.13),
                        ),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.add_circle_outline_rounded,
                            color: primaryBlue,
                            size: 32,
                          ),
                          SizedBox(width: 14),
                          Expanded(
                            child: Text(
                              'No active challenge yet.\nTap to create one!',
                              style: TextStyle(
                                color: darkBlue,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }

              // Display the most recent challenge.
              final challenge = challenges.last;

              return FutureBuilder<double>(
                future: _challengeService.calculateProgress(challenge),
                builder: (context, progressSnapshot) {
                  if (progressSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return animatedItem(
                      index: 5,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(25),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    );
                  }

                  if (progressSnapshot.hasError) {
                    return animatedItem(
                      index: 5,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: const Text(
                          'Unable to load challenge progress.',
                          style: TextStyle(
                            color: textBlue,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    );
                  }

                  final currentProgress =
                      progressSnapshot.data ?? 0.0;

                  final currentStatus = challenge.status;

                  final progressPercentage =
                  (currentProgress * 100).round();

                  final totalDays = challenge.duration;

                  final completedDays =
                  (currentProgress * totalDays).round();

                  final daysRemaining =
                  (totalDays - completedDays).clamp(0, totalDays);

                  return animatedItem(
                      index: 5,
                      child: GestureDetector(
                        onTap: currentStatus == 'failed' ||
                            currentStatus == 'completed'
                            ? null
                            : () {
                          Navigator.pushNamed(
                            context,
                            '/workout',
                            arguments: {
                              'goal': challenge.goal,
                              'exercise': challenge.exercise,
                              'difficulty': challenge.difficulty,
                              'duration': challenge.duration,
                              'challengeId': challenge.id,
                            },
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(19),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(22),
                            border: Border.all(
                              color: primaryBlue.withOpacity(0.13),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: darkBlue.withOpacity(0.055),
                                blurRadius: 18,
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
                                    width: 45,
                                    height: 45,
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

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${challenge.duration} Day ${challenge.goal} Challenge',
                                          style: const TextStyle(
                                            color: darkBlue,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),

                                        const SizedBox(height: 3),

                                        Text(
                                          '${challenge.exercise} • ${challenge.difficulty}',
                                          style: const TextStyle(
                                            color: textBlue,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Text(
                                    '$progressPercentage%',
                                    style: TextStyle(
                                      color: currentStatus == 'failed'
                                          ? coral
                                          : primaryBlue,
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
                                  value: currentProgress,
                                  minHeight: 9,
                                  backgroundColor:
                                  const Color(0xFFE5F3F6),
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    currentStatus == 'failed'
                                        ? coral
                                        : primaryBlue,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 9),

                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '$completedDays of $totalDays days completed',
                                    style: const TextStyle(
                                      color: textBlue,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),

                                  Text(
                                    currentStatus == 'failed'
                                        ? 'Challenge failed'
                                        : currentStatus == 'completed'
                                        ? 'Completed'
                                        : '$daysRemaining days left',
                                    style: TextStyle(
                                      color: currentStatus == 'failed'
                                          ? coral
                                          : currentStatus == 'completed'
                                          ? primaryBlue
                                          : coral,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                },
              );
            },
          ),

          const SizedBox(height: 25),

          // ======================================================
          // QUICK STATS
          // ======================================================
          animatedItem(
            index: 6,

            child: const Text(
              'Your Progress',

              style: TextStyle(
                color: darkBlue,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),

          const SizedBox(height: 10),

          FutureBuilder<List<Workout>>(
            future: _workoutService.getVerifiedWorkouts(),
            builder: (context, snapshot) {
              final workouts = snapshot.data ?? [];

              final totalSeconds = workouts.fold<int>(
                0,
                    (sum, workout) => sum + workout.durationSeconds,
              );

              final totalMinutes = totalSeconds ~/ 60;

              final activeTime = totalMinutes >= 60
                  ? '${(totalMinutes / 60).toStringAsFixed(1)}h'
                  : '${totalMinutes}m';

              return animatedItem(
                index: 7,
                child: Row(
                  children: [
                    Expanded(
                      child: _statCard(
                        icon: Icons.check_circle_outline_rounded,
                        value: '${workouts.length}',
                        label: 'Workouts',
                        iconColor: primaryBlue,
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: _statCard(
                        icon: Icons.timer_outlined,
                        value: activeTime,
                        label: 'Active Time',
                        iconColor: coral,
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: _statCard(
                        icon: Icons.local_fire_department_outlined,
                        value: '—',
                        label: 'Calories',
                        iconColor: darkBlue,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          const SizedBox(height: 25),

          // ======================================================
          // REWARD + WALLET
          // ======================================================
          animatedItem(
            index: 8,

            child: Row(
              children: [
                Expanded(child: _rewardCard()),

                const SizedBox(width: 12),

                Expanded(child: _walletCard()),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ======================================================
          // MOTIVATION
          // ======================================================
          animatedItem(
            index: 9,

            child: Container(
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
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // STAT CARD
  // ============================================================

  Widget _statCard({
    required IconData icon,
    required String value,
    required String label,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(18),

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
          Icon(icon, color: iconColor, size: 25),

          const SizedBox(height: 8),

          Text(
            value,

            style: const TextStyle(
              color: darkBlue,
              fontSize: 17,
              fontWeight: FontWeight.w900,
            ),
          ),

          const SizedBox(height: 3),

          Text(
            label,

            textAlign: TextAlign.center,

            style: const TextStyle(
              color: textBlue,
              fontSize: 9,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // REWARD CARD
  // ============================================================

  Widget _rewardCard() {
    return GestureDetector(
      onTap: () {
        showComingSoon('Rewards');
      },

      child: Container(
        padding: const EdgeInsets.all(16),

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
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Container(
              width: 42,
              height: 42,

              decoration: BoxDecoration(
                color: softCoral,
                borderRadius: BorderRadius.circular(13),
              ),

              child: const Icon(
                Icons.workspace_premium_rounded,
                color: coral,
                size: 24,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              'Rewards',

              style: TextStyle(
                color: darkBlue,
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),

            const SizedBox(height: 3),

            const Text(
              '12 earned',

              style: TextStyle(color: textBlue, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // WALLET CARD
  // ============================================================

  Widget _walletCard() {
    return GestureDetector(
      onTap: () {
        showComingSoon('Wallet');
      },

      child: Container(
        padding: const EdgeInsets.all(16),

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
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Container(
              width: 42,
              height: 42,

              decoration: BoxDecoration(
                color: lightBlue,
                borderRadius: BorderRadius.circular(13),
              ),

              child: const Icon(
                Icons.account_balance_wallet_rounded,
                color: primaryBlue,
                size: 23,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              'Wallet',

              style: TextStyle(
                color: darkBlue,
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),

            const SizedBox(height: 3),

            Text(
              '$walletCoins coins',

              style: const TextStyle(color: textBlue, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // BOTTOM NAVIGATION
  // ============================================================

  Widget _buildBottomNavigation() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,

        boxShadow: [
          BoxShadow(
            color: darkBlue.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),

      child: NavigationBar(
        backgroundColor: Colors.white,

        elevation: 0,

        selectedIndex: _selectedIndex,

        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });

          _animationController.forward(from: 0);
        },

        indicatorColor: primaryBlue.withOpacity(0.13),

        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              color: primaryBlue,
              fontSize: 10,
              fontWeight: FontWeight.w800,
            );
          }

          return const TextStyle(
            color: textBlue,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          );
        }),

        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),

            selectedIcon: Icon(Icons.home_rounded, color: primaryBlue),

            label: 'Home',
          ),

          NavigationDestination(
            icon: Icon(Icons.emoji_events_outlined),

            selectedIcon: Icon(Icons.emoji_events_rounded, color: primaryBlue),

            label: 'Challenges',
          ),

          NavigationDestination(
            icon: Icon(Icons.show_chart_outlined),

            selectedIcon: Icon(Icons.show_chart_rounded, color: primaryBlue),

            label: 'Progress',
          ),

          NavigationDestination(
            icon: Icon(Icons.account_balance_wallet_outlined),

            selectedIcon: Icon(
              Icons.account_balance_wallet_rounded,
              color: primaryBlue,
            ),

            label: 'Wallet',
          ),

          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),

            selectedIcon: Icon(Icons.person_rounded, color: primaryBlue),

            label: 'Profile',
          ),
        ],
      ),
    );
  }

  // ============================================================
  // PLACEHOLDER SCREENS
  // ============================================================

  Widget _buildPlaceholder(String title, IconData icon) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Container(
            width: 80,
            height: 80,

            decoration: BoxDecoration(
              color: primaryBlue.withOpacity(0.12),
              shape: BoxShape.circle,
            ),

            child: Icon(icon, color: primaryBlue, size: 40),
          ),

          const SizedBox(height: 18),

          Text(
            title,

            style: const TextStyle(
              color: darkBlue,
              fontSize: 23,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'This section is coming next.',
            style: TextStyle(color: textBlue, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
