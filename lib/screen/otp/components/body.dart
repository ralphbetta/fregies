import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fregies/config/route_config.dart';
import 'package:fregies/constants/color.dart';
import 'package:fregies/constants/dimmensions.dart';
import 'package:fregies/constants/text_styles.dart';
import 'package:fregies/constants/values.dart';
import 'package:fregies/models/user_model.dart';
import 'package:fregies/provider/application_state.dart';
import 'package:fregies/screen/home/homescreen.dart';
import 'package:fregies/utility/user/constant.dart';
import 'package:fregies/widgets/alertBox/alert_box.dart';
import 'package:fregies/widgets/text_btn.dart';
import 'package:http/http.dart' as http;
import 'package:provider/src/provider.dart';

class Body extends StatefulWidget {
  const Body({Key? key, required this.user, required this.otp})
      : super(key: key);
  final UserModel user;
  final String otp;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String _otp = "";
  bool isLoading = false;

  //void sendOtp(String email, Function callback) async {
  void sendOtp(String email) async {
    var ten = {
      "personalizations": [
        {
          "to": [
            {"email": email}
          ],
          "subject": "Email Authentication"
        }
      ],
      "from": {"email": "support@fregies.com"},
      "content": [
        {
          "type": "text/plain",
          "value": "your Fregies registration OTP is " + widget.otp
        }
      ]
    };
    //old key from gxaviprank
    //'X-RapidAPI-Key': 'a1731fbb58msh55c254e8abcccefp189264jsn5dc404518f08'
    http.Response response = await http.post(
        Uri.parse("https://rapidprod-sendgrid-v1.p.rapidapi.com/mail/send"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'X-RapidAPI-Host': 'rapidprod-sendgrid-v1.p.rapidapi.com',
          'X-RapidAPI-Key': '5828733e8emsh6ae2d070ec26136p157983jsn343b7a69aa59'
        },
        body: jsonEncode(ten));

    //there is no response; so it'll pop error;
    //Map decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;

    if (response.statusCode == 202) {
      print(true);
    } else {
      print(false);
    }
  }

  @override
  void initState() {
    sendOtp(widget.user.email);
    super.initState();
  }

  void monitorOtp(BuildContext context) {
    ApplicationState applicationState = Provider.of<ApplicationState>(context);
    if (applicationState.loginState == ApplicationLoginState.loggedIn) {
      Timer(const Duration(seconds: 1), () {
        irreversibleNavigate(context, HomeScreen());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // sendOtp(widget.user.email);
    monitorOtp(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getPercentageWidth(28),
                  vertical: getPercentageHeight(0)),
              child: const Image(
                image: AssetImage("assets/logo/logo-light.png"),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: getPercentageWidth(7),
                  right: getPercentageWidth(7),
                  top: getPercentageHeight(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Verify Email",
                    style: productNameStyle(size: 22),
                  ),
                  SizedBox(
                    height: getPercentageHeight(1),
                  ),
                  Text(
                    "Enter OTP sent to",
                    style: productCatStyle(context),
                  ),
                  SizedBox(
                    height: getPercentageHeight(1),
                  ),
                  Text(
                    widget.user.email,
                    style: productCatStyle(context),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: getPercentageHeight(5),
            ),
            Wrap(
              alignment: WrapAlignment.spaceEvenly,
              spacing: 10,
              direction: Axis.horizontal,
              runSpacing: 10,
              children: [
                _otpTextField(context, true, isFirst: true),
                _otpTextField(context, false, isSecond: true),
                _otpTextField(context, false, isThird: true),
                _otpTextField(context, false, isLast: true),
              ],
            ),
            SizedBox(
              height: getPercentageHeight(5),
            ),
            Text(
              "Didn't receive an OTP code?",
              style: productCatStyle(context),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: getPercentageHeight(4),
            ),
            Container(
              child: Text(
                "Resend Code",
                style: mainPriceStyle(context),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: getPercentageHeight(4),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: getPercentageHeight(4),
                  horizontal: getPercentageHeight(7)),
              child: TextBtn(
                vertical: 3,
                horizontal: 3,
                title: "Verify and Proceed",
                load: isLoading,
                action: () {
                  //clear otp holder
                  setState(() {
                    isLoading = true;
                    _otp = "";
                  });
                  //populate the opt holder with the recent list content
                  otpValue.forEach((element) {
                    _otp += element.toString();
                  });
                  print("what you've populated");
                  print(widget.otp);
                  if (_otp.length == 4) {
                    if (_otp == widget.otp) {
                      //this is where the registration takes place
                      context.read<ApplicationState>().registerAccount(
                          emailController.text, " ", passwordController.text,
                          (e) {
                        print(e);
                      });
                      print("match");
                    }
                  } else {
                    popUp(context, "Error Alert", <Widget>[
                      const Text(
                        "Your verification code is incomplete",
                        textAlign: TextAlign.center,
                      )
                    ]);
                  }
                  setState(() {
                    isLoading = false;
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _otpTextField(BuildContext context, bool autoFocus,
      {bool isLast = false,
      bool isFirst = false,
      bool isSecond = false,
      bool isThird = false}) {
    return Container(
      height: MediaQuery.of(context).size.shortestSide * 0.15,
      decoration: BoxDecoration(
        border: Border.all(color: lightPrimary),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        shape: BoxShape.rectangle,
      ),
      child: AspectRatio(
        aspectRatio: 1,
        child: TextField(
          autofocus: autoFocus,
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          style: const TextStyle(),
          maxLines: 1,
          onChanged: (value) {
            if (value.length == 1) {
              if (isFirst) {
                otpValue[0] = value;
              }
              if (isSecond) {
                otpValue[1] = value;
              }
              if (isThird) {
                otpValue[2] = value;
              }
              if (isLast) {
                otpValue[3] = value;
                FocusScope.of(context).unfocus();
                print("wow");
                print(otpValue);
              } else {
                FocusScope.of(context).nextFocus();
                print("oops");
                print(value);
              }
            }
          },
        ),
      ),
    );
  }
}
