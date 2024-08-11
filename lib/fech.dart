import 'dart:convert';
import 'package:flutter_config/flutter_config.dart';

import 'package:http/http.dart' as http;

import 'weather_list.dart';

Future<WeatherList> fetchWeather() async {
  String city_name = "shinjuku";
  final response = await http.get(Uri.parse(FlutterConfig.get('API_URL') +
      "?&appid=" +
      FlutterConfig.get('API_KEY') +
      "&q=" +
      city_name + 
      "&units=metric"
      ));

  if (response.statusCode == 200) {
    return WeatherList.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('failed to load weather');
  }
}

Future fetchAddress(String query) async {
  final response = await http.get(Uri.parse('https://geocode.csis.u-tokyo.ac.jp/cgi-bin/simple_geocode.cgi?addr=$query'));
  return response;
}