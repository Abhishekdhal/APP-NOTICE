import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/cloud_firestore_service.dart';

class AdminFeedbackPage extends StatelessWidget {
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("All Feedback")),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getFeedbackStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final feedbackDocs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: feedbackDocs.length,
            itemBuilder: (context, index) {
              var data = feedbackDocs[index].data() as Map<String, dynamic>;

              return Card(
                child: ListTile(
                  title: Text(data["name"] ?? "Anonymous"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data["message"] ?? ""),
                      if (data["imageUrl"] != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Image.network(data["imageUrl"], height: 120),
                        ),
                    ],
                  ),
                  trailing: Text(
                    data["timestamp"] != null
                        ? (data["timestamp"] as Timestamp)
                            .toDate()
                            .toString()
                        : "",
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
