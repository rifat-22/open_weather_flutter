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
    DataFlow? dataflow;
    print(response.statusCode);

    if (response.statusCode == 200) {
      print("Yaaaaaayy");

      dataflow?.weatherData = WeatherData.fromJson(
          jsonDecode(response.body));
      dataflow?.statuscode = 200;



      // setState(()  {
      //   isFetchedData = 1;
      // });


      // return WeatherData.fromJson(
      //     jsonDecode(response.body));
    } else {
      dataflow?.statuscode = 400;
      throw Exception('Failed to load album');
    }
    return dataflow;

  }
}