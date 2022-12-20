import 'package:floor/floor.dart';

@Entity(tableName: 'windData')
class Wind {
  @PrimaryKey(autoGenerate: true)
  int? db_id;

  final double? speed;
  final double? deg;

  Wind({
     this.speed,
     this.deg,
  });

  factory Wind.fromJson(
      Map<String, dynamic> json) {
    return Wind(
      speed: json['speed'] is int ? (json['speed'] as int).toDouble() : json['speed'],
      deg: json['deg'] is int ? (json['deg'] as int).toDouble() : json['deg'],
    );
  }
  Map<String, dynamic> toJson() => {
    "speed": speed,
    "deg": deg,
  };
}
