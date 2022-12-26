
import 'package:floor/floor.dart';
import 'package:weather_app/models/coord.dart';
import 'package:weather_app/models/main_class.dart';

@dao
abstract class MainDao {
  @Query('SELECT * FROM mainData')
  Future<MainClass?> findMainData();

  @insert
  Future<void> insertMainData(MainClass mainClass);

  @Query('delete from mainData')
  Future<void> deleteTasks();

  @Query('SELECT COUNT(*) FROM mainData')
  Future<int?> tableIsEmpty();
}