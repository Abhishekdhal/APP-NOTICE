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
  final List<String> features = [
    "Supplements",
    "Weather",
    "AI Bot",
    "Notice Board",
    "IoT Farming",
    "Soil Health",
    "Market Prices",
    "Report Problem",
    "Feedback",
  ];

  final List<IconData> icons = [
    Icons.shopping_cart,
    Icons.cloud,
    Icons.smart_toy,
    Icons.campaign,
    Icons.agriculture,
    Icons.science,       // Soil Health
    Icons.trending_up,   // Market Prices
    Icons.report_problem, // Report Problem
    Icons.feedback,      // Feedback
  ];

  final List<Widget> pages = [
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
      appBar: AppBar(title: Text("Farmers of India")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: features.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 5,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icons[index], size: 50, color: Colors.green[800]),
                    SizedBox(height: 10),
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
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AIBotPage()),
          );
        },
        child: Icon(Icons.smart_toy, color: Colors.white),
        tooltip: "Ask AI Bot",
      ),
    );
  }
}









// import 'package:flutter/material.dart';
// import 'supplements_page.dart';
// import 'weather_page.dart';
// import 'ai_bot_page.dart';
// import 'notice_board_page.dart';
// import 'iot_farming_page.dart';

// class HomePage extends StatelessWidget {
//   final List<String> features = [
//     "Supplements",
//     "Weather",
//     "AI Bot",
//     "Notice Board",
//     "IoT Farming"
//   ];

//   final List<IconData> icons = [
//     Icons.shopping_cart,
//     Icons.cloud,
//     Icons.smart_toy,
//     Icons.campaign,
//     Icons.agriculture,
//   ];

//   final List<Widget> pages = [
//     SupplementsPage(),
//     WeatherPage(),
//     AIBotPage(),
//     NoticeBoardPage(),
//     IoTFarmingPage()
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Farmers of India")),
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: GridView.builder(
//           itemCount: features.length,
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             crossAxisSpacing: 12,
//             mainAxisSpacing: 12,
//           ),
//           itemBuilder: (context, index) {
//             return GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => pages[index]),
//                 );
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.green[100],
//                   borderRadius: BorderRadius.circular(15),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.3),
//                       blurRadius: 5,
//                       offset: Offset(2, 2),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(icons[index], size: 50, color: Colors.green[800]),
//                     SizedBox(height: 10),
//                     Text(
//                       features[index],
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.green[900],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),

//       // Floating AI Button
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.green,
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (_) => AIBotPage()),
//           );
//         },
//         child: Icon(Icons.smart_toy, color: Colors.white),
//         tooltip: "Ask AI Bot",
//       ),
//     );
//   }
// }
