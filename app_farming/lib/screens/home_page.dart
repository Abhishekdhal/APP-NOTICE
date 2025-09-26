import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../l10n/app_localizations.dart';
import 'ai_bot_page.dart';
import 'supplements_page.dart';
import 'weather_page.dart';
import 'notice_board_page.dart';
import 'iot_farming_page.dart';
import 'soil_health_page.dart';
import 'market_price_page.dart';
import 'problem_upload_page.dart';
import 'feedback_page.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _name;
  String? _email;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString("name") ?? "User";
      _email = prefs.getString("email") ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final List<Map<String, dynamic>> features = [
      {
        "name": l10n.supplements,
        "icon": Icons.shopping_cart,
        "page": const SupplementsPage()
      },
      {"name": l10n.weather, "icon": Icons.cloud, "page": const WeatherPage()},
      {"name": l10n.aiBot, "icon": Icons.smart_toy, "page": const AIBotPage()},
      {
        "name": l10n.noticeBoard,
        "icon": Icons.campaign,
        "page": const NoticeBoardPage()
      },
      {
        "name": l10n.iotFarming,
        "icon": Icons.agriculture,
        "page": const IoTFarmingPage()
      },
      {
        "name": l10n.soilHealth,
        "icon": Icons.science,
        "page": const SoilHealthPage()
      },
      {
        "name": l10n.marketPrices,
        "icon": Icons.trending_up,
        "page": const MarketPricePage()
      },
      {
        "name": l10n.cropProblemDetector,
        "icon": Icons.report_problem,
        "page": const ProblemUploadPage()
      },
      {
        "name": l10n.feedback,
        "icon": Icons.feedback,
        "page": const FeedbackPage()
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Row(
          children: [
            InkWell(
              onTap: () async {
                final updated = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfilePage()),
                );
                if (updated == true) {
                  _loadUserData(); // refresh after update
                }
              },
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white, // ✅ white circle background
                child: ClipOval(
                  child: Image.asset(
                    "assets/images/logo.png", // ✅ your logo
                    fit: BoxFit.contain,
                    width: 26,
                    height: 26,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _name ?? "Loading...",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  _email ?? "",
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.clear();
              if (!mounted) return;
              Navigator.pop(context); // back to login
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: features.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            final feature = features[index];
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => feature["page"]),
                );
              },
              borderRadius: BorderRadius.circular(15),
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
                    Icon(feature["icon"], size: 50, color: Colors.green[800]),
                    const SizedBox(height: 10),
                    Text(
                      feature["name"],
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        tooltip: l10n.askAIBot,
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
