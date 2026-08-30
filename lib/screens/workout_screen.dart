import 'package:flutter/material.dart';

class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Workout'),
        backgroundColor: Colors.black,
      ),
      body: const Center(
        child: Text(
          'Workout',
          style: TextStyle(color: Colors.blue, fontSize: 24),
        ),
      ),
    );
  }
}
