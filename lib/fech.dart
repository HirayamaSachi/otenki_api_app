import 'dart:convert';
import 'package:flutter_config/flutter_config.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'weather_list.dart';

Future<WeatherList> fetchWeather() async {
  print('ok');
  SharedPreferencesWithCache _prefs = await SharedPreferencesWithCache.create(
      cacheOptions:
          SharedPreferencesWithCacheOptions(allowList: {'lat', 'lon'}));
  String _url = "";
  if (_prefs.containsKey('lon') && _prefs.containsKey('lat')) {
    double _lat = _prefs.getDouble('lat')!;
    double _lon = _prefs.getDouble('lon')!;
    _url = FlutterConfig.get('API_URL') +
        "?&appid=" +
        FlutterConfig.get('API_KEY') +
        "&lat=" +
        _lat +
        "&lon" +
        _lon +
        "&units=metric";
    print('a');
  } else {
    String city_name = "shinjuku";
    _url = FlutterConfig.get('API_URL') +
        "?&appid=" +
        FlutterConfig.get('API_KEY') +
        "&q=" +
        city_name +
        "&units=metric";
    print('b');
  }
  final response = await http.get(Uri.parse(_url));

  if (response.statusCode == 200) {
    return WeatherList.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('failed to load weather');
  }
}

Future fetchAddress(String query) async {
  final response = await http.get(Uri.parse(
      'https://geocode.csis.u-tokyo.ac.jp/cgi-bin/simple_geocode.cgi?addr=$query'));
  return response;
}
