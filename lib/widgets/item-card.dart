import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to another screen or perform any action here
        // when the column is tapped.
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.asset(
                  'assets/img/bag.jpg',
                  width: 167,
                  height: 135,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Lost',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
              height: 8), // Add some space between the image and the text
          const Text(
            'Black School Bag',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          const Text(
            'May 17, 2024',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w200,
              color: Colors.white,
            ),
          ),
          const Text.rich(
            TextSpan(
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w100,
                color: Colors.white,
              ),
              children: [
                WidgetSpan(
                  child: Icon(
                    Icons.location_on,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
                TextSpan(text: ' Mile 4 Nkwen'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
