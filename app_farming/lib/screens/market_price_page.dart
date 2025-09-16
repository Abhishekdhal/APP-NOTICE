import 'package:flutter/material.dart';

class MarketPricePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Market Prices")),
      body: Center(
        child: Text(
          "Latest mandi prices and market trends will appear here.",
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
