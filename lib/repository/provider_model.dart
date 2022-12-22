import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_data.dart';
import 'package:weather_app/repository/repo_to_db.dart';

import 'package:weather_app/repository/weather_repository.dart';
import 'dao_db.dart';

class ProviderModel extends ChangeNotifier {
  final _service = WeatherRepository();
  bool isLoading = false;
  Dao? dao;
  //local db
  DaoDb? daoDb;
  DataFlow? dataFlow;

  ProviderModel(Dao? dao) {
    this.dao = dao;
  }

  WeatherData? _weatherData;
  WeatherData? get weatherData => _weatherData;

  Future<DaoDb?> getWeatherData() async {

     daoDb = DaoDb(await dao?.weatherDao.findWeatherData(), await dao?.coordDao.findCoordData(), await dao?.cloudsDao.findCloudsData(), await dao?.windDao.findWindData(), await dao?.mainDao.findMainData(), await dao?.sysDao.findSysData(), await dao?.weatherTableDao.findWeather());

     // if (daoDb == null) {
     //   _weatherData = await _service.fetchWeatherData();
     // }
     dataFlow = await _service.fetchWeatherData();

    print("hello");
     print(dataFlow?.statuscode);


    if(_weatherData != null) {

      print("weather data not null");
      //delete data
      if (await dao?.cloudsDao.tableIsEmpty != 0) {
        await dao?.coordDao.deleteTasks();
      }
      if (await dao?.weatherDao.tableIsEmpty != 0) {
        await dao?.weatherDao.deleteTasks();
      }
      if (await dao?.cloudsDao.tableIsEmpty != 0) {
        await dao?.cloudsDao.deleteTasks();
      }
      if (await dao?.windDao.tableIsEmpty != 0) {
        await dao?.windDao.deleteTasks();
      }
      if (await dao?.mainDao.tableIsEmpty != 0) {
        await dao?.mainDao.deleteTasks();
      }
      if (await dao?.sysDao.tableIsEmpty != 0) {
        await dao?.sysDao.deleteTasks();
      }
      if (await dao?.weatherTableDao.tableIsEmpty != 0) {
        await dao?.weatherTableDao.deleteTasks();
      }

      //insert data
      await dao?.coordDao.insertCoordData(weatherData!.coord!);
      await dao?.weatherDao.insertWeatherData(weatherData!);
      await dao?.cloudsDao.insertCloudsData(weatherData!.clouds!);
      await dao?.windDao.insertWindData(weatherData!.wind!);
      await dao?.mainDao.insertMainData(weatherData!.main!);
      await dao?.sysDao.insertSysData(weatherData!.sys!);
      await dao?.weatherTableDao.insertWeather(weatherData!.weather![0]);

      daoDb = DaoDb(await dao?.weatherDao.findWeatherData(), await dao?.coordDao.findCoordData(), await dao?.cloudsDao.findCloudsData(), await dao?.windDao.findWindData(), await dao?.mainDao.findMainData(), await dao?.sysDao.findSysData(), await dao?.weatherTableDao.findWeather());

      print(daoDb?.coordDb?.lan);
      isLoading = false;
      notifyListeners();
    } else {

      print("weather is null");
      daoDb = DaoDb(await dao?.weatherDao.findWeatherData(), await dao?.coordDao.findCoordData(), await dao?.cloudsDao.findCloudsData(), await dao?.windDao.findWindData(), await dao?.mainDao.findMainData(), await dao?.sysDao.findSysData(), await dao?.weatherTableDao.findWeather());

      isLoading = true;
      notifyListeners();
    }




    return daoDb;
  }
}