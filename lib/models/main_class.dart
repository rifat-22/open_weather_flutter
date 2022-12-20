import 'package:floor/floor.dart';

@Entity(tableName: 'mainData')
class MainClass {
  @PrimaryKey(autoGenerate: true)
  int? db_id;
  final double? temp;
  final double? feels_like;
  final double? temp_min;
  final double? temp_max;
  final int? pressure;
  final int? humidity;
  final int? sea_level;
  final int? grnd_level;

   MainClass({
     this.temp,
     this.feels_like,
     this.temp_min,
     this.temp_max,
     this.pressure,
     this.humidity,
     this.sea_level,
     this.grnd_level,
  });

  factory MainClass.fromJson(
      Map<String, dynamic> json) {
    return MainClass(
      temp: json['temp'],
      feels_like: json['feels_like'],
      temp_min: json['temp_min'],
      temp_max: json['temp_max'],
      pressure: json['pressure'],
      humidity: json['humidity'],
      sea_level: json['sea_level'],
      grnd_level: json['grnd_level'],
    );
  }

  Map<String, dynamic> toJson() => {
    "temp": temp,
    "feels_like": feels_like,
    "temp_min": temp_min,
    "temp_max": temp_max,
    "pressure": pressure,
    "humidity": humidity,
    "sea_level": sea_level,
    "grnd_level": grnd_level,
  };
}
