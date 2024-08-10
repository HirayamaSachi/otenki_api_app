import 'package:flutter/material.dart';
import 'package:otenki_api_app/fech.dart';

class SearchBarApp extends StatefulWidget {
  const SearchBarApp({super.key});
  @override
  State<SearchBarApp> createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<SearchBarApp> {
  final SearchController controller = SearchController();
  String? _searchingWithQuery;
  late Iterable<Widget> _lastOptions = <Widget>[];

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      builder: (context, controller) {
        return IconButton(
            onPressed: () {
              controller.openView();
            },
            icon: const Icon(Icons.search));
      },
      suggestionsBuilder: (context, controller) async {
        _searchingWithQuery = controller.text;
        await _SearchAddressAPI.search(_searchingWithQuery!);
        if(_searchingWithQuery != controller.text) {
          return _lastOptions;
        }

        _lastOptions = List.generate(5, (index) {
          return ListTile(
            title: Text('$index'),
          );
        });
        return _lastOptions;
      },
    );
  }
}

class _SearchAddressAPI {
  static Future search(String query)
  async {
    // await Future<void>.delayed(Duration(seconds: 10));
    RegExp exp = RegExp(caseSensitive: false, r"^[ぁ-んァ-ヶｱ-ﾝﾞﾟ一-龠]*$");
    if(query == '' || !exp.hasMatch(query)) {
      return '';
    }
    print(query);
    // fetchAddress(query);
  }
}