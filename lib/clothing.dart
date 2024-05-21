import 'package:flutter/material.dart';

import 'weather.dart';

class Clothing {
  final String max_temp_image_path;
  final String min_temp_image_path;

  const Clothing({required this.max_temp_image_path, required this.min_temp_image_path});

  factory Clothing.factory(Weather weather) {
    var temp_min = '';
    if (weather.temp_min >= 25) {
      temp_min = 'cloth_tshirt.png';
    } else if(weather.temp_min > 12 && weather.temp_min < 25){
      temp_min = 'cloth_longt.png';
    } else if(weather.temp_min > 8 && weather.temp_min < 12){
      temp_min = 'fashion_trench_coat.png';
    } else {
      temp_min = 'fashion_duffle_coat.png';
    }

    var temp_max = '';
    if (weather.temp_max >= 25) {
      temp_max = 'cloth_tshirt.png';
    } else if(weather.temp_max > 12 && weather.temp_max < 25){
      temp_max = 'cloth_longt.png';
    } else if(weather.temp_max > 8 && weather.temp_max < 12){
      temp_max = 'fashion_trench_coat.png';
    } else {
      temp_max = 'fashion_duffle_coat.png';
    }
    return Clothing(max_temp_image_path: temp_max, min_temp_image_path: temp_min);
  }
}




