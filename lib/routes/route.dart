import 'package:flutter/cupertino.dart';
import 'package:project/views/introduction/introduction.dart';

import '../views/home/home.dart';

class Routes {
  Routes._();

  static const String introduction = "/introduction";
  static const String home = "/home";

  static final data = <String, WidgetBuilder>{
    introduction: (context) => const IntroductionPage(),
    home: (context) => const HomePage(),
  };
}
