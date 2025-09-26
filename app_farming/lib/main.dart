import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'screens/splash_screen.dart';
import 'l10n/app_localizations.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables from .env file
  try {
    await dotenv.load(fileName: "assets/.env");
    debugPrint("✅ Loaded .env file");
  } catch (e) {
    debugPrint("❌ Could not load .env file: $e");
  }

  // Debug print (remove in production!)
  debugPrint("🔑 GEMINI_API_KEY: ${dotenv.env['GEMINI_API_KEY'] ?? 'NOT FOUND'}");
  debugPrint("🌐 SUPABASE_URL: ${dotenv.env['SUPABASE_URL'] ?? 'NOT FOUND'}");

  // Initialize Supabase (only if keys are found)
  final supabaseUrl = dotenv.env['SUPABASE_URL'];
  final supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY'];

  if (supabaseUrl != null && supabaseAnonKey != null) {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
    debugPrint("✅ Supabase initialized");
  } else {
    debugPrint("❌ Supabase keys missing, check your .env file");
  }

  // Load saved language code from SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  final savedLangCode = prefs.getString("language");
  final startLocale = savedLangCode != null ? Locale(savedLangCode) : null;

  runApp(FarmersApp(startLocale: startLocale));
}

class FarmersApp extends StatefulWidget {
  final Locale? startLocale;
  const FarmersApp({super.key, this.startLocale});

  @override
  State<FarmersApp> createState() => _FarmersAppState();

  /// Helper to change locale from anywhere in the app
  static void setLocale(BuildContext context, Locale locale) {
    final state = context.findAncestorStateOfType<_FarmersAppState>();
    state?.setLocale(locale);
  }
}

class _FarmersAppState extends State<FarmersApp> {
  Locale? _locale;

  @override
  void initState() {
    super.initState();
    _locale = widget.startLocale;
  }

  /// Update locale and save in SharedPreferences
  void setLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("language", locale.languageCode);
    setState(() => _locale = locale);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "KRISHINOOR",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),

      // Dynamic locale
      locale: _locale,

      // Localization setup
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('hi'), // Hindi
        Locale('pa'), // Punjabi
        Locale('or'), // Odia
      ],

      // Start app with SplashScreen
      home: const SplashScreen(),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'screens/splash_screen.dart';
// import 'l10n/app_localizations.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await dotenv.load(fileName: ".env");

//   // Initialize Supabase
//   await Supabase.initialize(
//     url: dotenv.env['SUPABASE_URL']!,
//     anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
//   );

//   // Load saved language code from SharedPreferences
//   final prefs = await SharedPreferences.getInstance();
//   final savedLangCode = prefs.getString("language");
//   final startLocale = savedLangCode != null ? Locale(savedLangCode) : null;

//   runApp(FarmersApp(startLocale: startLocale));
// }

// class FarmersApp extends StatefulWidget {
//   final Locale? startLocale;
//   const FarmersApp({super.key, this.startLocale});

//   @override
//   State<FarmersApp> createState() => _FarmersAppState();

//   /// Helper to change locale from anywhere in the app
//   static void setLocale(BuildContext context, Locale locale) {
//     final state = context.findAncestorStateOfType<_FarmersAppState>();
//     state?.setLocale(locale);
//   }
// }

// class _FarmersAppState extends State<FarmersApp> {
//   Locale? _locale;

//   @override
//   void initState() {
//     super.initState();
//     _locale = widget.startLocale;
//   }

//   /// Update locale and save in SharedPreferences
//   void setLocale(Locale locale) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString("language", locale.languageCode);
//     setState(() => _locale = locale);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "KRISHINOOR",
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(primarySwatch: Colors.green),

//       // Dynamic locale
//       locale: _locale,

//       // Localization setup
//       localizationsDelegates: [
//         AppLocalizations.delegate,
//         GlobalMaterialLocalizations.delegate,
//         GlobalWidgetsLocalizations.delegate,
//         GlobalCupertinoLocalizations.delegate,
//       ],
//       supportedLocales: const [
//         Locale('en'), // English
//         Locale('hi'), // Hindi
//         Locale('pa'), // Punjabi
//         Locale('or'), // Odia
//       ],

//       // Start app with SplashScreen
//       home: const SplashScreen(),
//     );
//   }
// }
