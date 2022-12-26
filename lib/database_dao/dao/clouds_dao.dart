import 'package:floor/floor.dart';
import 'package:weather_app/models/clouds.dart';


@dao
abstract class CloudsDao {
  @Query('SELECT * FROM cloudsData')
  Future<Clouds?> findCloudsData();

  @insert
  Future<void> insertCloudsData(Clouds clouds);

  @Query('delete from cloudsData')
  Future<void> deleteTasks();

  @Query('SELECT COUNT(*) FROM cloudsData')
  Future<int?> tableIsEmpty();
}