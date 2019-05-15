import 'package:flutter/material.dart';

//首页provide
class CurrentIndexProvide with ChangeNotifier {
  int currentIndex = 0;
  changeIndex(int newIndex) {
    currentIndex = newIndex;
    notifyListeners();
  }
}
