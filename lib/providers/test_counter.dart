import 'package:flutter/material.dart';


//计数provider
class TestCounter with ChangeNotifier {
  int value = 0;
  increment() {
    value++;
    notifyListeners();
  }
}
