import 'dart:async';
import 'package:flutter/material.dart';
import 'home_page.dart'; // make sure you created home_page.dart in screens/

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  final String fullText = "FARMERS FOR INDIA";
  String currentText = "";
  int _index = 0;
  Timer? _timer;

  late final AnimationController _imageController;
  late final Animation<Offset> _imageSlide;
  late final Animation<double> _imageFade;

  @override
  void initState() {
    super.initState();

    // Animation controller for image
    _imageController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    _imageSlide = Tween<Offset>(
      begin: Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _imageController, curve: Curves.easeOut));

    _imageFade = CurvedAnimation(
      parent: _imageController,
      curve: Curves.easeIn,
    );

    // Start text animation
    _timer = Timer.periodic(Duration(milliseconds: 150), (timer) {
      if (_index < fullText.length) {
        setState(() {
          currentText += fullText[_index];
          _index++;
        });
      } else {
        timer.cancel();

        // Play image animation
        _imageController.forward();

        // Navigate after short delay
        Future.delayed(Duration(seconds: 2), () {
          if (!mounted) return;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => HomePage()),
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
      backgroundColor: Colors.black, // Netflix-style black
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text (Netflix style)
            Text(
              currentText,
              style: TextStyle(
                fontSize: textSize,
                fontWeight: FontWeight.bold,
                color: Colors.red, // Netflix red
                letterSpacing: 2,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 30),

            // Image (farm2.png) with fade + slide
            FadeTransition(
              opacity: _imageFade,
              child: SlideTransition(
                position: _imageSlide,
                child: Image.asset(
                  'assets/images/farm2.png',
                  width: 150,
                  height: 150,
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
