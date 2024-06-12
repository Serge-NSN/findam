import 'package:findam/home_screen.dart';
import 'package:findam/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class ItemInfoScreen extends StatelessWidget {
  const ItemInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF101010),
      ),
      body: Container(
        color: const Color(0xFF101010),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // const SizedBox(height: 10),
            const Align(
              alignment: Alignment.topLeft,
              child: Center(
                child: Text(
                  'Does this belong to you?',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    const SizedBox(height: 25),
                    const Text(
                      'Missing Handbag',
                      style: TextStyle(color: Colors.white),
                    ),
                    const Divider(
                      color: Colors.grey, // The color of the divider
                      thickness: 0.5, // The thickness of the line
                      indent:
                          0, // Empty space to the leading edge of the divider.
                      endIndent:
                          0, // Empty space to the trailing edge of the divider.
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Found it in a taxi. Sit volutpat urna elit faucibus urna. Ultricies ultrices imperdiet.',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w100),
                    ),
                    const SizedBox(height: 10),
                    const Divider(
                      color: Colors.grey, // The color of the divider
                      thickness: 0.5, // The thickness of the line
                      indent:
                          0, // Empty space to the leading edge of the divider.
                      endIndent:
                          0, // Empty space to the trailing edge of the divider.
                    ),
                    const SizedBox(height: 150),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(13)),
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromRGBO(254, 235, 234, 1))),
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => const HomeScreen()),
                          // );
                        },
                        child: const Text(
                          'Pay to Collect',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF031B01),
                              fontSize: 20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
