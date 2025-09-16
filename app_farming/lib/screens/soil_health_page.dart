import 'package:flutter/material.dart';

class SoilHealthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Soil Health")),
      body: Center(
        child: Text(
          "Soil health recommendations and fertilizer guidance will appear here.",
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
