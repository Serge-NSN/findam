import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findam/item_info_screen.dart';
import 'package:findam/sign_in_screen.dart';
import 'package:findam/widgets/item_card.dart';
import 'package:findam/home_screen.dart';

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
                  const Text(
                    'Lost items',
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 12),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('reported_items')
                        .orderBy('found_date', descending: true)
                        .limit(20)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final items = snapshot.data!.docs;

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ItemInfoScreen(
                                    imageUrl: item['image_url'],
                                    itemName: item['item_name'],
                                    description: item['description'],
                                    location: item['location'],
                                    foundDate: item['found_date'],
                                    phoneNumber: item['phone_number'], contactId: '',
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child: Image.network(
                                        item['image_url'],
                                        width: 167,
                                        height: 135,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      top: 8,
                                      right: 8,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: const Text(
                                          'Found',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  item['item_name'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  item['found_date'] != null
                                      ? DateTime.parse(item['found_date'])
                                          .toLocal()
                                          .toString()
                                          .split(' ')[0]
                                      : '',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w200,
                                    color: Colors.white,
                                  ),
                                ),
                                Text.rich(
                                  TextSpan(
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w100,
                                      color: Colors.white,
                                    ),
                                    children: [
                                      const WidgetSpan(
                                        child: Icon(
                                          Icons.location_on,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                      TextSpan(text: item['location']),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
