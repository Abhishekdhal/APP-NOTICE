import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../l10n/app_localizations.dart';
import '../main.dart'; // for FarmersApp.setLocale
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  String? _selectedLanguage;

  final List<Map<String, String>> languages = [
    {"code": "en", "label": "English"},
    {"code": "hi", "label": "Hindi"},
    {"code": "pa", "label": "Punjabi"},
    {"code": "or", "label": "Odia"},
  ];

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _emailController.text = prefs.getString("email") ?? '';
      _nameController.text = prefs.getString("name") ?? '';
      _phoneController.text = prefs.getString("phone") ?? '';
      _selectedLanguage = prefs.getString("language");
    });

    if (_selectedLanguage != null) {
      if (mounted) {
        FarmersApp.setLocale(context, Locale(_selectedLanguage!));
      }
    }
  }

  Future<void> _saveAndContinue(AppLocalizations l10n) async {
    if (_emailController.text.isEmpty ||
        _nameController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _selectedLanguage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.fillAllFields)),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("email", _emailController.text);
    await prefs.setString("name", _nameController.text);
    await prefs.setString("phone", _phoneController.text);
    await prefs.setString("language", _selectedLanguage!);

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomePage()),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade400, Colors.green.shade800],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Card(
              color: Colors.white.withAlpha(242),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 10,
              shadowColor: Colors.black26,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "assets/images/logo.png",
                        height: 80,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 20),

                    Text(
                      l10n.welcome,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade900,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      l10n.loginMessage,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 30),

                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon:
                            const Icon(Icons.email, color: Colors.green),
                        labelText: l10n.email,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        prefixIcon:
                            const Icon(Icons.person, color: Colors.green),
                        labelText: l10n.name,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        prefixIcon:
                            const Icon(Icons.phone, color: Colors.green),
                        labelText: l10n.phone,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

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
                          FarmersApp.setLocale(context, Locale(val));
                        }
                      },
                      decoration: InputDecoration(
                        prefixIcon:
                            const Icon(Icons.language, color: Colors.green),
                        labelText: l10n.language,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),

                    SizedBox(
                      width: double.infinity,
                      child: InkWell(
                        onTap: () => _saveAndContinue(l10n),
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.green.shade600,
                                Colors.green.shade900,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.green.withAlpha(102),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              l10n.continueButton,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1.1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}












// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../l10n/app_localizations.dart';
// import '../main.dart'; // for FarmersApp.setLocale
// import 'home_page.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _emailController = TextEditingController();
//   final _nameController = TextEditingController();
//   final _phoneController = TextEditingController();
//   String? _selectedLanguage;

//   // Use codes for storage, labels for UI
//   final List<Map<String, String>> languages = [
//     {"code": "en", "label": "English"},
//     {"code": "hi", "label": "Hindi"},
//     {"code": "pa", "label": "Punjabi"},
//     {"code": "or", "label": "Odia"},
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _loadSavedData();
//   }

//   /// Load saved user info and language
//   Future<void> _loadSavedData() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _emailController.text = prefs.getString("email") ?? '';
//       _nameController.text = prefs.getString("name") ?? '';
//       _phoneController.text = prefs.getString("phone") ?? '';
//       _selectedLanguage = prefs.getString("language");
//     });

//     if (_selectedLanguage != null) {
//       FarmersApp.setLocale(context, Locale(_selectedLanguage!));
//     }
//   }

//   /// Save user info and navigate
//   Future<void> _saveAndContinue(AppLocalizations l10n) async {
//     if (_emailController.text.isEmpty ||
//         _nameController.text.isEmpty ||
//         _phoneController.text.isEmpty ||
//         _selectedLanguage == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(l10n.fillAllFields)),
//       );
//       return;
//     }

//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString("email", _emailController.text);
//     await prefs.setString("name", _nameController.text);
//     await prefs.setString("phone", _phoneController.text);
//     await prefs.setString("language", _selectedLanguage!);

//     if (!mounted) return;
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (_) => const HomePage()),
//     );
//   }

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _nameController.dispose();
//     _phoneController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final l10n = AppLocalizations.of(context)!;

//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.green.shade400, Colors.green.shade800],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(20),
//             child: Card(
//               color: Colors.white.withAlpha(242),
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20)),
//               elevation: 10,
//               shadowColor: Colors.black26,
//               child: Padding(
//                 padding: const EdgeInsets.all(24.0),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     // Logo
//                     Container(
//                       padding: const EdgeInsets.all(16),
//                       decoration: const BoxDecoration(
//                         color: Colors.white,
//                         shape: BoxShape.circle,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black26,
//                             blurRadius: 10,
//                             offset: Offset(0, 4),
//                           ),
//                         ],
//                       ),
//                       child: Image.asset(
//                         "assets/images/logo.png",
//                         height: 80,
//                         fit: BoxFit.contain,
//                       ),
//                     ),
//                     const SizedBox(height: 20),

//                     Text(
//                       l10n.welcome,
//                       style: TextStyle(
//                         fontSize: 26,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.green.shade900,
//                       ),
//                     ),
//                     const SizedBox(height: 6),
//                     Text(
//                       l10n.loginMessage,
//                       style: TextStyle(color: Colors.grey[600]),
//                     ),
//                     const SizedBox(height: 30),

//                     // Email
//                     TextField(
//                       controller: _emailController,
//                       keyboardType: TextInputType.emailAddress,
//                       decoration: InputDecoration(
//                         prefixIcon:
//                             const Icon(Icons.email, color: Colors.green),
//                         labelText: l10n.email,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 15),

//                     // Name
//                     TextField(
//                       controller: _nameController,
//                       decoration: InputDecoration(
//                         prefixIcon:
//                             const Icon(Icons.person, color: Colors.green),
//                         labelText: l10n.name,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 15),

//                     // Phone
//                     TextField(
//                       controller: _phoneController,
//                       keyboardType: TextInputType.phone,
//                       decoration: InputDecoration(
//                         prefixIcon:
//                             const Icon(Icons.phone, color: Colors.green),
//                         labelText: l10n.phone,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 15),

//                     // Language dropdown
//                     DropdownButtonFormField<String>(
//                       isExpanded: true,
//                       value: _selectedLanguage,
//                       items: languages
//                           .map((lang) => DropdownMenuItem(
//                                 value: lang["code"],
//                                 child: Text(lang["label"]!),
//                               ))
//                           .toList(),
//                       onChanged: (val) {
//                         if (val != null) {
//                           setState(() => _selectedLanguage = val);
//                           FarmersApp.setLocale(context, Locale(val));
//                         }
//                       },
//                       decoration: InputDecoration(
//                         prefixIcon:
//                             const Icon(Icons.language, color: Colors.green),
//                         labelText: l10n.language,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 25),

//                     // Continue button
//                     SizedBox(
//                       width: double.infinity,
//                       child: InkWell(
//                         onTap: () => _saveAndContinue(l10n),
//                         borderRadius: BorderRadius.circular(12),
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(vertical: 16),
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                               colors: [
//                                 Colors.green.shade600,
//                                 Colors.green.shade900,
//                               ],
//                               begin: Alignment.topLeft,
//                               end: Alignment.bottomRight,
//                             ),
//                             borderRadius: BorderRadius.circular(12),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.green.withAlpha(102),
//                                 blurRadius: 10,
//                                 offset: const Offset(0, 4),
//                               ),
//                             ],
//                           ),
//                           child: Center(
//                             child: Text(
//                               l10n.continueButton,
//                               style: const TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                                 letterSpacing: 1.1,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
