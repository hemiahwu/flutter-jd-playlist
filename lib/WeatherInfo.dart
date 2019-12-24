import 'package:flutter/foundation.dart';

class WeatherInfo with ChangeNotifier {
  String _tempType = "摄氏度";
  int _temperatureVal = 25;

  int get temperatureVal => _temperatureVal;
  String get temperatureType => _tempType;

  set temperature(int newTemp) {
    _temperatureVal = newTemp;
    notifyListeners();
  }

  set temperatureType(String newType) {
    _tempType = newType;
    notifyListeners();
  }
}
