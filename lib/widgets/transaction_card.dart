import 'package:flutter/material.dart';
import 'package:fregies/constants/color.dart';
import 'package:fregies/constants/dimmensions.dart';
import 'package:fregies/constants/text_styles.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    Key? key,
    required this.trans,
  }) : super(key: key);

  final Map trans;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getPercentageHeight(7),
      width: getPercentageWidth(100),
      margin: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
                width: 1, color: Theme.of(context).hintColor.withOpacity(0.2))),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: getPercentageHeight(5),
            height: getPercentageHeight(5),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 2, color: lightPrimary),
            ),
            child: const Image(
              image: AssetImage("assets/icons/groceries.png"),
            ),
          ),
          SizedBox(
            width: getPercentageWidth(5),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(trans['title'], style: productNameStyle()),
              Text(
                "Trans ID #" + trans['id'],
                style: productCatStyle(context, size: 12),
              )
            ],
          ),
          Expanded(child: Container()),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(trans['amount'],
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      color: trans['status'] == "fail"
                          ? kGoogle
                          : Theme.of(context).appBarTheme.iconTheme!.color)),
              Text(
                trans['date'],
                style: productCatStyle(context, size: 12),
              )
            ],
          )
        ],
      ),
    );
  }
}
