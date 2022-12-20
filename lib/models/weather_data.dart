import 'package:floor/floor.dart';

import 'clouds.dart';
import 'coord.dart';
import 'main_class.dart';
import 'sys.dart';
import 'weather.dart';
import 'wind.dart';

@Entity(tableName: 'weatherData')
class WeatherData {
  @PrimaryKey(autoGenerate: true)
  int? db_id;
  @ignore
  final Coord? coord;
  @ignore
  final List<Weather>? weather;
  final String? base;
  @ignore
  final MainClass? main;
  final int? visibility;
  @ignore
  final Wind? wind;
  @ignore
  final Clouds? clouds;
  final int? dt;
  @ignore
  final Sys? sys;
  final int? timezone;
  final int? id;
  final String? name;
  final int? cod;
  WeatherData({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.wind,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });

  factory WeatherData.fromJson(
      Map<String, dynamic> json) {
    var list = json['weather'] as List;
    List<Weather> weather = list
        .map((i) => Weather.fromJson(i))
        .toList();
    return WeatherData(
      coord: Coord.fromJson(json["coord"]),
      weather: weather,
      base: json['base'],
      main: MainClass.fromJson(json["main"]),
      visibility: json['visibility'],
      wind: Wind.fromJson(json["wind"]),
      clouds: Clouds.fromJson(json["clouds"]),
      dt: json['dt'],
      sys: Sys.fromJson(json["sys"]),
      timezone: json['timezone'],
      id: json['id'],
      name: json['name'],
      cod: json['cod'],
    );
  }

  Map<String, dynamic> toJson() => {
    "coord": coord?.toJson(),
    "weather": weather?.map((e) => e.toJson()).toList(),
    "base": base,
    "main": main?.toJson(),
    "visibility": visibility,
    "wind": wind?.toJson(),
    "clouds": clouds,
    "dt": dt,
    "sys": sys?.toJson(),
    "timezone": timezone,
    "id": id,
    "name": name,
    "cod": cod,
  };

}
