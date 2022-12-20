

import 'package:floor/floor.dart';


import '../models/sys.dart';

@dao
abstract class SysDao {
  @Query('SELECT * FROM sysData')
  Future<Sys?> findSysData();

  @insert
  Future<void> insertSysData(Sys sys);

  @Query('delete from sysData')
  Future<void> deleteTasks();

  @Query('SELECT COUNT(*) FROM sysData')
  Future<int?> tableIsEmpty();
}