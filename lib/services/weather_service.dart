import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {

  final String apiKey = "f43b53aab66d5e7de061863d08ddd14d";

  Future<Map<String, dynamic>> getWeather(String city) async {

    final url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric"
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load weather");
    }
  }
}