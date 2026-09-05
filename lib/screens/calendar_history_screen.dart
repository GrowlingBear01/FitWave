import 'package:flutter/material.dart';

class CalendarHistoryScreen extends StatefulWidget {
  const CalendarHistoryScreen({super.key});

  @override
  State<CalendarHistoryScreen> createState() => _CalendarHistoryScreenState();
}

class _CalendarHistoryScreenState extends State<CalendarHistoryScreen> {
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

  // September 2026
  int selectedDay = 5;

  final Set<int> completedDays = {
    1,
    2,
    3,
    4,
    5,
    8,
    10,
    11,
    15,
    17,
    19,
    22,
    24,
    27,
  };

  final Set<int> streakDays = {1, 2, 3, 4, 5};

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: darkBlue,
            size: 20,
          ),
        ),

        title: const Text(
          'Calendar & History',
          style: TextStyle(
            color: darkBlue,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),

          padding: const EdgeInsets.fromLTRB(20, 5, 20, 30),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              _buildCalendarCard(),

              const SizedBox(height: 25),

              const Text(
                'Monthly Summary',
                style: TextStyle(
                  color: darkBlue,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 12),

              _buildMonthlySummary(),

              const SizedBox(height: 25),

              const Text(
                'Workout History',
                style: TextStyle(
                  color: darkBlue,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 12),

              _buildWorkoutHistory(),

              const SizedBox(height: 25),

              _buildLegend(),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // CALENDAR
  // ============================================================

  Widget _buildCalendarCard() {
    const int daysInMonth = 30;

    // September 1, 2026 is Tuesday.
    const int firstWeekday = 2;

    final List<Widget> calendarDays = [];

    for (int i = 0; i < firstWeekday; i++) {
      calendarDays.add(const SizedBox());
    }

    for (int day = 1; day <= daysInMonth; day++) {
      calendarDays.add(_buildCalendarDay(day));
    }

    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),

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
          // ==================================================
          // MONTH HEADER
          // ==================================================
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Container(
                width: 42,
                height: 42,

                decoration: BoxDecoration(
                  color: lightBlue,
                  borderRadius: BorderRadius.circular(13),
                ),

                child: const Icon(
                  Icons.calendar_month_rounded,
                  color: primaryBlue,
                  size: 23,
                ),
              ),

              const Column(
                children: [
                  Text(
                    'September',
                    style: TextStyle(
                      color: darkBlue,
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  SizedBox(height: 2),

                  Text(
                    '2026',
                    style: TextStyle(
                      color: textBlue,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 8,
                ),

                decoration: BoxDecoration(
                  color: softCoral,
                  borderRadius: BorderRadius.circular(11),
                ),

                child: const Text(
                  '14 workouts',
                  style: TextStyle(
                    color: coral,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          // ==================================================
          // WEEK DAYS
          // ==================================================
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,

            children: const [
              _WeekDay(label: 'M'),
              _WeekDay(label: 'T'),
              _WeekDay(label: 'W'),
              _WeekDay(label: 'T'),
              _WeekDay(label: 'F'),
              _WeekDay(label: 'S'),
              _WeekDay(label: 'S'),
            ],
          ),

          const SizedBox(height: 10),

          // ==================================================
          // CALENDAR GRID
          // ==================================================
          GridView.count(
            crossAxisCount: 7,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),

            mainAxisSpacing: 8,
            crossAxisSpacing: 5,

            children: calendarDays,
          ),
        ],
      ),
    );
  }

  // ============================================================
  // CALENDAR DAY
  // ============================================================

  Widget _buildCalendarDay(int day) {
    final bool completed = completedDays.contains(day);
    final bool streak = streakDays.contains(day);
    final bool selected = selectedDay == day;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDay = day;
        });
      },

      child: Container(
        decoration: BoxDecoration(
          color: selected
              ? primaryBlue
              : completed
              ? lightBlue
              : Colors.transparent,

          borderRadius: BorderRadius.circular(11),

          border: Border.all(
            color: selected
                ? primaryBlue
                : completed
                ? primaryBlue.withOpacity(0.15)
                : Colors.transparent,
          ),
        ),

        child: Stack(
          alignment: Alignment.center,

          children: [
            Text(
              '$day',
              style: TextStyle(
                color: selected
                    ? Colors.white
                    : completed
                    ? darkBlue
                    : textBlue,

                fontSize: 11,

                fontWeight: selected || completed
                    ? FontWeight.w800
                    : FontWeight.w500,
              ),
            ),

            if (streak && !selected)
              Positioned(
                bottom: 4,
                child: Container(
                  width: 4,
                  height: 4,

                  decoration: const BoxDecoration(
                    color: coral,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // MONTHLY SUMMARY
  // ============================================================

  Widget _buildMonthlySummary() {
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

      child: Row(
        children: [
          Expanded(
            child: _summaryItem(
              icon: Icons.check_circle_rounded,
              value: '14',
              label: 'Completed',
              color: primaryBlue,
            ),
          ),

          Container(width: 1, height: 55, color: const Color(0xFFE4EEF0)),

          Expanded(
            child: _summaryItem(
              icon: Icons.local_fire_department_rounded,
              value: '7',
              label: 'Best Streak',
              color: coral,
            ),
          ),

          Container(width: 1, height: 55, color: const Color(0xFFE4EEF0)),

          Expanded(
            child: _summaryItem(
              icon: Icons.timer_rounded,
              value: '5.2h',
              label: 'Active Time',
              color: darkBlue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryItem({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, color: color, size: 23),

        const SizedBox(height: 7),

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
    );
  }

  // ============================================================
  // WORKOUT HISTORY
  // ============================================================

  Widget _buildWorkoutHistory() {
    return Column(
      children: [
        _historyItem(
          day: 'Today',
          date: 'September 5',
          title: 'Full Body Strength',
          details: '20 min • 6 exercises',
          icon: Icons.fitness_center_rounded,
          color: primaryBlue,
        ),

        const SizedBox(height: 10),

        _historyItem(
          day: 'Yesterday',
          date: 'September 4',
          title: 'Upper Body Workout',
          details: '18 min • 5 exercises',
          icon: Icons.accessibility_new_rounded,
          color: coral,
        ),

        const SizedBox(height: 10),

        _historyItem(
          day: 'September 3',
          date: 'September 3',
          title: 'Core & Abs',
          details: '15 min • 4 exercises',
          icon: Icons.sports_gymnastics_rounded,
          color: darkBlue,
        ),

        const SizedBox(height: 10),

        _historyItem(
          day: 'September 2',
          date: 'September 2',
          title: 'Lower Body',
          details: '22 min • 6 exercises',
          icon: Icons.directions_run_rounded,
          color: primaryBlue,
        ),
      ],
    );
  }

  // ============================================================
  // HISTORY ITEM
  // ============================================================

  Widget _historyItem({
    required String day,
    required String date,
    required String title,
    required String details,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(19),

        boxShadow: [
          BoxShadow(
            color: darkBlue.withOpacity(0.045),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,

            decoration: BoxDecoration(
              color: color.withOpacity(0.11),
              borderRadius: BorderRadius.circular(14),
            ),

            child: Icon(icon, color: color, size: 24),
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
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  details,
                  style: const TextStyle(color: textBlue, fontSize: 10),
                ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,

            children: [
              Text(
                day,
                style: const TextStyle(
                  color: darkBlue,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 5),

              const Icon(
                Icons.check_circle_rounded,
                color: primaryBlue,
                size: 18,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // LEGEND
  // ============================================================

  Widget _buildLegend() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: const Color(0xFFE5F7FA),
        borderRadius: BorderRadius.circular(18),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          _legendItem(color: lightBlue, text: 'Workout completed'),

          const SizedBox(width: 18),

          _legendItem(color: coral, text: 'Streak day'),
        ],
      ),
    );
  }

  Widget _legendItem({required Color color, required String text}) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,

          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),

        const SizedBox(width: 6),

        Text(
          text,
          style: const TextStyle(
            color: textBlue,
            fontSize: 9,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// ================================================================
// WEEK DAY WIDGET
// ================================================================

class _WeekDay extends StatelessWidget {
  final String label;

  const _WeekDay({required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,

      child: Text(
        label,
        textAlign: TextAlign.center,

        style: const TextStyle(
          color: Color(0xFF315B73),
          fontSize: 10,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
