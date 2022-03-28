import 'package:flutter/cupertino.dart';

class CategoryProvider with ChangeNotifier {
  String _category = "Popular";

  get getCategory => _category;

  set setCategory(String val) {
    _category = val;
    notifyListeners();
  }
}
