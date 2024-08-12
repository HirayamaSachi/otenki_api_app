import 'package:flutter/material.dart';
import 'package:otenki_api_app/fech.dart';
import 'package:otenki_api_app/address.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xml/xml.dart';

class SearchBarApp extends StatefulWidget {
  const SearchBarApp({super.key});
  @override
  State<SearchBarApp> createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<SearchBarApp> {
  final SearchController controller = SearchController();
  List<Address> _addresses = List<Address>.empty();
  late Iterable<Widget> _lastOptions = <Widget>[];
  late final Future<SharedPreferencesWithCache> _geo;

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      builder: (context, controller) {
        return IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            controller.openView();
          },
        );
      },
      suggestionsBuilder: (context, controller) async {
        final _currentQuery = controller.text;
        await Future.delayed(const Duration(seconds: 2));
        if (_currentQuery == '' || _currentQuery != controller.text) {
          return _lastOptions;
        }
        _addresses = await _SearchAddressAPI.search(controller.text);
    
        _lastOptions = List.generate(_addresses.length, (index) {
          String _address_name = _addresses.elementAt(index).address;
          return ListTile(
            title: Text('$_address_name'),
            onTap: () {
              controller.text = _address_name;
              controller.closeView(_address_name);
            },
          );
        });
        return _lastOptions;
      },
    );
  }
}

class _SearchAddressAPI {
  static Future search(String query) async {
    RegExp exp = RegExp(caseSensitive: false, r"^[ぁ-んァ-ヶｱ-ﾝﾞﾟ一-龠]*$");
    if (query.length < 4 || query == '' || !exp.hasMatch(query)) {
      return List<Address>.empty();
    }
    final response = await fetchAddress(query);
    final xml = XmlDocument.parse(response.body);
    final address =
        xml.findAllElements('address').map((element) => element.innerText);
    final lon =
        xml.findAllElements('longitude').map((element) => element.innerText);
    final lat =
        xml.findAllElements('latitude').map((element) => element.innerText);

    final List<Address> addresses = [];
    for (var i = 0; i < address.length; i++) {
      addresses.add(Address(
          address: address.elementAt(i),
          lon: double.parse(lon.elementAt(i)),
          lat: double.parse(lat.elementAt(i))));
    }
    return addresses;
  }
}
