import 'package:flutter/material.dart';
import 'package:fregies/constants/color.dart';
import 'package:fregies/constants/dimmensions.dart';
import 'package:fregies/constants/values.dart';

class PaymetMethodCard extends StatelessWidget {
  const PaymetMethodCard(
      {Key? key,
      required this.icon,
      required this.caption,
      required this.index})
      : super(key: key);
  final String icon;
  final String caption;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image(image: AssetImage(icon), height: getPercentageWidth(7)),
        Text(caption, style: TextStyle(fontSize: bodyTextSize)),
        Container(
          width: getPercentageWidth(5),
          height: getPercentageWidth(5),
          padding: EdgeInsets.all(getPercentageWidth(1) * 0.5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 1)),
          child: CircleAvatar(
              backgroundColor: index == selectedPaymentMethod
                  ? lightPrimary
                  : kSecondaryTextColor),
        )
      ],
    );
  }
}
