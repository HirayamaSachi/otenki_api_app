
import 'package:flutter/material.dart';
class Weather {
  final double temp_min;
  final double temp_max;
  final String city_name;

  const Weather({
    required this.temp_min,
    required this.temp_max,
    required this.city_name
  });

  factory Weather.fromJson(Map<String, dynamic> json){
    var temp_min = json['main']['temp_min'];
    var temp_max = json['main']['temp_max'];
    var city_name = json['name'];

    return Weather(temp_min: temp_min, temp_max: temp_max, city_name: city_name);
  }
}