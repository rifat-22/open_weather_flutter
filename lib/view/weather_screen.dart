import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/clouds.dart';
import 'package:weather_app/models/coord.dart';
import 'package:weather_app/models/main_class.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/repository/dao_db.dart';
import 'package:weather_app/repository/provider_model.dart';

import '../models/sys.dart';
import '../models/weather_data.dart';
import '../models/wind.dart';
import '../repository/repo_to_db.dart';
import '../repository/weather_model.dart';

class WeatherScreen extends StatefulWidget {
  final Dao dao;
  WeatherScreen(Key key, this.dao)
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
  DaoDb? daoDb;

  // //local db
  // WeatherData? weatherDataDb;
  // Coord? coordDb;
  // Clouds? cloudsDb;
  // Wind? windDb;
  // MainClass? mainClassDb;
  // Sys? sysDb;
  // Weather? weatherDb;


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
  //
  // Future<WeatherData> fetchAlbum() async {
  //
  //   final response = await http.get(Uri.parse(
  //       'https://api.openweathermap.org/data/2.5/weather?lat=23.00&lon=90.00&appid=36d27fc4a354ee22fad96e3c9e975575'));
  //
  //   if (response.statusCode == 200) {
  //     print("Yaaaaaayy");
  //     weatherData = WeatherData.fromJson(
  //         jsonDecode(response.body));
  //
  //    //  //delete data
  //    if (await widget.dao.cloudsDao.tableIsEmpty != 0) {
  //      await widget.dao.coordDao.deleteTasks();
  //    }
  //     if (await widget.dao.weatherDao.tableIsEmpty != 0) {
  //       await widget.dao.weatherDao.deleteTasks();
  //     }
  //     if (await widget.dao.cloudsDao.tableIsEmpty != 0) {
  //       await widget.dao.cloudsDao.deleteTasks();
  //     }
  //     if (await widget.dao.windDao.tableIsEmpty != 0) {
  //       await widget.dao.windDao.deleteTasks();
  //     }
  //     if (await widget.dao.mainDao.tableIsEmpty != 0) {
  //       await widget.dao.mainDao.deleteTasks();
  //     }
  //     if (await widget.dao.sysDao.tableIsEmpty != 0) {
  //       await widget.dao.sysDao.deleteTasks();
  //     }
  //     if (await widget.dao.weatherTableDao.tableIsEmpty != 0) {
  //       await widget.dao.weatherTableDao.deleteTasks();
  //     }
  //
  //     //insert data
  //     await widget.dao.coordDao.insertCoordData(weatherData!.coord!);
  //     await widget.dao.weatherDao.insertWeatherData(weatherData!);
  //     await widget.dao.cloudsDao.insertCloudsData(weatherData!.clouds!);
  //     await widget.dao.windDao.insertWindData(weatherData!.wind!);
  //     await widget.dao.mainDao.insertMainData(weatherData!.main!);
  //     await widget.dao.sysDao.insertSysData(weatherData!.sys!);
  //     await widget.dao.weatherTableDao.insertWeather(weatherData!.weather![0]);
  //
  //
  //
  //     //assign
  //     coordDb = await widget.dao.coordDao.findCoordData();
  //     weatherDataDb = await widget.dao.weatherDao.findWeatherData();
  //     cloudsDb = await widget.dao.cloudsDao.findCloudsData();
  //     windDb = await widget.dao.windDao.findWindData();
  //     mainClassDb = await widget.dao.mainDao.findMainData();
  //     sysDb = await widget.dao.sysDao.findSysData();
  //     weatherDb = await widget.dao.weatherTableDao.findWeather();
  //
  //     setState(()  {
  //       isFetchedData = 1;
  //     });
  //
  //
  //     return WeatherData.fromJson(
  //         jsonDecode(response.body));
  //   } else {
  //     coordDb = await widget.dao.coordDao.findCoordData();
  //     weatherDataDb = await widget.dao.weatherDao.findWeatherData();
  //     cloudsDb = await widget.dao.cloudsDao.findCloudsData();
  //     windDb = await widget.dao.windDao.findWindData();
  //     mainClassDb = await widget.dao.mainDao.findMainData();
  //     sysDb = await widget.dao.sysDao.findSysData();
  //     weatherDb = await widget.dao.weatherTableDao.findWeather();
  //     isFetchedData = 2;
  //     throw Exception('Failed to load album');
  //   }
  // }

  @override
  void initState() {
    super.initState();

    // fetchAlbum().then((result) {
    //   print(result);
    //   setState(() {
    //     weatherData = result;
    //   });
    // });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      daoDb = await Provider.of<ProviderModel>(context, listen: false).getWeatherData();
    });
  }

  @override
  Widget build(BuildContext context) {



    return  Scaffold(
    backgroundColor: Colors.white60,
    body: Consumer<ProviderModel> (
      builder: (context, value, child) {

        if (daoDb != null) {
          feel_like_temp = daoDb!.mainClassDb!.feels_like!.toDouble() - 273.15;
          actual_temp = daoDb!.mainClassDb!.temp!.toDouble() - 273.15;
          temp_max = daoDb!.mainClassDb!.temp_max!.toDouble() - 273.15;
          temp_min = daoDb!.mainClassDb!.temp_min!.toDouble() - 273.15;
          date1 =
              new DateTime.fromMillisecondsSinceEpoch(daoDb!.sysDb!.sunrise! * 1000);
          date2 =
              new DateTime.fromMillisecondsSinceEpoch(daoDb!.sysDb!.sunset! * 1000);
          sunrise = DateFormat.Hm().format(date1);
          sunset = DateFormat.Hm().format(date2);
        } else {
          feel_like_temp = 0;
          actual_temp = 0;
          temp_max = 0;
          temp_min = 0;
          sunset = "";
          sunrise = "";
        }

        if (value.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );

        }
        return Padding(
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
                  MediaQuery
                      .of(context)
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
                          '${daoDb?.weatherDataDb?.name ?? " "},${daoDb?.sysDb?.country ?? ""}'
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
                          '${daoDb?.weatherDb?.description ?? ""}',
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
                        (daoDb?.weatherDb?.icon != null) ? CachedNetworkImage(
                          imageUrl: "http://openweathermap.org/img/wn/${daoDb?.weatherDb!
                              .icon}@2x.png",
                          placeholder: (context, url) {
                            return Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            );
                          },
                        ) : fallback,
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
                        "${daoDb?.mainClassDb?.pressure}",
                        "hPa"),
                    boxelement(
                        "Humidity",
                        "${daoDb?.mainClassDb?.humidity}",
                        "%"),
                    Visibility(
                        visible: weatherData
                            ?.main
                            ?.sea_level !=
                            null,
                        child: boxelement(
                            "Sea level\npressure",
                            "${daoDb?.mainClassDb?.sea_level}",
                            "hPa")),
                    Visibility(
                        visible: weatherData
                            ?.main
                            ?.grnd_level !=
                            null,
                        child: boxelement(
                            "Ground level\npressure",
                            "${daoDb?.mainClassDb?.grnd_level}",
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
                      "${daoDb?.weatherDataDb?.visibility}",
                      "m"),
                  boxelement(
                      "Wind\nSpeed",
                      "${daoDb?.windDb?.speed}",
                      "m/s"),
                  boxelement(
                      "Wind\nDegree",
                      "${daoDb?.windDb?.deg}",
                      "°"),
                  boxelement(
                      "Cloudiness",
                      "${daoDb?.cloudsDb?.all}",
                      "%")
                ],
              ),
            ],
          ),
        );
      }
    ),
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
