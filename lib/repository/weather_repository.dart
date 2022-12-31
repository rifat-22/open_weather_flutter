import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/weather_data.dart';

class DataFlow {
  WeatherData? weatherData;
  int? statuscode;
  DataFlow(this.weatherData, this.statuscode);
}

class WeatherRepository {
  Future<DataFlow?> fetchWeatherData() async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=23.00&lon=90.00&appid=36d27fc4a354ee22fad96e3c9e975575'));
    WeatherData? weatherData;
    int statuscode = 0;
    DataFlow? dataflow;

    if (response.statusCode == 200) {
      weatherData = WeatherData.fromJson(
          jsonDecode(response.body));
      statuscode = 200;
    } else {
      statuscode = 400;
      throw Exception('Failed to load');
    }
    dataflow = DataFlow(weatherData, statuscode);
    return dataflow;
  }
}
