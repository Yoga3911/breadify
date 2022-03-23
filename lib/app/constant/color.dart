import 'package:flutter/material.dart';

class MyColor {
  MyColor._();

  static ThemeData theme(BuildContext context) => ThemeData(
        primarySwatch: const MaterialColor(
          0xFFFFD635,
          <int, Color>{
            50: yellow,
            100: yellow,
            200: yellow,
            300: yellow,
            400: yellow,
            500: yellow,
            600: yellow,
            700: yellow,
            800: yellow,
            900: yellow,
          },
        ),
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: MyColor.black,
              displayColor: MyColor.black,
              fontFamily: "Poppins",
            ),
      );

  static const red = Color(0xFFF9595E);
  static const black = Color(0xFF3D3D3D);
  static const grey = Color(0xFF6E6E6E);
  static const grey2 = Color(0xFF9E9E9E);
  static const yellow = Color(0xFFFFD635);
  static const cream = Color(0xFFFEF6D4);
}
