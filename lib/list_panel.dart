import 'package:flutter/material.dart';
import 'weather.dart';
import 'laundry.dart';
import 'clothing.dart';

abstract class ListItem {
  Widget buildPanel(BuildContext context);
}

class TodayPanel implements ListItem {
  final Weather today_weather;

  TodayPanel(this.today_weather);

  @override
  Widget buildPanel(BuildContext context) {
    var laundry = Laundry.washable(today_weather);
    var clothing = Clothing.factory(today_weather);
    return Column(
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
            (laundry.washable)
                ? Icon(Icons.circle_outlined)
                : Icon(Icons.clear_sharp),
            Text('${today_weather.temp_max}'),
            Text('~'),
            Text('${today_weather.temp_min}'),
          ],
        ),
      ],
    );
  }
}

class SubPanel implements ListItem {
  final Weather sub_weather;

  SubPanel(this.sub_weather);

  @override
  Widget buildPanel(BuildContext context) {
    var laundry = Laundry.washable(sub_weather);
    var clothing = Clothing.factory(sub_weather);
    return Row(
      children: [
        (laundry.washable)
            ? Icon(Icons.circle_outlined)
            : Icon(Icons.clear_sharp),
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
        Text('${sub_weather.temp_max}'),
        Text('~'),
        Text('${sub_weather.temp_min}'),
      ],
    );
  }
}
