// database.dart

// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:weather_app/database_dao/clouds_dao.dart';
import 'package:weather_app/database_dao/main_dao.dart';
import 'package:weather_app/database_dao/sys_dao.dart';
import 'package:weather_app/database_dao/weather_dao.dart';
import 'package:weather_app/database_dao/wind_dao.dart';
import 'package:weather_app/models/clouds.dart';
import 'package:weather_app/models/coord.dart';
import 'package:weather_app/models/main_class.dart';
import 'package:weather_app/models/sys.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/models/weather_data.dart';
import 'package:weather_app/models/wind.dart';

import 'coord_dao.dart';
import 'weather_data_dao.dart';



part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Coord, WeatherData, Clouds, Wind, MainClass, Sys, Weather])
abstract class AppDatabase extends FloorDatabase {
  CoordDao get coordDao;
  WeatherDataDao get weatherDataDao;
  CloudsDao get cloudsDao;
  WindDao get windDao;
  MainDao get mainDao;
  SysDao get sysDao;
  WeatherDao get weatherDao;
}