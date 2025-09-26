import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../l10n/app_localizations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  String? city;
  String apiKey = "2f184182c9504a3092a115647251509"; // your key
  Map<String, dynamic>? weatherData;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _getCurrentLocationAndFetchWeather();
  }

  Future<void> _getCurrentLocationAndFetchWeather() async {
    try {
      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        final requestedPermission = await Geolocator.requestPermission();
        if (requestedPermission == LocationPermission.denied) {
          setState(() {
            errorMessage = "Location permission denied";
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          errorMessage = "Location permission denied forever";
        });
        return;
      }

      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      fetchWeather(position.latitude, position.longitude);
    } catch (e) {
      setState(() {
        errorMessage = "An error occurred: $e";
      });
    }
  }

  Future<void> fetchWeather(double latitude, double longitude) async {
    final url =
        "http://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$latitude,$longitude&days=7&aqi=no&alerts=no";
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        setState(() {
          weatherData = json.decode(response.body);
          errorMessage = null;
        });
      } else {
        setState(() {
          errorMessage = "Failed to load weather data";
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "An error occurred: $e";
      });
    }
  }

  /// Farming tips based on conditions
  String getFarmingTipFromData(Map<String, dynamic> data, AppLocalizations l10n) {
    final condition = data['condition']['text'].toString().toLowerCase();
    final temp = data['temp_c'] ?? data['avgtemp_c'] ?? 0;
    final humidity = data['humidity'] ?? data['avghumidity'] ?? 60;

    if (condition.contains("rain")) {
      return l10n.farmingTip_rain;
    } else if (condition.contains("sunny") || condition.contains("clear")) {
      if (temp > 32) {
        return l10n.farmingTip_hot;
      } else {
        return l10n.farmingTip_sunny;
      }
    } else if (condition.contains("cloud")) {
      return l10n.farmingTip_cloudy;
    } else if (humidity > 80) {
      return l10n.farmingTip_humidity;
    } else {
      return l10n.farmingTip_normal;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.weatherTitle),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4facfe), Color(0xFF00f2fe)], // Sky gradient
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: weatherData == null
              ? errorMessage != null
                  ? Text(
                      errorMessage!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    )
                  : const CircularProgressIndicator(color: Colors.white)
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Current Weather Card
                        Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          color: Colors.white.withOpacity(0.85),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  weatherData!['location']['name'],
                                  style: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Image.network(
                                  "https:${weatherData!['current']['condition']['icon']}",
                                  scale: 0.7,
                                ),
                                Text(
                                  "${weatherData!['current']['temp_c']} °C",
                                  style: const TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                Text(
                                  weatherData!['current']['condition']['text'],
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    _extraInfo("💧",
                                        "${weatherData!['current']['humidity']}%"),
                                    _extraInfo("🌬",
                                        "${weatherData!['current']['wind_kph']} km/h"),
                                    _extraInfo("🌡",
                                        "${weatherData!['current']['feelslike_c']} °C"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // 7-Day Forecast
                        const Text(
                          "🌦 7-Day Forecast",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 200,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                weatherData!['forecast']['forecastday'].length,
                            itemBuilder: (context, index) {
                              final day = weatherData!['forecast']
                                  ['forecastday'][index];
                              final date = day['date'];
                              final icon = day['day']['condition']['icon'];
                              final temp = day['day']['avgtemp_c'];

                              return Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                color: Colors.white.withOpacity(0.9),
                                margin: const EdgeInsets.all(8),
                                child: Container(
                                  width: 150,
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(date,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Image.network("https:$icon", scale: 1.2),
                                      Text("$temp °C"),
                                      const SizedBox(height: 5),
                                      Text(
                                        getFarmingTipFromData(day['day'], l10n),
                                        style: const TextStyle(fontSize: 12),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Hourly Forecast (today)
                        const Text(
                          "🕒 Hourly Forecast (Today)",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 180,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: weatherData!['forecast']['forecastday']
                                    [0]['hour']
                                .length,
                            itemBuilder: (context, index) {
                              final hour = weatherData!['forecast']
                                  ['forecastday'][0]['hour'][index];
                              final time =
                                  hour['time'].toString().split(" ")[1];
                              final icon = hour['condition']['icon'];
                              final temp = hour['temp_c'];

                              return Card(
                                margin: const EdgeInsets.all(8),
                                child: Container(
                                  width: 120,
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(time,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Image.network("https:$icon", scale: 1.5),
                                      Text("$temp °C"),
                                      const SizedBox(height: 5),
                                      Text(
                                        getFarmingTipFromData(hour, l10n),
                                        style: const TextStyle(fontSize: 10),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Widget _extraInfo(String emoji, String value) {
    return Column(
      children: [
        Text(
          emoji,
          style: const TextStyle(fontSize: 28),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}



















// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import '../l10n/app_localizations.dart';

// class WeatherPage extends StatefulWidget {
//   const WeatherPage({super.key});

//   @override
//   State<WeatherPage> createState() => _WeatherPageState();
// }

// class _WeatherPageState extends State<WeatherPage> {
//   String city = "Bhubaneswar"; // default city
//   String apiKey = "2f184182c9504a3092a115647251509"; // your key
//   Map<String, dynamic>? weatherData;
//   String? errorMessage;

//   @override
//   void initState() {
//     super.initState();
//     fetchWeather();
//   }

//   Future<void> fetchWeather() async {
//     final url =
//         "http://api.weatherapi.com/v1/current.json?key=$apiKey&q=$city";
//     try {
//       final response = await http.get(Uri.parse(url));

//       if (response.statusCode == 200) {
//         setState(() {
//           weatherData = json.decode(response.body);
//           errorMessage = null;
//         });
//       } else {
//         setState(() {
//           errorMessage = "Failed to load weather data";
//         });
//       }
//     } catch (e) {
//       setState(() {
//         errorMessage = "An error occurred: $e";
//       });
//     }
//   }

//   /// Farming tips based on weather conditions
//   String getFarmingTip(AppLocalizations l10n) {
//     if (weatherData == null) return "";

//     final condition =
//         weatherData!['current']['condition']['text'].toString().toLowerCase();
//     final temp = weatherData!['current']['temp_c'];
//     final humidity = weatherData!['current']['humidity'];

//     if (condition.contains("rain")) {
//       return l10n.farmingTip_rain;
//     } else if (condition.contains("sunny") || condition.contains("clear")) {
//       if (temp > 32) {
//         return l10n.farmingTip_hot;
//       } else {
//         return l10n.farmingTip_sunny;
//       }
//     } else if (condition.contains("cloud")) {
//       return l10n.farmingTip_cloudy;
//     } else if (humidity > 80) {
//       return l10n.farmingTip_humidity;
//     } else {
//       return l10n.farmingTip_normal;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final l10n = AppLocalizations.of(context)!;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(l10n.weatherTitle),
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//       ),
//       extendBodyBehindAppBar: true,
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFF4facfe), Color(0xFF00f2fe)], // Sky gradient
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Center(
//           child: weatherData == null
//               ? errorMessage != null
//                   ? Text(
//                       errorMessage!,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                       ),
//                     )
//                   : const CircularProgressIndicator(color: Colors.white)
//               : Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       // Weather Card
//                       Card(
//                         elevation: 10,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                         color: Colors.white.withOpacity(0.85),
//                         child: Padding(
//                           padding: const EdgeInsets.all(20),
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Text(
//                                 weatherData!['location']['name'],
//                                 style: const TextStyle(
//                                   fontSize: 30,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.black87,
//                                 ),
//                               ),
//                               const SizedBox(height: 8),
//                               Image.network(
//                                 "https:${weatherData!['current']['condition']['icon']}",
//                                 scale: 0.7,
//                               ),
//                               Text(
//                                 "${weatherData!['current']['temp_c']} °C",
//                                 style: const TextStyle(
//                                   fontSize: 40,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.black87,
//                                 ),
//                               ),
//                               Text(
//                                 weatherData!['current']['condition']['text'],
//                                 style: const TextStyle(
//                                   fontSize: 22,
//                                   fontStyle: FontStyle.italic,
//                                   color: Colors.black54,
//                                 ),
//                               ),
//                               const SizedBox(height: 20),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                 children: [
//                                   _extraInfo("💧",
//                                       "${weatherData!['current']['humidity']}%"),
//                                   _extraInfo("🌬",
//                                       "${weatherData!['current']['wind_kph']} km/h"),
//                                   _extraInfo("🌡",
//                                       "${weatherData!['current']['feelslike_c']} °C"),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 20),

//                       // Farming Tip Card
//                       Card(
//                         elevation: 8,
//                         color: Colors.greenAccent.withOpacity(0.85),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(16),
//                           child: Text(
//                             getFarmingTip(l10n),
//                             textAlign: TextAlign.center,
//                             style: const TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.black87,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//         ),
//       ),
//     );
//   }

//   Widget _extraInfo(String emoji, String value) {
//     return Column(
//       children: [
//         Text(
//           emoji,
//           style: const TextStyle(fontSize: 28),
//         ),
//         const SizedBox(height: 5),
//         Text(
//           value,
//           style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//         ),
//       ],
//     );
//   }
// }
















// // import 'dart:convert';
// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import '../l10n/app_localizations.dart';

// // class WeatherPage extends StatefulWidget {
// //   const WeatherPage({super.key});

// //   @override
// //   State<WeatherPage> createState() => _WeatherPageState();
// // }

// // class _WeatherPageState extends State<WeatherPage> {
// //   String city = "Bhubaneswar";
// //   String apiKey = "2f184182c9504a3092a115647251509";
// //   Map<String, dynamic>? weatherData;
// //   String? errorMessage;

// //   @override
// //   void initState() {
// //     super.initState();
// //     fetchWeather();
// //   }

// //   Future<void> fetchWeather() async {
// //     final url =
// //         "http://api.weatherapi.com/v1/current.json?key=$apiKey&q=$city";
// //     try {
// //       final response = await http.get(Uri.parse(url));

// //       if (response.statusCode == 200) {
// //         setState(() {
// //           weatherData = json.decode(response.body);
// //           errorMessage = null;
// //         });
// //       } else {
// //         setState(() {
// //           errorMessage = "Failed to load weather data";
// //         });
// //       }
// //     } catch (e) {
// //       setState(() {
// //         errorMessage = "An error occurred: $e";
// //       });
// //     }
// //   }

// //   String getFarmingTip() {
// //     if (weatherData == null) return "";

// //     final condition = weatherData!['current']['condition']['text'].toString().toLowerCase();
// //     final temp = weatherData!['current']['temp_c'];
// //     final humidity = weatherData!['current']['humidity'];

// //     if (condition.contains("rain")) {
// //       return "🌧 Good for paddy and rice crops. Avoid pesticide spraying today.";
// //     } else if (condition.contains("sunny") || condition.contains("clear")) {
// //       if (temp > 32) {
// //         return "☀️ Too hot! Irrigation is required to protect young plants.";
// //       } else {
// //         return "☀️ Sunny day, good for harvesting and drying crops.";
// //       }
// //     } else if (condition.contains("cloud")) {
// //       return "🌥 Cloudy skies – good day for sowing seeds, soil moisture will remain.";
// //     } else if (humidity > 80) {
// //       return "💧 High humidity – watch out for fungal diseases in crops.";
// //     } else {
// //       return "🌱 Normal conditions – good for regular farming activities.";
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final l10n = AppLocalizations.of(context)!;

// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text(l10n.weatherTitle),
// //         elevation: 0,
// //         backgroundColor: Colors.transparent,
// //       ),
// //       extendBodyBehindAppBar: true,
// //       body: Container(
// //         decoration: const BoxDecoration(
// //           gradient: LinearGradient(
// //             colors: [Color(0xFF4facfe), Color(0xFF00f2fe)], // Sky gradient
// //             begin: Alignment.topCenter,
// //             end: Alignment.bottomCenter,
// //           ),
// //         ),
// //         child: Center(
// //           child: weatherData == null
// //               ? errorMessage != null
// //                   ? Text(
// //                       errorMessage!,
// //                       style: const TextStyle(
// //                         color: Colors.white,
// //                         fontSize: 18,
// //                       ),
// //                     )
// //                   : const CircularProgressIndicator(color: Colors.white)
// //               : Padding(
// //                   padding: const EdgeInsets.all(16.0),
// //                   child: Column(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: [
// //                       Card(
// //                         elevation: 10,
// //                         shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(25),
// //                         ),
// //                         color: Colors.white.withOpacity(0.85),
// //                         child: Padding(
// //                           padding: const EdgeInsets.all(20),
// //                           child: Column(
// //                             mainAxisSize: MainAxisSize.min,
// //                             children: [
// //                               Text(
// //                                 weatherData!['location']['name'],
// //                                 style: const TextStyle(
// //                                   fontSize: 30,
// //                                   fontWeight: FontWeight.bold,
// //                                   color: Colors.black87,
// //                                 ),
// //                               ),
// //                               const SizedBox(height: 8),
// //                               Image.network(
// //                                 "https:${weatherData!['current']['condition']['icon']}",
// //                                 scale: 0.7,
// //                               ),
// //                               Text(
// //                                 "${weatherData!['current']['temp_c']} °C",
// //                                 style: const TextStyle(
// //                                   fontSize: 40,
// //                                   fontWeight: FontWeight.bold,
// //                                   color: Colors.black87,
// //                                 ),
// //                               ),
// //                               Text(
// //                                 weatherData!['current']['condition']['text'],
// //                                 style: const TextStyle(
// //                                   fontSize: 22,
// //                                   fontStyle: FontStyle.italic,
// //                                   color: Colors.black54,
// //                                 ),
// //                               ),
// //                               const SizedBox(height: 20),
// //                               Row(
// //                                 mainAxisAlignment:
// //                                     MainAxisAlignment.spaceAround,
// //                                 children: [
// //                                   _extraInfo("💧",
// //                                       "${weatherData!['current']['humidity']}%"),
// //                                   _extraInfo("🌬",
// //                                       "${weatherData!['current']['wind_kph']} km/h"),
// //                                   _extraInfo("🌡",
// //                                       "${weatherData!['current']['feelslike_c']} °C"),
// //                                 ],
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //                       ),
// //                       const SizedBox(height: 20),
// //                       // Farming Tip Section
// //                       Card(
// //                         elevation: 8,
// //                         color: Colors.greenAccent.withOpacity(0.85),
// //                         shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(20),
// //                         ),
// //                         child: Padding(
// //                           padding: const EdgeInsets.all(16),
// //                           child: Text(
// //                             getFarmingTip(),
// //                             textAlign: TextAlign.center,
// //                             style: const TextStyle(
// //                               fontSize: 18,
// //                               fontWeight: FontWeight.w600,
// //                               color: Colors.black87,
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _extraInfo(String emoji, String value) {
// //     return Column(
// //       children: [
// //         Text(
// //           emoji,
// //           style: const TextStyle(fontSize: 28),
// //         ),
// //         const SizedBox(height: 5),
// //         Text(
// //           value,
// //           style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w5