import 'package:flutter/material.dart';

class IoTFarmingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("IoT-based Farming")),
      body: Center(
        child: Text("Soil suitability analysis using IoT devices."),
      ),
    );
  }
}
