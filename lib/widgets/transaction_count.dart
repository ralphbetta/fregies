import 'package:flutter/material.dart';
import 'package:fregies/constants/color.dart';
import 'package:fregies/constants/dimmensions.dart';
import 'package:fregies/constants/text_styles.dart';
import 'package:fregies/provider/theme_notifier.dart';
import 'package:fregies/widgets/virtical_line.dart';

class TransactionCount extends StatelessWidget {
  const TransactionCount({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: getPercentageHeight(10),
      margin: EdgeInsets.symmetric(horizontal: getPercentageWidth(5)),
      padding: EdgeInsets.symmetric(
          horizontal: getPercentageWidth(3), vertical: getPercentageWidth(3)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).backgroundColor,
          boxShadow: [
            BoxShadow(
              color: ThemeClass.themeNotifier.value == ThemeMode.light
                  ? Color(0xFF414042).withOpacity(0.3)
                  : Colors.transparent,
              blurRadius: 4.5,
              spreadRadius: 1.6,
            )
          ]),
      child: Row(
        children: [
          Expanded(
              child: Container(
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 13,
                  backgroundColor: lightPrimary,
                  child: Icon(
                    Icons.check,
                    color: white,
                  ),
                ),
                SizedBox(
                  width: getPercentageWidth(1),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "673",
                      style: productNameStyle(),
                    ),
                    Text(
                      "Successful Transactions",
                      style: productCatStyle(context, size: 11),
                    )
                  ],
                )
              ],
            ),
          )),
          const VirticalLine(),
          Expanded(
              child: Container(
            padding: EdgeInsets.only(left: getPercentageWidth(2)),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 13,
                  backgroundColor: kGoogle,
                  child: Icon(
                    Icons.check,
                    color: white,
                  ),
                ),
                SizedBox(
                  width: getPercentageWidth(1),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "11",
                      style: productNameStyle(),
                    ),
                    Text(
                      "Failed Transactions",
                      style: productCatStyle(context, size: 11),
                    )
                  ],
                )
              ],
            ),
          )),
        ],
      ),
    );
  }
}
