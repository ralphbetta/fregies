import 'package:flutter/material.dart';
import 'package:fregies/constants/color.dart';
import 'package:fregies/constants/dimmensions.dart';
import 'package:fregies/constants/text_styles.dart';
import 'package:fregies/provider/theme_notifier.dart';
import 'package:fregies/utility/card/constant.dart';

class VirtualCard extends StatefulWidget {
  const VirtualCard({Key? key}) : super(key: key);

  @override
  State<VirtualCard> createState() => _VirtualCardState();
}

class _VirtualCardState extends State<VirtualCard> {
  @override
  Widget build(BuildContext context) {
    List CardDigit =
        cardDB.isNotEmpty ? cardDB.first.cardNumber.split(' ') : ["", ""];
    String lastDigit = CardDigit.last;
    String cardTypeName = cardDB.isNotEmpty ? cardDB.first.cardType : "";
    print("wow");

    return Stack(
      children: [
        Container(
          width: getPercentageWidth(100),
          height: 210,
          margin: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: AssetImage("assets/icons/$cardTypeName.png"),
                  fit: BoxFit.cover),
              boxShadow: [
                BoxShadow(
                  color: ThemeClass.themeNotifier.value == ThemeMode.light
                      ? Color(0xFF414042).withOpacity(0.3)
                      : Colors.transparent,
                  blurRadius: 4.5,
                  spreadRadius: 1.6,
                )
              ]),
        ),
        Container(
          height: 165,
          margin: EdgeInsets.only(
            top: getPercentageHeight(2),
            left: getPercentageWidth(5),
            right: getPercentageWidth(7),
          ),
          padding: EdgeInsets.only(
            bottom: getPercentageHeight(1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CircleAvatar(
                radius: 13,
                backgroundColor: lightPrimary,
                child: Icon(
                  Icons.check,
                  color: white,
                ),
              ),
              Text("**** **** **** $lastDigit", style: cardPinStyle()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  cardDetails("CARD HOLDER",
                      cardDB.isNotEmpty ? cardDB.first.cardHolder : ""),
                  cardDetails("EXPIRES",
                      cardDB.isNotEmpty ? cardDB.first.expiryDate : ""),
                  cardDetails("CVV", cardDB.isNotEmpty ? cardDB.first.cVV : ""),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Column cardDetails(String title, String detail) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(title, style: cardTextStyle()),
        SizedBox(
          height: getPercentageHeight(1),
        ),
        Text(
          detail,
          style: cardPinStyle(size: 15),
        )
      ],
    );
  }
}
