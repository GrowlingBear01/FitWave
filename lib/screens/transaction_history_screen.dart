import 'package:flutter/material.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  static const Color backgroundColor = Color(0xFFF0FAFC);
  static const Color primaryBlue = Color(0xFF2CB8D1);
  static const Color lightBlue = Color(0xFFBDEEF4);
  static const Color darkBlue = Color(0xFF173F5F);
  static const Color textBlue = Color(0xFF315B73);
  static const Color coral = Color(0xFFFF8585);
  static const Color softCoral = Color(0xFFFFE2E2);

  String selectedFilter = 'All';

  final List<Map<String, dynamic>> transactions = [
    {
      'title': 'Workout Completed',
      'description': 'Full Body Strength',
      'date': 'Today, 9:30 AM',
      'amount': '+20',
      'type': 'Earned',
      'icon': Icons.fitness_center_rounded,
    },
    {
      'title': 'Streak Bonus',
      'description': '7 Day Streak',
      'date': 'Today, 8:00 AM',
      'amount': '+10',
      'type': 'Earned',
      'icon': Icons.local_fire_department_rounded,
    },
    {
      'title': 'Challenge Completed',
      'description': '7 Day Fitness Challenge',
      'date': 'Sep 4, 6:45 PM',
      'amount': '+50',
      'type': 'Earned',
      'icon': Icons.emoji_events_rounded,
    },
    {
      'title': 'Reward Redeemed',
      'description': 'Premium Badge',
      'date': 'Sep 3, 7:20 PM',
      'amount': '-150',
      'type': 'Spent',
      'icon': Icons.redeem_rounded,
    },
    {
      'title': 'Workout Completed',
      'description': 'Upper Body Workout',
      'date': 'Sep 3, 8:30 AM',
      'amount': '+20',
      'type': 'Earned',
      'icon': Icons.fitness_center_rounded,
    },
    {
      'title': 'Streak Bonus',
      'description': '5 Day Streak',
      'date': 'Sep 2, 7:45 AM',
      'amount': '+10',
      'type': 'Earned',
      'icon': Icons.local_fire_department_rounded,
    },
    {
      'title': 'Reward Redeemed',
      'description': 'Streak Booster',
      'date': 'Sep 1, 6:15 PM',
      'amount': '-200',
      'type': 'Spent',
      'icon': Icons.redeem_rounded,
    },
  ];

  List<Map<String, dynamic>> get filteredTransactions {
    if (selectedFilter == 'All') {
      return transactions;
    }

    return transactions
        .where((transaction) => transaction['type'] == selectedFilter)
        .toList();
  }

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
          'Transaction History',
          style: TextStyle(
            color: darkBlue,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBalanceCard(),

              const SizedBox(height: 24),

              const Text(
                'Transactions',
                style: TextStyle(
                  color: darkBlue,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 14),

              _buildFilterButtons(),

              const SizedBox(height: 18),

              if (filteredTransactions.isEmpty)
                _buildEmptyState()
              else
                ...filteredTransactions.map(
                  (transaction) => _buildTransactionCard(transaction),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
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
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.20),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.account_balance_wallet_rounded,
              color: Colors.white,
              size: 30,
            ),
          ),

          const SizedBox(width: 16),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Current Balance',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                SizedBox(height: 4),
                Text(
                  '420 Coins',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButtons() {
    final filters = ['All', 'Earned', 'Spent'];

    return Row(
      children: filters.map((filter) {
        final bool isSelected = selectedFilter == filter;

        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: filter == filters.last ? 0 : 8),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedFilter = filter;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? primaryBlue : Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isSelected ? primaryBlue : lightBlue,
                  ),
                ),
                child: Center(
                  child: Text(
                    filter,
                    style: TextStyle(
                      color: isSelected ? Colors.white : textBlue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTransactionCard(Map<String, dynamic> transaction) {
    final bool isEarned = transaction['type'] == 'Earned';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: lightBlue.withOpacity(0.7)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isEarned ? lightBlue : softCoral,
              shape: BoxShape.circle,
            ),
            child: Icon(
              transaction['icon'],
              color: isEarned ? primaryBlue : coral,
              size: 23,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction['title'],
                  style: const TextStyle(
                    color: darkBlue,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  transaction['description'],
                  style: const TextStyle(color: textBlue, fontSize: 12),
                ),

                const SizedBox(height: 4),

                Text(
                  transaction['date'],
                  style: TextStyle(
                    color: textBlue.withOpacity(0.65),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          Text(
            '${transaction['amount']}',
            style: TextStyle(
              color: isEarned ? primaryBlue : coral,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(width: 4),

          Text(
            'coins',
            style: TextStyle(color: textBlue.withOpacity(0.65), fontSize: 10),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Icon(
            Icons.receipt_long_rounded,
            size: 55,
            color: primaryBlue.withOpacity(0.5),
          ),

          const SizedBox(height: 15),

          const Text(
            'No Transactions Found',
            style: TextStyle(
              color: darkBlue,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Your transactions will appear here.',
            textAlign: TextAlign.center,
            style: TextStyle(color: textBlue, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
