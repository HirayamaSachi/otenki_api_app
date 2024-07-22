import 'weather.dart';

class Laundry {
  final bool washable;

  const Laundry({required this.washable});

  factory Laundry.washable(Weather weather) {
    if(weather.rain > 0) {
      return const Laundry(washable: false);
    }
    if(weather.temp_max >= 25) {
      return const Laundry( washable: true);
    } else {
      return const Laundry(washable: false);
    }
  }
}