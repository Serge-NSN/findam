import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactInfoScreen extends StatelessWidget {
  final String contactId;

  const ContactInfoScreen({super.key, required this.contactId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Information'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('reported_items').doc(contactId).get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data != null) {
              final data = snapshot.data!.data() as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Phone Number: ${data['phone_number']}',
                        style: TextStyle(fontSize: 18)),
                    // Add more information if needed
                  ],
                ),
              );
            } else {
              return Center(child: Text('No data found'));
            }
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
