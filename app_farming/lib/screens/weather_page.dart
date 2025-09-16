import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  String city = "Bhubaneswar"; // change as needed
  String apiKey = "2f184182c9504a3092a115647251509";
  Map<String, dynamic>? weatherData;

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  Future<void> fetchWeather() async {
    final url =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setState(() {
        weatherData = json.decode(response.body);
      });
    } else {
      throw Exception("Failed to load weather");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Weather")),
      body: Center(
        child: weatherData == null
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${weatherData!['name']}",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Image.network(
                    "http://openweathermap.org/img/wn/${weatherData!['weather'][0]['icon']}@2x.png",
                  ),
                  Text(
                    "${weatherData!['main']['temp']} °C",
                    style: TextStyle(fontSize: 32),
                  ),
                  Text(
                    "${weatherData!['weather'][0]['description']}",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
      ),
    );
  }
}








// import 'package:flutter/material.dart';

// class WeatherPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Weather Forecast")),
//       body: Center(
//         child: Text("Weather Forecast & Cultivation Prediction will appear here."),
//       ),
//     );
//   }
// }
