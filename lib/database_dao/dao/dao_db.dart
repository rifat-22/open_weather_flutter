import '../../models/clouds.dart';
import '../../models/coord.dart';
import '../../models/main_class.dart';
import '../../models/sys.dart';
import '../../models/weather.dart';
import '../../models/weather_data.dart';
import '../../models/wind.dart';

class DaoDb {
  WeatherData? weatherDataDb;
  Coord? coordDb;
  Clouds? cloudsDb;
  Wind? windDb;
  MainClass? mainClassDb;
  Sys? sysDb;
  Weather? weatherDb;

  DaoDb(WeatherData weatherData, Coord coord, Clouds clouds, Wind wind, MainClass mainClass, Sys sys, Weather weather) {
    this.weatherDataDb = weatherData;
    this.coordDb = coord;
    this.cloudsDb = clouds;
    this.windDb = wind;
    this.mainClassDb = mainClass;
    this.sysDb = sys;
    this.weatherDb = weather;

  }
}