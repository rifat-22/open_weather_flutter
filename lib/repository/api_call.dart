// import 'package:dio/dio.dart';
// import 'package:weather_app/models/weather.dart';
//
// import '../database/database.dart';
// import '../models/weather_data.dart';
//
// class WeatherDataFetch {
//   Future<WeatherData> getWeatherData() async {
//     var url = "http://demo8161595.mockable.io/employee";
//     Response response = await Dio().get(url);
//
//     return (response.data).map((weatherData) {
//       print('Inserting $weatherData');
//       DBProvider.db.createTable(Weather.fromJson(weatherData));
//     });
//   }
//
//   Future<WeatherData> fetchAlbum() async {
//     final response = await http.get(Uri.parse(
//         'https://api.openweathermap.org/data/2.5/weather?lat=23.00&lon=90.00&appid=36d27fc4a354ee22fad96e3c9e975575'));
//
//     if (response.statusCode == 200) {
//       print("Yaaaaaayy");
//       setState(() {
//         isFetchedData = 1;
//       });
//
//       print(WeatherData.fromJson(
//           jsonDecode(response.body)));
//       return WeatherData.fromJson(
//           jsonDecode(response.body));
//     } else {
//       isFetchedData = 2;
//       throw Exception('Failed to load album');
//     }
//   }
// }