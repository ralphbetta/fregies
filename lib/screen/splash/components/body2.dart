import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fregies/constants/color.dart';
import 'package:fregies/constants/dimmensions.dart';
import 'package:fregies/provider/application_state.dart';
import 'package:fregies/provider/user_provider.dart';
import 'package:fregies/screen/home/homescreen.dart';
import 'package:fregies/screen/signin/signin_screen.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  void exitSplash(BuildContext context) {
    ApplicationState applicationState = Provider.of<ApplicationState>(context);

    Timer(const Duration(seconds: 8), () {
      print("done");
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return applicationState.loginState == ApplicationLoginState.loggedIn
            ? HomeScreen()
            : const SignInScreen();
      }), (Route<dynamic> route) => false);
    });
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   exitSplash();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    exitSplash(context);

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(),
      body: SafeArea(
          child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: getPercentageHeight(10),
          ),
          Container(
            child: const Image(
              image: AssetImage("assets/gif/screen-3.gif"),
            ),
          ),
          SizedBox(
            height: getPercentageHeight(13),
          ),
          const Text(
            'Welcome!',
            style: TextStyle(color: kTextColor),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getPercentageWidth(35)),
            child: Image(image: AssetImage("assets/logo/logo-light.png")),
          )
        ],
      )),
    );
  }
}
