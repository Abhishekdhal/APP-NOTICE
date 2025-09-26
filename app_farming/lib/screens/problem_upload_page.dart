import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../l10n/app_localizations.dart';

class ProblemUploadPage extends StatefulWidget {
  const ProblemUploadPage({super.key});

  @override
  State<ProblemUploadPage> createState() => _ProblemUploadPageState();
}

class _ProblemUploadPageState extends State<ProblemUploadPage> {
  File? _image;
  final picker = ImagePicker();
  final TextEditingController _descController = TextEditingController();
  bool _loading = false;

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> uploadImage(AppLocalizations l10n) async {
    if (_image == null || _descController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.addDescriptionAndImage)),
      );
      return;
    }

    setState(() => _loading = true);

    try {
      final user = Supabase.instance.client.auth.currentUser;
      final fileName =
          "problem_${DateTime.now().millisecondsSinceEpoch}.jpg";

      // 🔹 Upload to Storage
      await Supabase.instance.client.storage
          .from('problems')
          .upload(fileName, _image!);

      // 🔹 Get public URL
      final publicUrl = Supabase.instance.client.storage
          .from('problems')
          .getPublicUrl(fileName);

      // 🔹 Insert metadata into DB
      await Supabase.instance.client.from('problems').insert({
        'user_id': user?.id ?? 'guest', // fallback if not logged in
        'description': _descController.text,
        'image_url': publicUrl,
        'created_at': DateTime.now().toIso8601String(),
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.problemReportedSuccess)),
      );

      setState(() {
        _image = null;
        _descController.clear();
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("${l10n.error}$e")),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.problemDetectorTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _descController,
              decoration: InputDecoration(
                labelText: l10n.problemDescription,
                border: const OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            _image == null
                ? Text(l10n.noImageSelected)
                : Image.file(_image!, height: 200),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: pickImage,
              child: Text(l10n.takeChooseImage),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _loading ? null : () => uploadImage(l10n),
              child: _loading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(l10n.upload),
            ),
          ],
        ),
      ),
    );
  }
}
