import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/splash_screen.dart'; // ✅ Your splash screen

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Initialize Supabase
  await Supabase.initialize(
    url: 'https://hvwhgvjaxbluwvtsiygo.supabase.co', // Supabase URL
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh2d2hndmpheGJsdXd2dHNpeWdvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTgwNDIwMDAsImV4cCI6MjA3MzYxODAwMH0.yYJtNJtSXUnAsRNWyk8D3Tj0AeUCUOPb1njZ74n8FPI', // anon key
  );

  runApp(const FarmersApp());
}

class FarmersApp extends StatelessWidget {
  const FarmersApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "KRISHINOOR",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: const SplashScreen(), // ✅ Start app with SplashScreen
    );
  }
}
