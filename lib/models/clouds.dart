import 'package:floor/floor.dart';

@Entity(tableName: 'cloudsData')
class Clouds {
  @PrimaryKey(autoGenerate: true)
  int? db_id;
  final int? all;

   Clouds({
     this.all,
  });

  factory Clouds.fromJson(
      Map<String, dynamic> json) {
    return Clouds(
      all: json['all'],
    );
  }
  Map<String, dynamic> toJson() => {
    "all": all,
  };
}
