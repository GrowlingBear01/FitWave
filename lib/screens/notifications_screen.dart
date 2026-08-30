import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Colors.black,
      ),
      body: const Center(
        child: Text(
          'Notifications',
          style: TextStyle(color: Colors.blue, fontSize: 24),
        ),
      ),
    );
  }
}
