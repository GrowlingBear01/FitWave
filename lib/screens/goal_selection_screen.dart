import 'package:flutter/material.dart';

class GoalSelectionScreen extends StatelessWidget {
  const GoalSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _screen('Goal Selection');
  }
}

Widget _screen(String title) {
  return Scaffold(
    backgroundColor: Colors.black,
    appBar: AppBar(title: Text(title), backgroundColor: Colors.black),
    body: Center(
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.blue,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
