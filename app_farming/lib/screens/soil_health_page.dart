import 'package:flutter/material.dart';

class SoilHealthPage extends StatelessWidget {
  const SoilHealthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Soil Health")),
      body: const Center(
        child: Text(
          "Soil health recommendations and fertilizer guidance will appear here.",
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
