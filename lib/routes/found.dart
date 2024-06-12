import 'package:findam/item_info_screen.dart';
import 'package:findam/sign_in_screen.dart';
import 'package:findam/widgets/item_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FoundItems extends StatelessWidget {
  const FoundItems({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Found Items',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          TextField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(12),
              filled: true,
              fillColor: const Color(0xFFF8FBFF),
              hintText: '   Search for misplaced items',
              hintStyle: const TextStyle(fontWeight: FontWeight.w100),
              prefixIcon: const Icon(
                Icons.search,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15.0,
                  ),
                  const SizedBox(height: 12),
                  GridView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.75,
                    ),
                    children: const [
                      ItemCard(),
                      ItemCard(),
                      ItemCard(),
                      ItemCard(),
                      ItemCard(),
                      ItemCard(),
                      ItemCard(),
                      ItemCard(),
                      ItemCard(),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
