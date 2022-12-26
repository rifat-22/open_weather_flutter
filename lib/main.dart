import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/repository/provider_model.dart';
import 'package:weather_app/repository/repo_to_db.dart';


import 'database_dao/database.dart';
import 'view/weather_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  runApp(MyApp(Dao(database)));
}

class MyApp extends StatelessWidget {
  MyApp(this.dao);

   Dao dao;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderModel(dao),
      child: MaterialApp(
        routes: {
          '/': (context) => WeatherScreen(Key('db_data'), dao),
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
