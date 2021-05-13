import 'package:flutter/material.dart';

import 'AppColor.dart';

class AppTheme {
  static Color lightBG = Color(0xfff3f4f9);

  static Map<int, Color> myColor = {
    50: Color.fromRGBO(254, 0, 0, .1),
    100: Color.fromRGBO(254, 0, 0, .2),
    200: Color.fromRGBO(254, 0, 0, .3),
    300: Color.fromRGBO(254, 0, 0, .4),
    400: Color.fromRGBO(254, 0, 0, .5),
    500: Color.fromRGBO(254, 0, 0, .6),
    600: Color.fromRGBO(254, 0, 0, .7),
    700: Color.fromRGBO(254, 0, 0, .8),
    800: Color.fromRGBO(254, 0, 0, .9),
    900: Color.fromRGBO(254, 0, 0, 1),
  };

  static MaterialColor colorCustom = MaterialColor(0xFF124986, myColor);

  static ThemeData lightTheme = ThemeData(
    backgroundColor: lightBG,
    primaryColor: colorCustom,
    primarySwatch: colorCustom,
    accentColor: colorCustom,
    cursorColor: colorCustom,
    canvasColor: Colors.transparent,
    scaffoldBackgroundColor: AppColor.appWhite,
    appBarTheme: AppBarTheme(
      color: AppColor.appColor,
      elevation: 0,
      textTheme: TextTheme(
      ),
    ),
  );
}
