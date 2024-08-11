import 'package:flutter/material.dart';
import 'package:otenki_api_app/fech.dart';
import 'package:otenki_api_app/address.dart';
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

  @override
  Widget build(BuildContext context){
    return SearchAnchor(
      builder: (context, controller) {
        return IconButton(
            onPressed: () {
              controller.openView();
            },
            icon: const Icon(Icons.search));
      },
      viewOnSubmitted: (value) async{
        if(value == '') {
          return;
        }
        _addresses = await _SearchAddressAPI.search(value);
        setState((){
          _addresses = _addresses;
        });
        _lastOptions = List.generate(_addresses.length, (index) {
          String _address_name = _addresses.elementAt(index).address;
          return ListTile(
            title: Text('$_address_name'),
          );
        });
      },
      suggestionsBuilder: (context, controller){
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
    final response = await fetchAddress(query);
    final xml = XmlDocument.parse(response.body);
    final address = xml.findAllElements('address').map((element) => element.innerText);
    final lon = xml.findAllElements('longitude').map((element) => element.innerText);
    final lat = xml.findAllElements('latitude').map((element) => element.innerText);

    final List<Address> addresses = [];
    for (var i = 0; i < address.length; i++) {
      addresses.add(Address(address: address.elementAt(i), lon: double.parse(lon.elementAt(i)), lat: double.parse(lat.elementAt(i))));
    }
    return addresses;
  }
}
