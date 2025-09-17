import 'package:flutter/material.dart';
import 'supplements_page.dart';
import 'weather_page.dart';
import 'ai_bot_page.dart';
import 'notice_board_page.dart';
import 'iot_farming_page.dart';
import 'soil_health_page.dart';
import 'market_price_page.dart';
import 'problem_upload_page.dart';
import 'feedback_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final List<String> features = const [
    "Supplements",
    "Weather",
    "AI Bot",
    "Notice Board",
    "IoT Farming",
    "Soil Health",
    "Market Prices",
    "Crop Problem Detector",
    "Feedback",
  ];

  final List<IconData> icons = const [
    Icons.shopping_cart,
    Icons.cloud,
    Icons.smart_toy,
    Icons.campaign,
    Icons.agriculture,
    Icons.science, // Soil Health
    Icons.trending_up, // Market Prices
    Icons.report_problem, // Report Problem
    Icons.feedback, // Feedback
  ];

  final List<Widget> pages = const [
    SupplementsPage(),
    WeatherPage(),
    AIBotPage(),
    NoticeBoardPage(),
    IoTFarmingPage(),
    SoilHealthPage(),
    MarketPricePage(),
    ProblemUploadPage(),
    FeedbackPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Farmers of India")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: features.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 items per row
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => pages[index]),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withAlpha(70),
                      blurRadius: 5,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icons[index], size: 50, color: Colors.green[800]),
                    const SizedBox(height: 10),
                    Text(
                      features[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[900],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),

      // Floating AI Button
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        tooltip: "Ask AI Bot",
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AIBotPage()),
          );
        },
        child: const Icon(Icons.smart_toy, color: Colors.white),
      ),
    );
  }
}
