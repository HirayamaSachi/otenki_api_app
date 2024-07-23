import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:otenki_api_app/list_panel.dart';

import 'fech.dart';
import 'weather_list.dart';
import 'laundry.dart';
import 'clothing.dart';

void main() async {
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
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = [];
  @override
  void initState() {
    futureWeather = fetchWeather();
    _widgetOptions = [
      Padding(
        padding: const EdgeInsets.all(50),
        child: FutureBuilder<WeatherList>(
          future: futureWeather,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              List<ListItem> items = List<ListItem>.generate(
                  5,
                  (int i) => i == 0
                      ? TodayOutfitPanel(snapshot.data!.weather_list[i])
                      : NextDayOutfitPanel(snapshot.data!.weather_list[i]));
              return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return ListTile(
                      title: item.buildPanel(context),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(50),
        child: FutureBuilder<WeatherList>(
          future: futureWeather,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              List<ListItem> items = List<ListItem>.generate(
                  5, (int i) => LaundryPanel(snapshot.data!.weather_list[i]));
              return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return ListTile(
                      title: item.buildPanel(context),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
      Padding(
        padding: EdgeInsets.all(50),
        child: Text('temp'),
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
        body: Center(
            child: Container(
          child: _widgetOptions.elementAt(_selectedIndex),
        )),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.accessibility_new), label: 'outfit'),
            BottomNavigationBarItem(
                icon: Icon(Icons.bubble_chart_outlined), label: 'washable'),
                BottomNavigationBarItem(icon: Icon(Icons.search), label: 'search'),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
