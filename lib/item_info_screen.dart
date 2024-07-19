import 'package:findam/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ItemInfoScreen extends StatelessWidget {
  final String imageUrl;
  final String itemName;
  final String description;
  final String location;
  final String foundDate;
  final String phoneNumber;
  final String contactId; // Add this to store the document ID

  const ItemInfoScreen({
    super.key,
    required this.imageUrl,
    required this.itemName,
    required this.description,
    required this.location,
    required this.foundDate,
    required this.phoneNumber,
    required this.contactId,
  });

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
                      child: Image.network(
                        imageUrl,
                        width: 167,
                        height: 135,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 25),
                    Text(
                      itemName,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 0.5,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      description,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w100),
                    ),
                    const SizedBox(height: 10),
                    const Divider(
                      color: Colors.grey,
                      thickness: 0.5,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Location: $location',
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Found Date: ${DateTime.parse(foundDate).toLocal().toString().split(' ')[0]}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 150),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(13)),
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromRGBO(254, 235, 234, 1)),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WebView(
                                initialUrl:
                                    'https://collections.tranzak.me/pay/payment-link/PLFSLXINS85Z6GYT2S',
                                javascriptMode: JavascriptMode
                                    .unrestricted, // Enable JavaScript
                                onWebViewCreated:
                                    (WebViewController controller) {
                                  // You can interact with the WebView using the controller
                                },
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'Pay to Collect',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF031B01),
                            fontSize: 20,
                          ),
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

class WebViewContainer extends StatelessWidget {
  final String url;

  const WebViewContainer({required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tranzak Link'),
      ),
      body: WebView(
        initialUrl: url,
      ),
    );
  }
}
