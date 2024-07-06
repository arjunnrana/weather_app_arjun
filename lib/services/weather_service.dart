import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app_arjun/models/weather.dart';

class WeatherService {
  static const String _apiKey = '21423fe35886f3adc4fcf50b7683e1a4';
  static const String _baseUrl =
      'https://api.openweathermap.org/data/2.5/weather';

  Future<Weather> fetchWeather(String cityName) async {
    final response = await http
        .get(Uri.parse('$_baseUrl?q=$cityName&appid=$_apiKey&units=metric'));

    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
