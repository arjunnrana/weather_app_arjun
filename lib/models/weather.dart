// Here, I've created a model class for the specific data provided to be fetched

class Weather {
  final String cityName;
  final double temperature;
  final String condition;
  final String iconUrl;
  final int humidity;
  final double windSpeed;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.condition,
    required this.iconUrl,
    required this.humidity,
    required this.windSpeed,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      condition: json['weather'][0]['description'],
      iconUrl:
          "https://openweathermap.org/img/wn/${json['weather'][0]['icon']}@2x.png",
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'].toDouble(),
    );
  }
}
