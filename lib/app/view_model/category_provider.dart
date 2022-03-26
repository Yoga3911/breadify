import 'package:flutter/cupertino.dart';

class CategoryProvider with ChangeNotifier {
  String _category = "Today";

  get getCategory => _category;

  set setCategory(String val) {
    _category = val;
    notifyListeners();
  }
}
