import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ProblemUploadPage extends StatefulWidget {
  const ProblemUploadPage({super.key});

  @override
  State<ProblemUploadPage> createState() => _ProblemUploadPageState();
}

class _ProblemUploadPageState extends State<ProblemUploadPage> {
  File? _image;
  final picker = ImagePicker();

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    ); // or gallery
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> uploadImage() async {
    if (_image == null) return;

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
        "http://your-server.com/upload",
      ), // replace with your backend URL
    );

    request.files.add(await http.MultipartFile.fromPath('image', _image!.path));

    var response = await request.send();

    if (!mounted) return;
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Image uploaded successfully ✅")));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Upload failed ❌")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Problem Detector")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image == null
                ? const Text("No image selected")
                : Image.file(_image!, height: 200),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: pickImage,
              child: const Text("Take/Choose Image"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: uploadImage, child: const Text("Upload")),
          ],
        ),
      ),
    );
  }
}
