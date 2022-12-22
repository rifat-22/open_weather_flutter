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
}
