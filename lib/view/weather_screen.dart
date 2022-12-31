import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/database_dao/dao/dao_db.dart';
import 'package:weather_app/repository/provider_model.dart';
import '../common/color_util.dart';
import '../repository/repo_to_db.dart';

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
  DaoDb? daoDb;

  late double? feel_like_temp;
  late double? actual_temp;
  late double? temp_max;
  late double? temp_min;
  var date1;
  var date2;
  late String? sunrise;
  late String? sunset;
  var fallback = Stack(
    children: [CircularProgressIndicator()],
  );

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) async {
      daoDb = await Provider.of<ProviderModel>(
              context,
              listen: false)
          .getWeatherData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      backgroundColor: ColorUtil.bgWhite,
      resizeToAvoidBottomInset: false,
      body: Consumer<ProviderModel>(
          builder: (context, value, child) {
        if (daoDb != null) {
          feel_like_temp = daoDb!
                  .mainClassDb!.feels_like!
                  .toDouble() -
              273.15;
          actual_temp = daoDb!.mainClassDb!.temp!
                  .toDouble() -
              273.15;
          temp_max = daoDb!.mainClassDb!.temp_max!
                  .toDouble() -
              273.15;
          temp_min = daoDb!.mainClassDb!.temp_min!
                  .toDouble() -
              273.15;
          date1 = new DateTime
                  .fromMillisecondsSinceEpoch(
              daoDb!.sysDb!.sunrise! * 1000);
          date2 = new DateTime
                  .fromMillisecondsSinceEpoch(
              daoDb!.sysDb!.sunset! * 1000);
          sunrise =
              DateFormat('hh:mm a').format(date1);
          sunset =
              DateFormat('hh:mm a').format(date2);
        } else {
          feel_like_temp = 0;
          actual_temp = 0;
          temp_max = 0;
          temp_min = 0;
          sunset = "";
          sunrise = "";
        }
        return _weatherPage(context);
      }),
    );
  }

  Widget boxelement(
      String title, String value, String unit) {
    return Expanded(
      child: Card(
        elevation: 5,
        color: ColorUtil.punch_btn_2,
        shadowColor: ColorUtil.bgGreyDark,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 8.0),
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
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight:
                            FontWeight.w500),
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

  Widget _weatherPage(BuildContext context) {
    return Column(children: [
      Container(
        //height: MediaQuery.of(context).size.height * 0.40,
        padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
        color: ColorUtil.bgGrey,
        child: Card(
          color: ColorUtil.punch_btn_2,
          child: Padding(
            padding:
                EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: 15,
                ),
                Text(
                  '${daoDb?.weatherDataDb?.name ?? " "},${daoDb?.sysDb?.country ?? ""}'
                      .toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    // fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    wordSpacing: 8,
                    letterSpacing: 2,
                  ),
                ),
                Text(
                  '${daoDb?.weatherDb?.description ?? ""}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.0,
                    // fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Feels Like ${feel_like_temp?.toStringAsFixed(2)}°C',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.0,
                    // fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
                ClipRRect(
                  child: (daoDb
                              ?.weatherDb?.icon !=
                          null)
                      ? CachedNetworkImage(
                          imageUrl:
                              "http://openweathermap.org/img/wn/${daoDb?.weatherDb!.icon}@2x.png",
                          placeholder:
                              (context, url) {
                            return Center(
                              child:
                                  CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            );
                          },
                        )
                      : fallback,
                ),
                Text(
                  'Sunrise ${sunrise}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Sunset ${sunset}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.0,
                    // fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      8.0, 0.0, 8.0, 10),
                  child: Text(
                    "${actual_temp?.toStringAsFixed(0)}°C",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 60.0,
                      // fontStyle: FontStyle.italic,
                      fontWeight:
                          FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  crossAxisAlignment:
                      CrossAxisAlignment.end,
                  children: [
                    Column(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .center,
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .center,
                      children: [
                        Text("max"),
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
                            color: Colors.black,
                            thickness: 2,
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
                        Text("min"),
                        Text(
                            "${temp_min?.toStringAsFixed(0)}°C"),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
        // height: MediaQuery.of(context).size.height * 0.10,
        color: ColorUtil.bgGrey,
        width: double.infinity,
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.center,
          crossAxisAlignment:
              CrossAxisAlignment.center,
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
                visible: daoDb?.mainClassDb
                        ?.sea_level !=
                    null,
                child: boxelement(
                    "Sea level\npressure",
                    "${daoDb?.mainClassDb?.sea_level}",
                    "hPa")),
            Visibility(
                visible: daoDb?.mainClassDb
                        ?.grnd_level !=
                    null,
                child: boxelement(
                    "Ground level\npressure",
                    "${daoDb?.mainClassDb?.grnd_level}",
                    "hPa")),
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
        color: ColorUtil.bgGrey,
        width: double.infinity,
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.center,
          crossAxisAlignment:
              CrossAxisAlignment.center,
          children: [
            boxelement(
                "Visibility",
                "${daoDb?.weatherDataDb?.visibility}",
                "m"),
            boxelement("Wind\nSpeed",
                "${daoDb?.windDb?.speed}", "m/s"),
            boxelement("Wind\nDegree",
                "${daoDb?.windDb?.deg}", "°"),
            boxelement("Cloudiness",
                "${daoDb?.cloudsDb?.all}", "%")
          ],
        ),
      ),
    ]);
  }

  PreferredSizeWidget _appBar(
      BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: ColorUtil.bgGrey,
      elevation: 0.0,
      title: Text(
        'Today\'s weather',
        maxLines: 1,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: ColorUtil.primary,
          fontSize: 20,
        ),
      ),
    );
  }
}
