import 'package:flutter/material.dart';
import 'package:fregies/constants/color.dart';

productNameStyle({double size = 15.0}) {
  return TextStyle(fontWeight: FontWeight.bold, fontSize: size);
}

productCatStyle(BuildContext context, {double size = 14.0}) {
  return TextStyle(color: Theme.of(context).hintColor, fontSize: size);
}

mainPriceStyle(BuildContext context, {double size = 15.0}) {
  return TextStyle(
      fontWeight: FontWeight.bold, color: lightPrimary, fontSize: size);
}

slashPriceStyle(BuildContext context, {double size = 15.0}) {
  return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: size,
      color: Theme.of(context).hintColor,
      decoration: TextDecoration.lineThrough);
}

cardPinStyle({double size = 20.0}) {
  return TextStyle(
    color: white,
    fontWeight: FontWeight.bold,
    fontSize: size,
    wordSpacing: 6,
  );
}

cardTextStyle() {
  return const TextStyle(
    color: white,
    fontSize: 13,
  );
}
