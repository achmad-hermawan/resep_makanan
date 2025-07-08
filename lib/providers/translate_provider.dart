import 'package:flutter/material.dart';

class TranslateProvider with ChangeNotifier {
  bool _isTranslate = false;

  bool get isTranslate => _isTranslate;

  void toggleTranslate(bool value) {
    _isTranslate = value;
    notifyListeners();
  }
}
