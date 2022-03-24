import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fregies/constants/color.dart';
import 'package:fregies/constants/dimmensions.dart';
import 'package:fregies/constants/maps.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightPrimary,
      appBar: AppBar(
        backgroundColor: const Color(0xFFEDF8ED),
        foregroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
                decoration: const BoxDecoration(
                    color: Color(0xFFEDF8ED),
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(30))),
                child: Stack(
                  children: [
                    PageView(
                      children: <Widget>[
                        ...List.generate(
                            splashData.length,
                            (index) => SplashScreenContent(
                                  bodyText: splashData[index]['caption']!,
                                  head: splashData[index]['title']!,
                                  image: splashData[index]['image']!,
                                ))
                      ],
                      onPageChanged: (value) {
                        setState(() {
                          currentPage = value;
                        });
                      },
                    ),
                    Positioned(
                        top: getPercentageHeight(34),
                        left: getPercentageWidth(42),
                        child: _indicator(currentPage))
                  ],
                )),
          ),
          Container(
            height: getPercentageHeight(25),
            margin: EdgeInsets.symmetric(horizontal: getPercentageWidth(4)),
            decoration: BoxDecoration(color: lightPrimary),
            child: Row(
              children: [
                kButton(primary: true, title: "Sign Up"),
                SizedBox(
                  width: getPercentageWidth(5),
                ),
                kButton(primary: false, title: "Sign Up"),
              ],
            ),
          )
        ],
      ),
    );
  }

  Row _indicator(int point) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
            3,
            (index) => Container(
                  width: mediumTextSize - 8,
                  height: mediumTextSize - 8,
                  margin: EdgeInsets.only(right: getPercentageWidth(2)),
                  decoration: BoxDecoration(
                      color: index == point
                          ? lightPrimary
                          : lightPrimary.withOpacity(0.2),
                      shape: BoxShape.circle),
                )));
  }
}

class kButton extends StatelessWidget {
  final bool primary;
  final String title;
  const kButton({Key? key, required this.primary, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      padding: EdgeInsets.symmetric(vertical: getPercentageHeight(2) - 3),
      decoration: BoxDecoration(
          color: primary ? lightPrimary : white,
          border: Border.all(width: 1, color: white),
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            BoxShadow(color: kSecondaryTextColor, blurRadius: 5.3)
          ]),
      child: Text(
        title,
        style: TextStyle(
          color: primary ? white : lightPrimary,
        ),
        textAlign: TextAlign.center,
      ),
    ));
  }
}

class SplashScreenContent extends StatelessWidget {
  final String image;
  final String head;
  final String bodyText;
  const SplashScreenContent({
    Key? key,
    required this.image,
    required this.head,
    required this.bodyText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: getPercentageWidth(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: getPercentageWidth(70),
            child: Image(
              image: AssetImage("assets/splash/$image"),
              colorBlendMode: BlendMode.dst,
            ),
          ),
          SizedBox(
            height: getPercentageHeight(3),
          ),
          //this was for the _indicator widget
          SizedBox(
            height: getPercentageHeight(4),
          ),
          SizedBox(
            width: getPercentageWidth(50),
            child: Text(
              head,
              style: const TextStyle(
                fontSize: mediumTextSize,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: getPercentageHeight(2),
          ),
          SizedBox(
            width: getPercentageWidth(50),
            child: Text(
              bodyText,
              style: const TextStyle(
                  fontSize: bodyTextSize - 5, color: kSecondaryTextColor),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
