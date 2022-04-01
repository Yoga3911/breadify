import 'package:flutter/material.dart';

class CategoryProvider with ChangeNotifier {
  String _category = "Popular";

  String get getCategory => _category;

  set setCategory(String val) {
    _category = val;
    notifyListeners();
  }
}
