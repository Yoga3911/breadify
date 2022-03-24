import 'package:flutter/cupertino.dart';
import 'package:project/app/models/category.dart';

class CategoryProvier with ChangeNotifier {
  bool _selectedPopular = false;
  bool _selectedBread = false;
  bool _selectedCookies = false;
  bool _selectedCakes = false;
  bool _selectedPastry = false;
  bool _selectedBrownies = false;

  get popular => _selectedPopular;
  get bread => _selectedBread;
  get cookies => _selectedCookies;
  get cakes => _selectedCakes;
  get pastry => _selectedPastry;
  get brownies => _selectedBrownies;

  void setPopular(CategoryModel category, bool selected) => category.isSelected = selected;
}
