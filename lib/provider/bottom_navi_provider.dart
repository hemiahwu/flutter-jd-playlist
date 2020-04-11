import 'package:flutter/material.dart';

class BottomNaviProvider with ChangeNotifier {
  int bottomNaviIndex = 0;

  void changeBottomNaviIndex(int index) {
    if (this.bottomNaviIndex != index) {
      this.bottomNaviIndex = index;
      notifyListeners();
    }
  }
}
