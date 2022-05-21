import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fregies/config/route_config.dart';
import 'package:fregies/constants/color.dart';
import 'package:fregies/constants/dimmensions.dart';
import 'package:fregies/constants/maps.dart';
import 'package:fregies/constants/text_styles.dart';
import 'package:fregies/models/user_model.dart';
import 'package:fregies/provider/application_state.dart';
import 'package:fregies/provider/theme_notifier.dart';
import 'package:fregies/screen/otp/otp_screen.dart';
import 'package:fregies/screen/signin/signin_screen.dart';
import 'package:fregies/screen/signup/signup_screen.dart';
import 'package:fregies/utility/card/card_utility.dart';
import 'package:fregies/utility/card/constant.dart';
import 'package:fregies/utility/user/constant.dart';
import 'package:fregies/widgets/alertBox/alert_box.dart';
import 'package:fregies/widgets/custom_input/custome_input.dart';
import 'package:fregies/widgets/horizontal_line.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fregies/widgets/square_btn.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

bool isPasswordCompliant(String password, [int minLength = 6]) {
  if (password == null || password.isEmpty) {
    return false;
  }
  bool hasUppercase = password.contains(new RegExp(r'[A-Z]'));
  bool hasDigits = password.contains(new RegExp(r'[0-9]'));
  bool hasLowercase = password.contains(new RegExp(r'[a-z]'));
  bool hasSpecialCharacters =
      password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  bool hasMinLength = password.length > minLength;

  if (hasUppercase && hasLowercase && hasDigits && hasMinLength) {
    return true;
  } else {
    return false;
  }

  //return hasDigits & hasUppercase & hasLowercase & hasSpecialCharacters & hasMinLength;
}

class _BodyState extends State<Body> {
  bool isLoading = false;
  void _validate(BuildContext context) async {
    ApplicationState applicationState =
        Provider.of<ApplicationState>(context, listen: false);

    if (emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        password2Controller.text.isNotEmpty) {
      if (passwordController.text == password2Controller.text) {
        !isPasswordCompliant(passwordController.text)
            ? _updateErrorMessage(
                "password must be alphanumeric of 6 digit minimum")
            :
            ////////////////////////////////////////////////////////////
            //validate email and authenticate...
            //////////////////////////////////////////////////
            setState(() {
                isLoading = true;
              });
        applicationState.verifyEmail(emailController.text, (e) {
          print(e.code);
        });

        // applicationState.registerAccount(
        //     emailController.text, "Mike Jones", passwordController.text, (e) {
        //   print(e);
        // });
      } else {
        _updateErrorMessage("password does not match");
      }
    } else if (emailController.text.isEmpty) {
      _updateErrorMessage("email is empty");
    } else if (passwordController.text.isEmpty) {
      _updateErrorMessage("password is empty");
    } else {
      _updateErrorMessage("confirm your password");
    }

    setState(() {
      isLoading = false;
    });
  }

  _updateErrorMessage(String s) {
    return popUp(context, "Error Alert", <Widget>[
      Text(
        s,
        textAlign: TextAlign.center,
      )
    ]);
  }

  _getRandomNumber() {
    Random objectname = Random();
    int number = objectname.nextInt(9000) + 1000;
    return number;
  }

  void monitorRegistrationSatat(BuildContext context) {
    ApplicationState applicationState = Provider.of<ApplicationState>(context);
    if (applicationState.loginState == ApplicationLoginState.emailExist) {
      Timer(const Duration(seconds: 1), () {
        _updateErrorMessage("This user Already Exist");
      });
    }
    if (applicationState.loginState == ApplicationLoginState.register) {
      Timer(const Duration(seconds: 1), () {
        reversibleNavigation(
            context,
            OTPScree(
              user: UserModel(
                  email: emailController.text,
                  password: passwordController.text),
              otp: _getRandomNumber().toString(),
            ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    monitorRegistrationSatat(context);

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
                  "Sign up",
                  style: productNameStyle(size: 25),
                ),
              ),
              // InkWell(
              //     onTap: () {},
              //     child: Text(
              //         context.watch<ApplicationState>().loginState.toString())),
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
              PasswordTextField(
                  hintText: "Confirm Password",
                  controller: password2Controller,
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
                                      "Or Signup with",
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
                                  _validate(context);
                                  setState(() {
                                    isLoading = false;
                                  });
                                  // int p = _getRandomNumber();
                                  // print(p);
                                  // print("object");

                                  // sendOtp(emailController.text, p.toString(),
                                  //     (sucess) {
                                  //   if (sucess) {
                                  //     print("otp of " + p.toString());
                                  //   } else {
                                  //     print("otp not sent");
                                  //   }
                                  // });
                                },
                                choiceIcon: Icons.arrow_right_alt,
                                size: getPercentageWidth(12),
                              ),
                              SizedBox(
                                height: getPercentageHeight(1),
                              ),
                              Text(
                                "Already have an account?",
                                style: productCatStyle(context),
                              ),
                              SizedBox(
                                height: getPercentageHeight(1),
                              ),
                              GestureDetector(
                                onTap: () {
                                  irreversibleNavigate(context, SignInScreen());
                                },
                                child: Text(
                                  "Sign In",
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
