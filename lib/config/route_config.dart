import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  //how routes and stated
  //SplashScreen.routeName: (context) => SplashScreen(),

  //how routes and stated with default details
  // HomeScreen.routeName: (context) => HomeScreen(sentCurrentPage: 0),
};

Future<dynamic> irreversibleNavigate(BuildContext context, screen) {
  return Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => screen),
      (Route<dynamic> route) => false);
}
