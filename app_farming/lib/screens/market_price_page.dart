import 'package:flutter/material.dart';

class MarketPricePage extends StatelessWidget {
  const MarketPricePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Market Prices")),
      body: const Center(
        child: Text(
          "Latest mandi prices and market trends will appear here.",
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
