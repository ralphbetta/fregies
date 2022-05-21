import "package:flutter/material.dart";
import 'package:fregies/constants/dimmensions.dart';
import 'package:fregies/constants/text_styles.dart';

Container displayDivider(BuildContext context, String title, bool padTop,
    bool padBottom, String greenText) {
  return Container(
      width: double.infinity,
      height: getPercentageHeight(3),
      margin: EdgeInsets.only(
          top: padTop ? getPercentageHeight(1) : 0,
          bottom: padBottom ? getPercentageHeight(1) : 0),
      color: Theme.of(context).backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: getPercentageWidth(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: productNameStyle(),
          ),
          Text(
            greenText,
            style: mainPriceStyle(context),
          )
        ],
      ));
}
