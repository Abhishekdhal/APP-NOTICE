import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/cloud_firestore_service.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final _nameController = TextEditingController();
  final _messageController = TextEditingController();
  final FirestoreService firestoreService = FirestoreService();

  File? _selectedImage;

  /// ✅ Pick image from gallery/camera
  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _selectedImage = File(picked.path);
      });
    }
  }

  /// ✅ Submit feedback
  void _submitFeedback() async {
    if (_nameController.text.isNotEmpty && _messageController.text.isNotEmpty) {
      String? imageUrl;
      if (_selectedImage != null) {
        imageUrl = await firestoreService.uploadImage(_selectedImage!);
      }

      await firestoreService.addFeedback(
        _nameController.text,
        _messageController.text,
        imageUrl: imageUrl,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("✅ Feedback submitted")),
      );

      _nameController.clear();
      _messageController.clear();
      setState(() {
        _selectedImage = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Feedback")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Your Name"),
              ),
              TextField(
                controller: _messageController,
                decoration: InputDecoration(labelText: "Your Feedback"),
              ),
              SizedBox(height: 20),

              // Image picker preview
              _selectedImage != null
                  ? Image.file(_selectedImage!, height: 150)
                  : Text("No image selected"),

              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: Icon(Icons.photo),
                label: Text("Upload Photo"),
              ),
              SizedBox(height: 20),

              ElevatedButton(
                onPressed: _submitFeedback,
                child: Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
