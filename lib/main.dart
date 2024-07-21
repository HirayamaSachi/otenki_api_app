import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_config/flutter_config.dart';

import 'fech.dart';
import 'weather_list.dart';
import 'laundry.dart';
import 'clothing.dart';

void main() async {
  debugPaintSizeEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<WeatherList> futureWeather;
  @override
  void initState() {
    futureWeather = fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '服装と洗濯指数',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('服装と洗濯指数'),
        ),
        body: Center(
          child: FutureBuilder<WeatherList>(
            future: futureWeather,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                var laundry = Laundry.washable(snapshot.data!.weather_list[0]);
                var clothing = Clothing.factory(snapshot.data!.weather_list[0]);
                return Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    height: 200,
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
                            (laundry.washable)
                                ? const Icon(Icons.circle_outlined)
                                : const Icon(Icons.clear_sharp),
                            Text('${snapshot.data!.weather_list[0].temp_max}'),
                            Text('~'),
                            Text('${snapshot.data!.weather_list[0].temp_min}'),
                          ],
                        )
                      ],
                    )
                    // ListView(
                    //   scrollDirection: Axis.horizontal,
                    //   children: <Widget>[
                    //     Container(
                    //         width: 30,
                    //         child: Image(
                    //             image: AssetImage(
                    //                 'assets/images/${clothing.min_temp_image_path}'))),

                    //     Container(
                    //         width: 30,
                    //         child: Image(
                    //             image: AssetImage(
                    //                 'assets/images/${clothing.max_temp_image_path}'))),
                    //     (laundry.washable)
                    //         ? const Icon(Icons.circle_outlined)
                    //         : const Icon(Icons.clear_sharp),
                    //     Text('最高気温:${snapshot.data!.weather_list[0].temp_max}'),
                    //     Text('最低気温:${snapshot.data!.weather_list[0].temp_min}'),
                    //   ],
                    // ),
                    );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
