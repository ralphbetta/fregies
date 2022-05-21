import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fregies/config/route_config.dart';
import 'package:fregies/constants/color.dart';
import 'package:fregies/constants/dimmensions.dart';
import 'package:fregies/constants/maps.dart';
import 'package:fregies/constants/text_styles.dart';
import 'package:fregies/models/user_model.dart';
import 'package:fregies/provider/application_state.dart';
import 'package:fregies/provider/theme_notifier.dart';
import 'package:fregies/provider/user_provider.dart';
import 'package:fregies/screen/home/homescreen.dart';
import 'package:fregies/screen/signup/signup_screen.dart';
import 'package:fregies/utility/card/card_utility.dart';
import 'package:fregies/utility/card/constant.dart';
import 'package:fregies/utility/user/constant.dart';
import 'package:fregies/widgets/alertBox/alert_box.dart';
import 'package:fregies/widgets/custom_input/custome_input.dart';
import 'package:fregies/widgets/horizontal_line.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fregies/widgets/square_btn.dart';
import 'package:provider/src/provider.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  _updateErrorMessage(String s) {
    return popUp(context, "Error Alert", <Widget>[
      Text(
        s,
        textAlign: TextAlign.center,
      )
    ]);
  }

  void monitorLoginSatat(BuildContext context) {
    ApplicationState applicationState = Provider.of<ApplicationState>(context);
    if (applicationState.loginState == ApplicationLoginState.loggedIn) {
      Timer(const Duration(seconds: 1), () {
        _updateErrorMessage("This user Already Exist");
        irreversibleNavigate(context, HomeScreen());
      });
    }
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    //not declaring this here but within the widget nere area of application might cause error;
    ApplicationState applicationState = Provider.of<ApplicationState>(context);
    monitorLoginSatat(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: getPercentageWidth(100),
                height: getPercentageHeight(22),
                padding: EdgeInsets.only(left: getPercentageWidth(15)),
                child: const Image(
                  image: AssetImage(
                    "assets/splash/splash-fruit-alt.png",
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getPercentageWidth(28),
                    vertical: getPercentageHeight(0)),
                child: Image(
                  image: ThemeClass.themeNotifier.value == ThemeMode.light
                      ? const AssetImage("assets/logo/logo-light.png")
                      : const AssetImage("assets/logo/light-dark.png"),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getPercentageWidth(7),
                    vertical: getPercentageHeight(4)),
                child: Text(
                  "Sign in",
                  style: productNameStyle(size: 25),
                ),
              ),
              PasswordTextField(
                hintText: "Email",
                controller: emailController,
                visibility: true,
                isPass: false,
              ),
              PasswordTextField(
                  hintText: "Password",
                  controller: passwordController,
                  visibility: false),
              Padding(
                padding: EdgeInsets.only(
                    left: getPercentageWidth(7),
                    right: getPercentageWidth(7),
                    top: getPercentageHeight(4)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const fillHorizontalLine(),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: getPercentageWidth(2)),
                                    child: Text(
                                      "Or Signin with",
                                      style: productCatStyle(context, size: 12),
                                    ),
                                  ),
                                  const fillHorizontalLine(),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: getPercentageHeight(2)),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children:
                                        List.generate(socials.length, (index) {
                                      return socialBtn(
                                          size: 7,
                                          image: socials[index],
                                          color: socialColor[index],
                                          action: () {});
                                    })),
                              )
                            ],
                          ),
                        )),
                    Expanded(
                        flex: 2,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              BtnSquare(
                                load: isLoading,
                                action: () {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  applicationState
                                      .verifyEmail(emailController.text, (e) {
                                    print(e.code);
                                  });

                                  applicationState.signInWithEmailAndPassword(
                                      emailController.text,
                                      passwordController.text, (e) {
                                    print(e);
                                    popUp(context, "Error Alert",
                                        <Widget>[Text(e.message.toString())]);
                                  });

                                  /*

                                  List<UserModel> result = userDB
                                      .where((element) => element.email
                                          .contains(emailController.text))
                                      .toList();

                                  if (result.isEmpty) {
                                    print("user does not exist");
                                    popUp(context, "Error Alert", <Widget>[
                                      const Text("This User does not exist")
                                    ]);
                                  } else {
                                    if (result.first.password ==
                                        (passwordController.text)) {
                                      UserModel handeller = UserModel(
                                          email: emailController.text,
                                          password: passwordController.text);
                                      context
                                          .read<UserNotifier>()
                                          .addUser(handeller);

                                      context.read<UserNotifier>().logIn();

                                      irreversibleNavigate(
                                          context, HomeScreen());
                                    } else {
                                      print(
                                          "password or username does not match");
                                      popUp(context, "Error Alert", <Widget>[
                                        const Text(
                                            "password or username does not match")
                                      ]);
                                    }
                                  }


                                  */
                                },
                                choiceIcon: Icons.arrow_right_alt,
                                size: getPercentageWidth(12),
                              ),
                              SizedBox(
                                height: getPercentageHeight(1),
                              ),
                              Text(
                                "Don't have an account?",
                                style: productCatStyle(context),
                              ),
                              SizedBox(
                                height: getPercentageHeight(1),
                              ),
                              GestureDetector(
                                onTap: () {
                                  irreversibleNavigate(
                                      context, const SignUpScreen());
                                },
                                child: Text(
                                  "Sign Up",
                                  style: productNameStyle(),
                                ),
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class socialBtn extends StatelessWidget {
  const socialBtn(
      {Key? key,
      required this.image,
      required this.color,
      required this.size,
      required this.action})
      : super(key: key);
  final String image;
  final Color color;
  final Function() action;
  final int size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        height: getPercentageWidth(size),
        width: getPercentageWidth(size),
        padding: EdgeInsets.all(size - 2),
        child: SvgPicture.asset(
          image,
          height: 13,
          color: white,
        ),
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

class fillHorizontalLine extends StatelessWidget {
  const fillHorizontalLine({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      color: kSecondaryTextColor,
      height: 1,
    ));
  }
}

class PasswordTextField extends StatefulWidget {
  PasswordTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.visibility,
    this.isPass = true,
  }) : super(key: key);
  final String hintText;
  final TextEditingController controller;
  bool visibility;
  final bool isPass;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getPercentageWidth(7), vertical: getPercentageHeight(1)),
      child: Container(
        height: getPercentageHeight(4),
        decoration: BoxDecoration(
            border: Border(
                bottom:
                    BorderSide(width: 1, color: Theme.of(context).hintColor))),
        child: Row(
          children: [
            Expanded(
                child: SizedBox(
              child: TextFormField(
                obscureText: !widget.visibility,
                controller: widget.controller,
                keyboardType: widget.isPass
                    ? TextInputType.name
                    : TextInputType.emailAddress,
                onChanged: (value) {},
                decoration: InputDecoration(
                    suffixIcon: widget.isPass ? iconAction() : null,
                    hintText: widget.hintText,
                    border: InputBorder.none,
                    hintStyle: productNameStyle()),
              ),
            )),
          ],
        ),
      ),
    );
  }

  IconButton iconAction() {
    return IconButton(
      onPressed: () {
        setState(() {
          widget.visibility = !widget.visibility;
        });
      },
      icon: !widget.visibility
          ? const Icon(Icons.visibility_off)
          : const Icon(Icons.visibility),
      color: kSecondaryTextColor,
      iconSize: 20,
    );
  }
}
