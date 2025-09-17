import 'package:flutter/material.dart';

class IoTFarmingPage extends StatelessWidget {
  const IoTFarmingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("IoT-based Farming")),
      body: const Center(
        child: Text("Soil suitability analysis using IoT devices."),
      ),
    );
  }
}
