import 'package:flutter/material.dart';
import 'package:fregies/config/size_config.dart';
import 'package:fregies/config/theme_config.dart';
import 'package:fregies/screen/signup/signup_screen.dart';
import 'package:fregies/screen/splash/splashscreen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // ThemeConfig().switchTheme();
    return const SplashScreen();
    //return const SignUpScreen();
  }
}
