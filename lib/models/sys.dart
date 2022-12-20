import 'package:floor/floor.dart';

@Entity(tableName: 'sysData')
class Sys {
  final int? type;
  @PrimaryKey()
  final int? id;
  final String? country;
  final int? sunrise;
  final int? sunset;

   Sys({
     this.type,
     this.id,
     this.country,
     this.sunrise,
     this.sunset,
  });

  factory Sys.fromJson(
      Map<String, dynamic> json) {
    return Sys(
      type: json['type'],
      id: json['id'],
      country: json['country'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
    );
  }
  Map<String, dynamic> toJson() => {
    "type": type,
    "id": id,
    "country": country,
    "sunrise": sunrise,
    "sunset": sunset,
  };
}
