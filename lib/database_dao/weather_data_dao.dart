

import 'package:floor/floor.dart';

import 'package:weather_app/models/weather_data.dart';

@dao
abstract class WeatherDataDao {
  @Query('SELECT * FROM weatherData')
  Future<WeatherData?> findWeatherData();


  @insert
  Future<void> insertWeatherData(WeatherData weatherData);

  @Query('delete from weatherData')
  Future<void> deleteTasks();

  @Query('SELECT COUNT(*) FROM weatherData')
  Future<int?> tableIsEmpty();
}