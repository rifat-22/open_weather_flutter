import '../models/clouds.dart';
import '../models/coord.dart';
import '../models/main_class.dart';
import '../models/sys.dart';
import '../models/weather.dart';
import '../models/weather_data.dart';
import '../models/wind.dart';

class LocalDatabase {
  WeatherData? weatherDataDb;
  Coord? coordDb;
  Clouds? cloudsDb;
  Wind? windDb;
  MainClass? mainClassDb;
  Sys? sysDb;
  Weather? weatherDb;
  // insertData(WeatherData weatherDataDb, Coord coordDb, Clouds cloudsDb, Wind? windDb, MainClass mainClassDb, Sys sysDb, Weather weatherDb){
  //   this.weatherDataDb = weatherDataDb;
  //   this.coordDb = coordDb;
  //   this.cloudsDb = cloudsDb;
  //   this.windDb = windDb;
  //   this.mainClassDb = mainClassDb;
  //   this.sysDb = sysDb;
  //   this.weatherDb = weatherDb;
  // }
}