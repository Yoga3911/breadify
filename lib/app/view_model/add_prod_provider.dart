import 'dart:math';

import 'package:flutter/material.dart';

class AddProductProvider with ChangeNotifier {
  AddProductProvider({
    this.category = "Category",
    this.icon = "assets/icons/category.png",
  });

  String category;
  String icon;

  bool isShow = false;
  double rotate = pi * 0;

  // final TextEditingController emailLogin = TextEditingController();
  // final TextEditingController passLogin = TextEditingController();

  // final TextEditingController nameRegis = TextEditingController();
  // final TextEditingController emailRegis = TextEditingController();
  // final TextEditingController pass1Regis = TextEditingController();
  // final TextEditingController pass2Regis = TextEditingController();

  // LoginModel loginValue() => LoginModel(
  //       email: emailLogin.text,
  //       password: passLogin.text,
  //     );

  // Map<String, String> registerValue() => {
  //       "name": nameRegis.text,
  //       "email": emailRegis.text,
  //       "password1": pass1Regis.text,
  //       "password2": pass2Regis.text,
  //     };

  void changeCategory(String cat) {
    if (rotate == pi * 0) {
      rotate = pi * 180;
    } else {
      rotate = pi * 0;
    }
    isShow = !isShow;
    if (cat == "Bread") {
      category = "Bread";
      icon = "assets/icons/bread.png";
    } else if (cat == "Cookies") {
      category = "Cookies";
      icon = "assets/icons/cookies.png";
    } else if (cat == "Cakes") {
      category = "Cakes";
      icon = "assets/icons/cakes.png";
    } else if (cat == "Pastry") {
      category = "Pastry";
      icon = "assets/icons/pastry.png";
    } else if (cat == "Brownies") {
      category = "Brownies";
      icon = "assets/icons/brownie.png";
    }
    notifyListeners();
  }
}
