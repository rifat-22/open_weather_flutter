import 'package:floor/floor.dart';

@Entity(tableName: 'coordData')
class Coord {
  @PrimaryKey(autoGenerate: true)
  int? db_id;

  double? lan;
  double? lat;

  Coord({
    this.lan,
    this.lat,
  });

  factory Coord.fromJson(
      Map<String, dynamic> json) {
    return Coord(
      lan: json["lat"] is int ? (json['lat'] as int).toDouble() : json['lat'],
      lat: json["lan"] is int ? (json['lan'] as int).toDouble() : json['lan'],
    );
  }
  Map<String, dynamic> toJson() => {
    "lan": lan,
    "lat": lat,
  };


}
