import 'package:flutter/material.dart';
import 'weather.dart';
import 'dart:math';

class WeatherList {
  final List<Weather> weather_list;

  const WeatherList(
      {required this.weather_list});

  factory WeatherList.fromJson(Map<String, dynamic> json) {
    // https://openweathermap.org/forecast5#fields_JSON
    Map<String, Map<String, List<double>>> json_lists = {};
    for (var three_hour_forcast in json['list']) {
      var date = three_hour_forcast['dt_txt'].split(' ')[0];
      var hour = three_hour_forcast['dt_txt'].split(' ')[1];
      if (!json_lists.containsKey(date)) {
        json_lists[date] = {
          'rain': [],
          'pop': [],
          'temp_min': [],
          'temp_max': [],
        };
      }
      if(three_hour_forcast['rain'] != null){
        json_lists[date]!['rain']!.add(three_hour_forcast['rain']['3h']);
      }else{
        json_lists[date]!['rain']!.add(0);
      }
      json_lists[date]!['pop']!.add(three_hour_forcast['pop']);
      json_lists[date]!['temp_min']!.add(three_hour_forcast['temp_min']);
      json_lists[date]!['temp_max']!.add(three_hour_forcast['temp_max']);
    }

  List<Weather> weather_lists = [];
  json_lists.forEach((date, value) {
    var temp_min = value['temp_min']!.reduce(min);
    var temp_max = value['temp_max']!.reduce(max);
    var rain = value['rain']!.reduce(max);
    var pop = value['pop']!.reduce((a, b) => a + b);
    weather_lists.add(Weather(date: date, temp_min: temp_min, temp_max: temp_max, rain: rain, pop: (pop > 0)? false : true));
    Weather(date: date, temp_min: temp_min, temp_max: temp_max, rain: rain, pop: (pop > 0) ? true : false);
  });

    return WeatherList(weather_list: weather_lists);
  }
}

