import 'package:flutter/material.dart';

class DifficultyScreen extends StatelessWidget {
  const DifficultyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Difficulty'),
        backgroundColor: Colors.black,
      ),
      body: const Center(
        child: Text(
          'Difficulty Selection',
          style: TextStyle(color: Colors.blue, fontSize: 24),
        ),
      ),
    );
  }
}
