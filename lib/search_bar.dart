import 'package:flutter/material.dart';
class SearchBarApp extends StatefulWidget {
  const SearchBarApp({super.key});
  @override
  State<SearchBarApp> createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<SearchBarApp> {
  final SearchController controller = SearchController();

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(1));
  }
}