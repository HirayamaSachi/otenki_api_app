import 'package:flutter/material.dart';
import 'package:otenki_api_app/weather_list.dart';

class Laundry {
  final bool washable;

  const Laundry({required this.washable});

  factory Laundry.washable() {
    var washable = false;

    return Laundry(washable: washable);
  }


}