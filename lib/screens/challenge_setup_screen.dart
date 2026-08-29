import 'package:flutter/material.dart';

class ChallengeSetupScreen extends StatelessWidget {
  const ChallengeSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Challenge Setup'),
        backgroundColor: Colors.black,
      ),
      body: const Center(
        child: Text(
          'Challenge Setup',
          style: TextStyle(color: Colors.blue, fontSize: 24),
        ),
      ),
    );
  }
}
