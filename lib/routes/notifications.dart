import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key? key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            'Notifications',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          // const SizedBox(height: 16.0), // Add some spacing
          Expanded(
            child: Center(
              child: Text(
                'No new notifications',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Color(0xFFB1B1B1),
                  fontWeight: FontWeight.w100,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
