import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // ✅ Required for Firebase init
import 'screens/splash_screen.dart'; // ✅ Your splash screen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // ✅ Initialize Firebase

  runApp(FarmersApp());
}

class FarmersApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Farmers For India",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: SplashScreen(), // ✅ Start app with SplashScreen
    );
  }
}
