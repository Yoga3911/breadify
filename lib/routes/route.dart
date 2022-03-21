import 'package:flutter/cupertino.dart';

import '../app/views/home/home.dart';
import '../app/views/introduction/introduction.dart';

class Routes {
  Routes._();

  static const String introduction = "/introduction";
  static const String home = "/home";

  static final data = <String, WidgetBuilder>{
    introduction: (context) => const IntroductionPage(),
    home: (context) => const HomePage(),
  };
}
