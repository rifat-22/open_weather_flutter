

import 'package:floor/floor.dart';


import '../../models/weather.dart';

@dao
abstract class WeatherDao {
  @Query('SELECT * FROM weatherTable')
  Future<Weather?> findWeather();


  @insert
  Future<void> insertWeather(Weather weather);

  @Query('delete from weatherTable')
  Future<void> deleteTasks();


  @Query('SELECT COUNT(*) FROM weatherTable')
  Future<int?> tableIsEmpty();
}