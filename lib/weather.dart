import 'package:flutter/material.dart';

class Weather {
  final double temp_min;
  final double temp_max;
  final String city_name;

  const Weather(
      {required this.temp_min,
      required this.temp_max,
      required this.city_name});

  factory Weather.fromJson(Map<String, dynamic> json) {
    // https://openweathermap.org/forecast5#fields_JSON
    var temp_min = json['list'][0]['main']['temp_min'];
    var temp_max = json['list'][0]['main']['temp_max'];
    var city_name = json['city']['name'];

    return Weather(
        temp_min: temp_min, temp_max: temp_max, city_name: city_name);
  }
}
