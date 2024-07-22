import 'package:flutter/material.dart';
import 'weather.dart';
import 'laundry.dart';
import 'clothing.dart';

abstract class ListItem {
  Widget buildPanel(BuildContext context);
}

class TodayOutfitPanel implements ListItem {
  final Weather todayWeather;

  TodayOutfitPanel(this.todayWeather);

  @override
  Widget buildPanel(BuildContext context) {
    var clothing = Clothing.factory(todayWeather);
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 100,
                  child: Image(
                      image: AssetImage(
                          'assets/images/${clothing.min_temp_image_path}'))),
              Container(
                  width: 50,
                  child: Image(
                      image: AssetImage(
                          'assets/images/${clothing.max_temp_image_path}'))),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${todayWeather.temp_max}'),
              Text('~'),
              Text('${todayWeather.temp_min}'),
            ],
          ),
        ],
      ),
    );
  }
}

class NextDayOutfitPanel implements ListItem {
  final Weather nextDayWeather;

  NextDayOutfitPanel(this.nextDayWeather);

  @override
  Widget buildPanel(BuildContext context) {
    var clothing = Clothing.factory(nextDayWeather);
    return Row(
      children: [
        Container(
            width: 100,
            child: Image(
                image: AssetImage(
                    'assets/images/${clothing.min_temp_image_path}'))),
        Container(
            width: 50,
            child: Image(
                image: AssetImage(
                    'assets/images/${clothing.max_temp_image_path}'))),
        Text('${nextDayWeather.temp_max}'),
        Text('~'),
        Text('${nextDayWeather.temp_min}'),
      ],
    );
  }
}

class LaundryPanel implements ListItem {
  final Weather weather;
  LaundryPanel(this.weather);

  @override
  Widget buildPanel(BuildContext context) {
    var laundry = Laundry.washable(weather);
    return Row(
      children: [
        (laundry.washable)
            ? Icon(Icons.circle_outlined)
            : Icon(Icons.clear_sharp),
        Text('${weather.temp_max}'),
        Text('~'),
        Text('${weather.temp_min}'),
      ],
    );
  }
}
