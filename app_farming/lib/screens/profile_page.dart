import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart'; // for FarmersApp.setLocale

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  String? _selectedLanguage;

  // Supported languages
  final List<Map<String, String>> languages = [
    {"code": "en", "label": "English"},
    {"code": "hi", "label": "Hindi"},
    {"code": "pa", "label": "Punjabi"},
    {"code": "or", "label": "Odia"},
  ];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nameController.text = prefs.getString("name") ?? "";
      _emailController.text = prefs.getString("email") ?? "";
      _phoneController.text = prefs.getString("phone") ?? "";
      _selectedLanguage = prefs.getString("language") ?? "en";
    });
  }

  Future<void> _saveUserData() async {
    if (_formKey.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("name", _nameController.text.trim());
      await prefs.setString("email", _emailController.text.trim());
      await prefs.setString("phone", _phoneController.text.trim());
      await prefs.setString("language", _selectedLanguage!);

      // update app locale immediately
      FarmersApp.setLocale(context, Locale(_selectedLanguage!));

      if (!mounted) return;
      Navigator.pop(context, true); // return true → HomePage refreshes
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage("assets/images/logo.png"),
                ),
                const SizedBox(height: 20),

                // Name
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value == null || value.isEmpty ? "Enter your name" : null,
                ),
                const SizedBox(height: 20),

                // Email
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter your email";
                    }
                    if (!RegExp(r"^[^@]+@[^@]+\.[^@]+").hasMatch(value)) {
                      return "Enter a valid email";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Phone
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: "Phone",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? "Enter your phone number"
                      : null,
                ),
                const SizedBox(height: 20),

                // Language Dropdown
                DropdownButtonFormField<String>(
                  isExpanded: true,
                  value: _selectedLanguage,
                  items: languages
                      .map((lang) => DropdownMenuItem(
                            value: lang["code"],
                            child: Text(lang["label"]!),
                          ))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) {
                      setState(() => _selectedLanguage = val);
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: "Language",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 30),

                // Save button
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  icon: const Icon(Icons.save),
                  label: const Text("Save"),
                  onPressed: _saveUserData,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
