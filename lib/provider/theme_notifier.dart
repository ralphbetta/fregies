import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fregies/constants/color.dart';

class ThemeClass {
  //static late ThemeMode currentTheme = ThemeMode.light;
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);

  static ThemeData lightTheme = ThemeData(
    fontFamily: 'Poppins',
    scaffoldBackgroundColor: scaffoldBackgroundColorLight,
    secondaryHeaderColor: Colors.white,
    backgroundColor: Colors.white,
    hintColor: Colors.black,
    primaryColor: Colors.green,
    splashColor: Colors.transparent,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    brightness: Brightness.light,
    textTheme: const TextTheme(
      bodyText1: TextStyle(color: Colors.black),
      headline2: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    fontFamily: 'Poppins',
    scaffoldBackgroundColor: scaffoldBackgroundColorDark,
    secondaryHeaderColor: Colors.white,
    backgroundColor: Colors.black54,
    hintColor: const Color(0xffA3A3A3),
    primaryColor: white,
    splashColor: Colors.transparent,
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: white)),
    brightness: Brightness.dark,
    textTheme: const TextTheme(
      bodyText1: TextStyle(color: Colors.white),
      headline2: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
  );
}

Color getColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return Colors.blue;
  }
  return Colors.red;
}
