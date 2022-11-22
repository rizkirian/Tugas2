import 'dart:convert';

import 'location.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  late double temperature;
  late String weatherIcon;
  late String cityName;

  static const API_KEY = 'bafdc529c01031fc1dd8232094dc8b90';

  Future<dynamic> getWeatherData() async {
    LocationService locationService = LocationService();
    await locationService.getCurrentLocation();

    double lat = locationService.latitude;
    double lon = locationService.longitude;

    http.Response response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$API_KEY&units=metric"));

    if (response.statusCode == 200) {
      String data = response.body;
      var weatherData = jsonDecode(data);

      temperature = weatherData['main']['temp'];
      weatherIcon = weatherData['weather'][0]['icon'];
      cityName = weatherData['name'];
    }
  }
}
