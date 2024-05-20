import 'package:flutter/material.dart';

class Weather {
  final String date;
  final double temp_min;
  final double temp_max;
  final double rain;
  final bool pop;

  const Weather({
    required this.date,
    required this.temp_min,
    required this.temp_max,
    required this.rain,
    required this.pop,
  });
}
