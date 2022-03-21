import 'package:flutter/cupertino.dart';

import '../views/home/home.dart';
import '../views/introduction/introduction.dart';

class Routes {
  Routes._();

  static const String introduction = "/introduction";
  static const String home = "/home";

  static final data = <String, WidgetBuilder>{
    introduction: (context) => const IntroductionPage(),
    home: (context) => const HomePage(),
  };
}
