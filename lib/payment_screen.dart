import 'package:findam/conatact_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentScreen extends StatefulWidget {
  final String returnUrl;
  final String contactId;

  const PaymentScreen({super.key, required this.returnUrl, required this.contactId});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: WebView(
        initialUrl: 'https://link.tranzak.net/vLQkE4WSd9nybjy6A',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller = webViewController;
        },
        navigationDelegate: (NavigationRequest request) {
          if (request.url.startsWith(widget.returnUrl)) {
            // Extract the contactId from the URL
            final contactId = Uri.parse(request.url).queryParameters['contactId'];
            if (contactId != null) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => ContactInfoScreen(contactId: contactId),
                ),
              );
            }
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    );
  }
}
