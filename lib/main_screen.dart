import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 1, 10, 20),
      child: const Text(
        'Start Screen',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
