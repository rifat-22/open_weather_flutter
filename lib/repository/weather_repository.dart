import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/weather_data.dart';
class WeatherRepository {
  Future<WeatherData> fetchWeatherData() async {

    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=23.00&lon=90.00&appid=36d27fc4a354ee22fad96e3c9e975575'));
    WeatherData? weatherData;

    if (response.statusCode == 200) {
      print("Yaaaaaayy");
      weatherData = WeatherData.fromJson(
          jsonDecode(response.body));

      // //  //delete data
      // if (await widget.dao.cloudsDao.tableIsEmpty != 0) {
      //   await widget.dao.coordDao.deleteTasks();
      // }
      // if (await widget.dao.weatherDao.tableIsEmpty != 0) {
      //   await widget.dao.weatherDao.deleteTasks();
      // }
      // if (await widget.dao.cloudsDao.tableIsEmpty != 0) {
      //   await widget.dao.cloudsDao.deleteTasks();
      // }
      // if (await widget.dao.windDao.tableIsEmpty != 0) {
      //   await widget.dao.windDao.deleteTasks();
      // }
      // if (await widget.dao.mainDao.tableIsEmpty != 0) {
      //   await widget.dao.mainDao.deleteTasks();
      // }
      // if (await widget.dao.sysDao.tableIsEmpty != 0) {
      //   await widget.dao.sysDao.deleteTasks();
      // }
      // if (await widget.dao.weatherTableDao.tableIsEmpty != 0) {
      //   await widget.dao.weatherTableDao.deleteTasks();
      // }

      //insert data
      // await widget.dao.coordDao.insertCoordData(weatherData!.coord!);
      // await widget.dao.weatherDao.insertWeatherData(weatherData!);
      // await widget.dao.cloudsDao.insertCloudsData(weatherData!.clouds!);
      // await widget.dao.windDao.insertWindData(weatherData!.wind!);
      // await widget.dao.mainDao.insertMainData(weatherData!.main!);
      // await widget.dao.sysDao.insertSysData(weatherData!.sys!);
      // await widget.dao.weatherTableDao.insertWeather(weatherData!.weather![0]);
      //
      //
      //
      // //assign
      // coordDb = await widget.dao.coordDao.findCoordData();
      // weatherDataDb = await widget.dao.weatherDao.findWeatherData();
      // cloudsDb = await widget.dao.cloudsDao.findCloudsData();
      // windDb = await widget.dao.windDao.findWindData();
      // mainClassDb = await widget.dao.mainDao.findMainData();
      // sysDb = await widget.dao.sysDao.findSysData();
      // weatherDb = await widget.dao.weatherTableDao.findWeather();
      //
      // setState(()  {
      //   isFetchedData = 1;
      // });


      return WeatherData.fromJson(
          jsonDecode(response.body));
    } else {
      // coordDb = await widget.dao.coordDao.findCoordData();
      // weatherDataDb = await widget.dao.weatherDao.findWeatherData();
      // cloudsDb = await widget.dao.cloudsDao.findCloudsData();
      // windDb = await widget.dao.windDao.findWindData();
      // mainClassDb = await widget.dao.mainDao.findMainData();
      // sysDb = await widget.dao.sysDao.findSysData();
      // weatherDb = await widget.dao.weatherTableDao.findWeather();
      // isFetchedData = 2;
      throw Exception('Failed to load album');
    }
  }
}