import 'package:flutter/material.dart';

import 'package:weather_app/repository/repo_to_db.dart';

import 'package:weather_app/repository/weather_repository.dart';
import '../database_dao/dao/dao_db.dart';

class ProviderModel extends ChangeNotifier {
  final _service = WeatherRepository();
  bool isLoading = false;
  Dao? dao;
  // local db
  DaoDb? daoDb;
  DataFlow? _dataFlow;

  ProviderModel(Dao? dao) {
    this.dao = dao;
  }

  DataFlow? get dataFlow => _dataFlow;

  Future<DaoDb?> getWeatherData() async {
    try {
      _dataFlow =
          await _service.fetchWeatherData();

      if (dataFlow?.statuscode == 200) {
        print("weather data not null");
        //delete data
        if (await dao?.cloudsDao.tableIsEmpty !=
            0) {
          await dao?.coordDao.deleteTasks();
        }
        if (await dao?.weatherDao.tableIsEmpty !=
            0) {
          await dao?.weatherDao.deleteTasks();
        }
        if (await dao?.cloudsDao.tableIsEmpty !=
            0) {
          await dao?.cloudsDao.deleteTasks();
        }
        if (await dao?.windDao.tableIsEmpty !=
            0) {
          await dao?.windDao.deleteTasks();
        }
        if (await dao?.mainDao.tableIsEmpty !=
            0) {
          await dao?.mainDao.deleteTasks();
        }
        if (await dao?.sysDao.tableIsEmpty != 0) {
          await dao?.sysDao.deleteTasks();
        }
        if (await dao
                ?.weatherTableDao.tableIsEmpty !=
            0) {
          await dao?.weatherTableDao
              .deleteTasks();
        }

        //insert data
        await dao?.coordDao.insertCoordData(
            dataFlow!.weatherData!.coord!);
        await dao?.weatherDao.insertWeatherData(
            dataFlow!.weatherData!);
        await dao?.cloudsDao.insertCloudsData(
            dataFlow!.weatherData!.clouds!);
        await dao?.windDao.insertWindData(
            dataFlow!.weatherData!.wind!);
        await dao?.mainDao.insertMainData(
            dataFlow!.weatherData!.main!);
        await dao?.sysDao.insertSysData(
            dataFlow!.weatherData!.sys!);
        await dao?.weatherTableDao.insertWeather(
            dataFlow!.weatherData!.weather![0]);

        daoDb = DaoDb(
            await dao?.weatherDao
                .findWeatherData(),
            await dao?.coordDao.findCoordData(),
            await dao?.cloudsDao.findCloudsData(),
            await dao?.windDao.findWindData(),
            await dao?.mainDao.findMainData(),
            await dao?.sysDao.findSysData(),
            await dao?.weatherTableDao
                .findWeather());

        isLoading = false;
        notifyListeners();
      } else {
        print("weather is null");
        daoDb = DaoDb(
            await dao?.weatherDao
                .findWeatherData(),
            await dao?.coordDao.findCoordData(),
            await dao?.cloudsDao.findCloudsData(),
            await dao?.windDao.findWindData(),
            await dao?.mainDao.findMainData(),
            await dao?.sysDao.findSysData(),
            await dao?.weatherTableDao
                .findWeather());

        isLoading = true;
        notifyListeners();
      }
    } catch (e) {
      print("catch.........");
      daoDb = DaoDb(
          await dao?.weatherDao.findWeatherData(),
          await dao?.coordDao.findCoordData(),
          await dao?.cloudsDao.findCloudsData(),
          await dao?.windDao.findWindData(),
          await dao?.mainDao.findMainData(),
          await dao?.sysDao.findSysData(),
          await dao?.weatherTableDao
              .findWeather());
      isLoading = false;
      notifyListeners();
    }
    return daoDb;
  }
}
