import 'package:findam/sign_in_screen.dart';
import 'package:findam/widgets/item-card.dart';

import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DefaultTextStyle.merge(
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w200,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Text on the left with a width of 170
              const SizedBox(
                width: 190,
                child: Padding(
                  padding: EdgeInsets.only(left: 5.0),
                  child: Text(
                    'What personal item has been misplaced?',
                    style: TextStyle(fontSize: 16),
                    softWrap: true, // Allow text to wrap
                  ),
                ),
              ),
              // Rounded image on the right with a white border
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  width: 60,
                  height: 60,
                  child: const Center(
                    child: Image(
                      image: AssetImage('assets/img/nsn-profile-pic.jpeg'),
                      fit: BoxFit.cover, // Adjust the fit as needed
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        TextField(
          decoration: InputDecoration(
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
                Container(
                  padding: const EdgeInsetsDirectional.all(20.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEEBEA),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Lost or found an item?',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 150,
                            child:
                                Text('You can post it here for easy recovery'),
                          ),
                          OutlinedButton(
                            onPressed: () {
                              // Add your button click logic here
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  style: BorderStyle.solid,
                                  width: 1.5,
                                  color: Color(0xFFED873D)),
                            ),
                            child: const Text(
                              'Post',
                              style: TextStyle(color: Colors.black),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                const Text(
                  'Recent items reported',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 12),
                GridView.count(
                  shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  primary: false,
                  // padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: List.generate(8, (index) => const ItemCard()),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
