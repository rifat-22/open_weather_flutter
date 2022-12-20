import 'package:flutter/material.dart';

import 'database_dao/database.dart';
import 'view/weather_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

  //initialize
  final coordDao = database.coordDao;
  final weatherDao = database.weatherDataDao;
  final cloudsDao = database.cloudsDao;
  final windDao = database.windDao;
  final mainDao = database.mainDao;
  final sysDao = database.sysDao;
  final weatherTableDao = database.weatherDao;

  runApp(MyApp(coordDao, weatherDao, cloudsDao, windDao, mainDao, sysDao, weatherTableDao));
}

class MyApp extends StatelessWidget {
  MyApp(this.coordDao, this.weatherDao, this.cloudsDao, this.windDao, this.mainDao, this.sysDao, this.weatherTableDao);

  final coordDao;
  final weatherDao;
  final cloudsDao;
  final windDao;
  final mainDao;
  final sysDao;
  final weatherTableDao;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherScreen(Key('db_data'), coordDao, weatherDao , cloudsDao, windDao, mainDao, sysDao, weatherTableDao),
    );
  }
}
