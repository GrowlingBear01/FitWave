import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  static const Color backgroundColor = Color(0xFFF0FAFC);
  static const Color primaryBlue = Color(0xFF2CB8D1);
  static const Color lightBlue = Color(0xFFBDEEF4);
  static const Color darkBlue = Color(0xFF173F5F);
  static const Color textBlue = Color(0xFF315B73);
  static const Color coral = Color(0xFFFF8585);
  static const Color softCoral = Color(0xFFFFE2E2);

  final List<Map<String, dynamic>> notifications = const [
    {
      'title': 'Workout Completed 🎉',
      'message': 'Great job! You completed your Full Body workout.',
      'time': '10 minutes ago',
      'icon': Icons.fitness_center_rounded,
      'type': 'workout',
      'unread': true,
    },
    {
      'title': 'Streak Updated 🔥',
      'message': 'Amazing! You are now on a 7 day workout streak.',
      'time': '1 hour ago',
      'icon': Icons.local_fire_department_rounded,
      'type': 'streak',
      'unread': true,
    },
    {
      'title': 'Challenge Progress',
      'message': 'You completed 4 of 7 days in your current challenge.',
      'time': 'Yesterday',
      'icon': Icons.emoji_events_rounded,
      'type': 'challenge',
      'unread': false,
    },
    {
      'title': 'Coins Earned 💰',
      'message': 'You earned 20 coins for completing your workout.',
      'time': 'Yesterday',
      'icon': Icons.monetization_on_rounded,
      'type': 'reward',
      'unread': false,
    },
    {
      'title': 'Keep Going! 💪',
      'message': 'Complete today’s workout to maintain your streak.',
      'time': 'Sep 3',
      'icon': Icons.bolt_rounded,
      'type': 'motivation',
      'unread': false,
    },
    {
      'title': 'New Reward Available',
      'message': 'You are getting closer to unlocking your next reward.',
      'time': 'Sep 2',
      'icon': Icons.card_giftcard_rounded,
      'type': 'reward',
      'unread': false,
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
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: darkBlue),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: darkBlue,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('All notifications marked as read'),
                ),
              );
            },
            child: const Text(
              'Read all',
              style: TextStyle(
                color: primaryBlue,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: notifications.isEmpty
            ? _buildEmptyState()
            : SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeaderSummary(),

                    const SizedBox(height: 22),

                    const Text(
                      'Recent Notifications',
                      style: TextStyle(
                        color: darkBlue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 14),

                    ...notifications.map(
                      (notification) => _buildNotificationCard(notification),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildHeaderSummary() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [primaryBlue, Color(0xFF55C8D8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: primaryBlue.withOpacity(0.18),
            blurRadius: 15,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.20),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.notifications_active_rounded,
              color: Colors.white,
              size: 30,
            ),
          ),

          const SizedBox(width: 15),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Stay Updated',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Keep track of your workouts, streaks and rewards.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> notification) {
    final bool unread = notification['unread'] as bool;
    final String type = notification['type'] as String;

    Color iconBackground = lightBlue;
    Color iconColor = primaryBlue;

    if (type == 'streak') {
      iconBackground = softCoral;
      iconColor = coral;
    } else if (type == 'reward') {
      iconBackground = const Color(0xFFFFF0D9);
      iconColor = const Color(0xFFE59B22);
    } else if (type == 'challenge') {
      iconBackground = const Color(0xFFE7E2FF);
      iconColor = const Color(0xFF7565D8);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: unread ? Colors.white : Colors.white.withOpacity(0.75),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: unread
              ? primaryBlue.withOpacity(0.25)
              : lightBlue.withOpacity(0.65),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconBackground,
              shape: BoxShape.circle,
            ),
            child: Icon(
              notification['icon'] as IconData,
              color: iconColor,
              size: 23,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        notification['title'] as String,
                        style: const TextStyle(
                          color: darkBlue,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    if (unread)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: primaryBlue,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 5),

                Text(
                  notification['message'] as String,
                  style: const TextStyle(
                    color: textBlue,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 7),

                Text(
                  notification['time'] as String,
                  style: TextStyle(
                    color: textBlue.withOpacity(0.60),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 120, left: 20, right: 20),
        child: Column(
          children: [
            Icon(
              Icons.notifications_none_rounded,
              color: primaryBlue.withOpacity(0.55),
              size: 70,
            ),

            const SizedBox(height: 18),

            const Text(
              'No Notifications',
              style: TextStyle(
                color: darkBlue,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'You are all caught up! New updates will appear here.',
              textAlign: TextAlign.center,
              style: TextStyle(color: textBlue, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
