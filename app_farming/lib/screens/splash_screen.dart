import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home_page.dart';
import 'package:flutter_application_1/screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  final String fullText = "KRISHINOOR";
  String currentText = "";
  int _index = 0;
  Timer? _timer;

  late final AnimationController _imageController;
  late final Animation<Offset> _imageSlide;
  late final Animation<double> _imageFade;

  @override
  void initState() {
    super.initState();

    _imageController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _imageSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _imageController, curve: Curves.easeOut));

    _imageFade = CurvedAnimation(
      parent: _imageController,
      curve: Curves.easeIn,
    );

    // Typewriter effect for text
    _timer = Timer.periodic(const Duration(milliseconds: 150), (timer) {
      if (_index < fullText.length) {
        setState(() {
          currentText += fullText[_index];
          _index++;
        });
      } else {
        timer.cancel();
        _imageController.forward();

        // Navigate after short delay
        Future.delayed(const Duration(seconds: 2), () async {
          if (!mounted) return;

          SharedPreferences prefs = await SharedPreferences.getInstance();
          bool isLoggedIn = prefs.getString("name") != null;

          if (!mounted) return;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => isLoggedIn ? const HomePage() : const LoginPage(),
            ),
          );
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double textSize = MediaQuery.of(context).size.width * 0.08 + 8;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // 🌿 Constant farming gradient background
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade700, Colors.lightGreen.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App name typing
            Text(
              currentText,
              style: TextStyle(
                fontSize: textSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 2,
                shadows: const [
                  Shadow(
                    blurRadius: 8,
                    color: Colors.black54,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            // Farm image with fade + slide
            FadeTransition(
              opacity: _imageFade,
              child: SlideTransition(
                position: _imageSlide,
                child: Image.asset(
                  'assets/images/farm2.png',
                  width: 160,
                  height: 160,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
