import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/clouds.dart';
import 'package:weather_app/models/coord.dart';
import 'package:weather_app/models/main_class.dart';
import 'package:weather_app/models/weather.dart';

import '../models/sys.dart';
import '../models/weather_data.dart';
import '../models/wind.dart';

class WeatherScreen extends StatefulWidget {
  final coordDao;
  final weatherDao;
  final cloudsDao;
  final windDao;
  final mainDao;
  final sysDao;
  final weatherTableDao;

  WeatherScreen(Key key, this.coordDao, this.weatherDao, this.cloudsDao, this.windDao, this.mainDao, this.sysDao, this.weatherTableDao)
      : super(key: key);
  @override
  _WeatherScreenState createState() =>
      _WeatherScreenState();
}

class _WeatherScreenState
    extends State<WeatherScreen> {

  late Future<WeatherData> futureAlbum;
  int isFetchedData = 0;
  WeatherData? weatherData;

  //local db
  WeatherData? weatherDataDb;
  Coord? coordDb;
  Clouds? cloudsDb;
  Wind? windDb;
  MainClass? mainClassDb;
  Sys? sysDb;
  Weather? weatherDb;


  late double? feel_like_temp;
  late double? actual_temp;
  late double? temp_max;
  late double? temp_min;
  var date1;
  var date2;
  late String? sunrise;
  late String? sunset;
  var fallback = Stack(
    children: [
      CircularProgressIndicator()
    ],
  );

  Future<WeatherData> fetchAlbum() async {

    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=23.00&lon=90.00&appid=36d27fc4a354ee22fad96e3c9e975575'));

    if (response.statusCode == 200) {
      print("Yaaaaaayy");
      weatherData = WeatherData.fromJson(
          jsonDecode(response.body));

      //delete data
     if (await widget.coordDao.tableIsEmpty != 0) {
       await widget.coordDao.deleteTasks();
     }
      if (await widget.weatherDao.tableIsEmpty != 0) {
        await widget.weatherDao.deleteTasks();
      }
      if (await widget.cloudsDao.tableIsEmpty != 0) {
        await widget.cloudsDao.deleteTasks();
      }
      if (await widget.windDao.tableIsEmpty != 0) {
        await widget.windDao.deleteTasks();
      }
      if (await widget.mainDao.tableIsEmpty != 0) {
        await widget.mainDao.deleteTasks();
      }
      if (await widget.sysDao.tableIsEmpty != 0) {
        await widget.sysDao.deleteTasks();
      }
      if (await widget.weatherTableDao.tableIsEmpty != 0) {
        await widget.weatherTableDao.deleteTasks();
      }

      //insert data
      await widget.coordDao.insertCoordData(weatherData!.coord!);
      await widget.weatherDao.insertWeatherData(weatherData!);
      await widget.cloudsDao.insertCloudsData(weatherData!.clouds!);
      await widget.windDao.insertWindData(weatherData!.wind!);
      await widget.mainDao.insertMainData(weatherData!.main!);
      await widget.sysDao.insertSysData(weatherData!.sys!);
      await widget.weatherTableDao.insertWeather(weatherData!.weather![0]);



      //assign
      coordDb = await widget.coordDao.findCoordData();
      weatherDataDb = await widget.weatherDao.findWeatherData();
      cloudsDb = await widget.cloudsDao.findCloudsData();
      windDb = await widget.windDao.findWindData();
      mainClassDb = await widget.mainDao.findMainData();
      sysDb = await widget.sysDao.findSysData();
      weatherDb = await widget.weatherTableDao.findWeather();

      setState(()  {
        isFetchedData = 1;
      });


      return WeatherData.fromJson(
          jsonDecode(response.body));
    } else {
      coordDb = await widget.coordDao.findCoordData();
      weatherDataDb = await widget.weatherDao.findWeatherData();
      cloudsDb = await widget.cloudsDao.findCloudsData();
      windDb = await widget.windDao.findWindData();
      mainClassDb = await widget.mainDao.findMainData();
      sysDb = await widget.sysDao.findSysData();
      weatherDb = await widget.weatherTableDao.findWeather();
      isFetchedData = 2;
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    super.initState();

    fetchAlbum().then((result) {
      print(result);
      setState(() {
        weatherData = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    if (weatherData != null) {
      feel_like_temp = mainClassDb!.feels_like!.toDouble() - 273.15;
      actual_temp = mainClassDb!.temp!.toDouble() - 273.15;
      temp_max = mainClassDb!.temp_max!.toDouble() - 273.15;
      temp_min = mainClassDb!.temp_min!.toDouble() - 273.15;
      date1 =
          new DateTime.fromMillisecondsSinceEpoch(
              sysDb!.sunrise! * 1000);
      date2 =
          new DateTime.fromMillisecondsSinceEpoch(
              sysDb!.sunset! * 1000);
      sunrise = DateFormat.Hm().format(date1);
      sunset = DateFormat.Hm().format(date2);
    } else {
      // isFetchedData = 0;
      feel_like_temp = 0;
      actual_temp = 0;
      temp_max = 0;
      temp_min = 0;
      sunset = "";
      sunrise = "";
    }

    return Scaffold(
        backgroundColor: Colors.white60,
        body:  Padding(
                padding:
                    const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.start,
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 10,
                      child: SizedBox(
                        height: 400,
                        width:
                            MediaQuery.of(context)
                                .size
                                .width,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              color:
                                  Colors.blueGrey,
                              borderRadius:
                                  BorderRadius
                                      .all(Radius
                                          .circular(
                                              00))),
                          child: Column(
                            children: [
                              Spacer(),
                              Text(
                                '${weatherDataDb?.name ?? " "},${sysDb?.country ?? ""}'
                                    .toUpperCase(),
                                textAlign:
                                    TextAlign
                                        .center,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  // fontStyle: FontStyle.italic,
                                  fontWeight:
                                      FontWeight
                                          .bold,
                                  color: Colors
                                      .black,
                                  wordSpacing: 8,
                                  letterSpacing:
                                      2,
                                ),
                              ),
                              Text(
                                '${weatherDb?.description ?? ""}',
                                textAlign:
                                    TextAlign
                                        .center,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  // fontStyle: FontStyle.italic,
                                  fontWeight:
                                      FontWeight
                                          .normal,
                                  color: Colors
                                      .black,
                                ),
                              ),
                              Text(
                                'Feels Like ${feel_like_temp?.toStringAsFixed(2)}°C',
                                textAlign:
                                    TextAlign
                                        .center,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  // fontStyle: FontStyle.italic,
                                  fontWeight:
                                      FontWeight
                                          .normal,
                                  color: Colors
                                      .black,
                                ),
                              ),
                              Text(
                                'Coord ${coordDb?.lan}',
                                textAlign:
                                TextAlign
                                    .center,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  // fontStyle: FontStyle.italic,
                                  fontWeight:
                                  FontWeight
                                      .normal,
                                  color: Colors
                                      .black,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Sunrise ${sunrise} AM',
                                textAlign:
                                    TextAlign
                                        .center,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  // fontStyle: FontStyle.italic,
                                  fontWeight:
                                      FontWeight
                                          .normal,
                                  color: Colors
                                      .black,
                                ),
                              ),
                              Text(
                                'Sunset ${sunset} PM',
                                textAlign:
                                    TextAlign
                                        .center,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  // fontStyle: FontStyle.italic,
                                  fontWeight:
                                      FontWeight
                                          .normal,
                                  color: Colors
                                      .black,
                                ),
                              ),
                              (weatherDb?.icon != null) ? CachedNetworkImage(
                            imageUrl: "http://openweathermap.org/img/wn/${weatherDb!.icon}@2x.png",
                            placeholder: (context, url) {
                              return Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              );
                            },
                          ): fallback,
                              // Image.network(
                              //     'http://openweathermap.org/img/wn/${weatherData?.weather?[0].icon}@2x.png'),
                              Padding(
                                padding:
                                    EdgeInsets
                                        .fromLTRB(
                                            8.0,
                                            0.0,
                                            8.0,
                                            10),
                                child: Text(
                                  "${actual_temp?.toStringAsFixed(0)}°C",
                                  textAlign:
                                      TextAlign
                                          .center,
                                  style:
                                      TextStyle(
                                    fontSize:
                                        60.0,
                                    // fontStyle: FontStyle.italic,
                                    fontWeight:
                                        FontWeight
                                            .normal,
                                    color: Colors
                                        .black,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets
                                            .only(
                                        bottom:
                                            20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment
                                          .center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment
                                          .end,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment
                                              .center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment
                                              .center,
                                      children: [
                                        Text(
                                            "max"),
                                        Text(
                                            "${temp_max?.toStringAsFixed(0)}°C"),
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.all(
                                              8.0),
                                      child: Container(
                                          height: 10,
                                          child: VerticalDivider(
                                            color:
                                                Colors.black,
                                            thickness:
                                                2,
                                          )),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment
                                              .center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment
                                              .center,
                                      children: [
                                        Text(
                                            "min"),
                                        Text(
                                            "${temp_min?.toStringAsFixed(0)}°C"),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 10),
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment
                                .center,
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .center,
                        children: [
                          boxelement(
                              "Pressure",
                              "${mainClassDb?.pressure}",
                              "hPa"),
                          boxelement(
                              "Humidity",
                              "${mainClassDb?.humidity}",
                              "%"),
                          Visibility(
                              visible: weatherData
                                      ?.main
                                      ?.sea_level !=
                                  null,
                              child: boxelement(
                                  "Sea level\npressure",
                                  "${mainClassDb?.sea_level}",
                                  "hPa")),
                          Visibility(
                              visible: weatherData
                                      ?.main
                                      ?.grnd_level !=
                                  null,
                              child: boxelement(
                                  "Ground level\npressure",
                                  "${mainClassDb?.grnd_level}",
                                  "hPa")),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .center,
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .center,
                      children: [
                        boxelement(
                            "Visibility",
                            "${weatherDataDb?.visibility}",
                            "m"),
                        boxelement(
                            "Wind\nSpeed",
                            "${windDb?.speed}",
                            "m/s"),
                        boxelement(
                            "Wind\nDegree",
                            "${windDb?.deg}",
                            "°"),
                        boxelement(
                            "Cloudiness",
                            "${cloudsDb?.all}",
                            "%")
                      ],
                    ),
                  ],
                ),
        )
              );
  }

  Widget boxelement(
      String title, String value, String unit) {
    return Card(
      elevation: 5,
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.all(
              Radius.circular(00),
            )),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: SizedBox(
              height: 70,
              width: 70,
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 12),
                  ),
                  SizedBox(height: 10),
                  Text(
                    value + unit,
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
