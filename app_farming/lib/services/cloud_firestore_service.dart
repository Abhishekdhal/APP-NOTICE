import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirestoreService {
  final CollectionReference feedbackCollection =
      FirebaseFirestore.instance.collection("feedbacks");

  /// ✅ Upload image to Firebase Storage
  Future<String?> uploadImage(File imageFile) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = FirebaseStorage.instance.ref().child("feedback_images/$fileName.jpg");

      await ref.putFile(imageFile);
      String downloadURL = await ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print("Image upload error: $e");
      return null;
    }
  }

  /// ✅ Add feedback with optional image
  Future<void> addFeedback(String name, String message, {String? imageUrl}) async {
    try {
      await feedbackCollection.add({
        "name": name,
        "message": message,
        "imageUrl": imageUrl,
        "timestamp": FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception("Error adding feedback: $e");
    }
  }

  /// ✅ Get feedbacks in real-time
  Stream<QuerySnapshot> getFeedbackStream() {
    return feedbackCollection.orderBy("timestamp", descending: true).snapshots();
  }
}
