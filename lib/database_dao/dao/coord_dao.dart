import 'package:floor/floor.dart';
import 'package:weather_app/models/coord.dart';

@dao
abstract class CoordDao {
  @Query('SELECT * FROM coordData')
  Future<Coord?> findCoordData();

  @insert
  Future<void> insertCoordData(Coord coord);

  @Query('delete from coordData')
  Future<void> deleteTasks();

  @Query('SELECT COUNT(*) FROM coordData')
  Future<int?> tableIsEmpty();

}