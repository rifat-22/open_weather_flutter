class Dao {
  late final coordDao;
  late final weatherDao;
  late final cloudsDao;
  late final windDao;
  late final mainDao;
  late final sysDao;
  late final weatherTableDao;

  Dao(final database){
    coordDao = database.coordDao;
    weatherDao = database.weatherDataDao;
    cloudsDao = database.cloudsDao;
    windDao = database.windDao;
    mainDao = database.mainDao;
    sysDao = database.sysDao;
    weatherTableDao = database.weatherDao;
  }
}