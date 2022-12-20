

import 'package:floor/floor.dart';


import '../models/wind.dart';

@dao
abstract class WindDao {
  @Query('SELECT * FROM windData')
  Future<Wind?> findWindData();


  @insert
  Future<void> insertWindData(Wind wind);

  @Query('delete from windData')
  Future<void> deleteTasks();

  @Query('SELECT COUNT(*) FROM windData')
  Future<int?> tableIsEmpty();
}