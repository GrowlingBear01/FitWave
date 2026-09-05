import 'package:flutter/material.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

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
                      Icons.account_balance_wallet_rounded,
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
                          'My Wallet',
                          style: TextStyle(
                            color: darkBlue,
                            fontSize: 21,
                            fontWeight: FontWeight.w800,
                          ),
                        ),

                        SizedBox(height: 3),

                        Text(
                          'Manage your FitWave coins',
                          style: TextStyle(color: textBlue, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // ==================================================
              // WALLET BALANCE
              // ==================================================
              _buildWalletBalanceCard(),

              const SizedBox(height: 25),

              // ==================================================
              // WALLET STATS
              // ==================================================
              const Text(
                'Wallet Overview',
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
                    child: _buildWalletStat(
                      icon: Icons.add_circle_outline_rounded,
                      value: '620',
                      label: 'Earned',
                      iconColor: primaryBlue,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: _buildWalletStat(
                      icon: Icons.remove_circle_outline_rounded,
                      value: '200',
                      label: 'Spent',
                      iconColor: coral,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // ==================================================
              // HOW TO EARN
              // ==================================================
              const Text(
                'How to Earn Coins',
                style: TextStyle(
                  color: darkBlue,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 12),

              _buildEarnMethod(
                icon: Icons.fitness_center_rounded,
                title: 'Complete a Workout',
                subtitle: 'Earn 20 coins per workout',
                coins: '+20',
              ),

              const SizedBox(height: 10),

              _buildEarnMethod(
                icon: Icons.local_fire_department_rounded,
                title: 'Maintain Your Streak',
                subtitle: 'Earn 10 bonus coins per day',
                coins: '+10',
              ),

              const SizedBox(height: 10),

              _buildEarnMethod(
                icon: Icons.emoji_events_rounded,
                title: 'Complete a Challenge',
                subtitle: 'Earn bonus coins for challenges',
                coins: '+50',
              ),

              const SizedBox(height: 25),

              // ==================================================
              // REDEEM REWARDS
              // ==================================================
              const Text(
                'Redeem Rewards',
                style: TextStyle(
                  color: darkBlue,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 12),

              _buildRedeemCard(
                icon: Icons.workspace_premium_rounded,
                title: 'Premium Badge',
                description: 'Unlock a special profile badge',
                coins: '150',
              ),

              const SizedBox(height: 10),

              _buildRedeemCard(
                icon: Icons.local_fire_department_rounded,
                title: 'Streak Booster',
                description: 'Protect your streak for one day',
                coins: '200',
              ),

              const SizedBox(height: 10),

              _buildRedeemCard(
                icon: Icons.card_giftcard_rounded,
                title: 'Mystery Reward',
                description: 'Unlock a surprise fitness reward',
                coins: '300',
              ),

              const SizedBox(height: 25),

              // ==================================================
              // RECENT TRANSACTIONS
              // ==================================================
              const Text(
                'Recent Transactions',
                style: TextStyle(
                  color: darkBlue,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 12),

              _buildTransaction(
                icon: Icons.fitness_center_rounded,
                title: 'Workout Completed',
                date: 'Today',
                amount: '+20',
                isCredit: true,
              ),

              const SizedBox(height: 10),

              _buildTransaction(
                icon: Icons.local_fire_department_rounded,
                title: 'Streak Bonus',
                date: 'Yesterday',
                amount: '+10',
                isCredit: true,
              ),

              const SizedBox(height: 10),

              _buildTransaction(
                icon: Icons.card_giftcard_rounded,
                title: 'Reward Redeemed',
                date: 'Sep 2, 2026',
                amount: '-150',
                isCredit: false,
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
  // WALLET BALANCE CARD
  // ============================================================

  Widget _buildWalletBalanceCard() {
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
              Icon(
                Icons.account_balance_wallet_rounded,
                color: Colors.white,
                size: 23,
              ),

              SizedBox(width: 9),

              Text(
                'Current Balance',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          const Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                Icons.monetization_on_rounded,
                color: Colors.white,
                size: 32,
              ),

              SizedBox(width: 8),

              Text(
                '420',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 43,
                  fontWeight: FontWeight.w900,
                ),
              ),

              SizedBox(width: 6),

              Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Text(
                  'coins',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),

            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(10),
            ),

            child: const Text(
              'Keep working out to earn more! 💪',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // WALLET STAT
  // ============================================================

  Widget _buildWalletStat({
    required IconData icon,
    required String value,
    required String label,
    required Color iconColor,
  }) {
    return Container(
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
            width: 43,
            height: 43,

            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.11),
              borderRadius: BorderRadius.circular(13),
            ),

            child: Icon(icon, color: iconColor, size: 22),
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

                const SizedBox(height: 3),

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
  // EARN METHOD
  // ============================================================

  Widget _buildEarnMethod({
    required IconData icon,
    required String title,
    required String subtitle,
    required String coins,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),

        boxShadow: [
          BoxShadow(
            color: darkBlue.withOpacity(0.045),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,

            decoration: BoxDecoration(
              color: lightBlue,
              borderRadius: BorderRadius.circular(13),
            ),

            child: Icon(icon, color: primaryBlue, size: 23),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: darkBlue,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  subtitle,
                  style: const TextStyle(color: textBlue, fontSize: 10),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),

            decoration: BoxDecoration(
              color: const Color(0xFFE8F8FA),
              borderRadius: BorderRadius.circular(10),
            ),

            child: Text(
              coins,
              style: const TextStyle(
                color: primaryBlue,
                fontSize: 12,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // REDEEM CARD
  // ============================================================

  Widget _buildRedeemCard({
    required IconData icon,
    required String title,
    required String description,
    required String coins,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),

        boxShadow: [
          BoxShadow(
            color: darkBlue.withOpacity(0.045),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Row(
        children: [
          Container(
            width: 47,
            height: 47,

            decoration: BoxDecoration(
              color: softCoral,
              borderRadius: BorderRadius.circular(13),
            ),

            child: Icon(icon, color: coral, size: 23),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: darkBlue,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  description,
                  style: const TextStyle(color: textBlue, fontSize: 10),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),

            decoration: BoxDecoration(
              color: lightBlue,
              borderRadius: BorderRadius.circular(10),
            ),

            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.monetization_on_rounded,
                  color: primaryBlue,
                  size: 14,
                ),

                const SizedBox(width: 4),

                Text(
                  coins,
                  style: const TextStyle(
                    color: darkBlue,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
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
  // TRANSACTION
  // ============================================================

  Widget _buildTransaction({
    required IconData icon,
    required String title,
    required String date,
    required String amount,
    required bool isCredit,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),

        boxShadow: [
          BoxShadow(
            color: darkBlue.withOpacity(0.045),
            blurRadius: 12,
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
              color: isCredit ? lightBlue : softCoral,
              borderRadius: BorderRadius.circular(12),
            ),

            child: Icon(icon, color: isCredit ? primaryBlue : coral, size: 21),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: darkBlue,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  date,
                  style: const TextStyle(color: textBlue, fontSize: 9),
                ),
              ],
            ),
          ),

          Text(
            amount,
            style: TextStyle(
              color: isCredit ? primaryBlue : coral,
              fontSize: 14,
              fontWeight: FontWeight.w900,
            ),
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
              'Complete workouts, maintain your streak, and earn more coins! 🪙',
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
