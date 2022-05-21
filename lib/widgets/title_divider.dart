import 'package:flutter/material.dart';
import 'package:fregies/constants/dimmensions.dart';
import 'package:fregies/constants/text_styles.dart';

Padding titleDivider(String title, bool top) {
  return Padding(
    padding: EdgeInsets.only(
        top: top ? getPercentageWidth(3) : getPercentageWidth(1),
        bottom: getPercentageWidth(3)),
    child: Text(
      title,
      style: productNameStyle(size: 17),
    ),
  );
}
