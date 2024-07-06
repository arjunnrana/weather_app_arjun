import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app_arjun/screens/weather_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _cityController = TextEditingController();
  bool isLoading = false;
  String? _lastCity;

  @override
  void initState() {
    super.initState();
    loadLastSearchedCity();
  }

  Future<void> loadLastSearchedCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lastCity = prefs.getString('lastCity');
    setState(() {
      _lastCity = lastCity;
      if (_lastCity != null) {
        _cityController.text = _lastCity!;
      }
    });
  }

  Future<void> saveLastSearchedCity(String city) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastCity', city);
  }

  void searchWeather() {
    if (_cityController.text.trim().isNotEmpty) {
      saveLastSearchedCity(_cityController.text.trim());
      setState(() {
        isLoading = true;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WeatherDetails(
            cityName: _cityController.text.trim(),
          ),
        ),
      ).then((_) {
        setState(() {
          isLoading = false;
        });
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please, enter a city name!',
            style: TextStyle(color: Colors.red[900]),
          ),
          backgroundColor: Colors.red[100],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 70),
            Center(
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(80)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(80),
                  child: Image.asset(
                    'assets/images/icons8-partly-cloudy-day.gif',
                    height: 150,
                    width: 150,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _cityController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'e.g., Ranchi',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0),
                        ),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0),
                        ),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                isLoading
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 19,
                          vertical: 10,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30.0),
                            bottomRight: Radius.circular(30.0),
                          ),
                        ),
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : ElevatedButton(
                        onPressed: searchWeather,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 18,
                          ),
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30.0),
                              bottomRight: Radius.circular(30.0),
                            ),
                          ),
                        ),
                        child: const Text('Search'),
                      ),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                'Search a city name to get its weather',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: Colors.grey[300]!,
                    )),
                child: Text(
                  'openweathermap.org',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
