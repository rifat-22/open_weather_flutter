import 'package:flutter/material.dart';

import '../models/weather_data.dart';

class WeatherModel extends ChangeNotifier {
  // int _counter = 0;
  //
  // int get counter => _counter;
  //
  // set counter(int value) {
  //   if (value != _counter) {
  //     _counter = value;
  //     notifyListeners();
  //   }
  // }

  WeatherData? _weatherData;

  WeatherData? get weatherData => _weatherData;

  WeatherModel(WeatherData? _weatherData) {

  }



  set weatherData(WeatherData? value)  {
    _weatherData = value;
    print("wanna know name");
        print( value?.name);

    notifyListeners();

    }
}