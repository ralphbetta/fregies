import 'package:flutter/material.dart';
import 'package:fregies/constants/dimmensions.dart';
import 'package:fregies/constants/text_styles.dart';
import 'package:fregies/constants/values.dart';
import 'package:fregies/provider/cart_provider.dart';
import 'package:fregies/provider/theme_notifier.dart';
import 'package:fregies/screen/checkout/chechout_screen.dart';
import 'package:fregies/widgets/text_btn.dart';
import 'package:provider/src/provider.dart';

class CheckoutHolder extends StatelessWidget {
  const CheckoutHolder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: getPercentageWidth(5), vertical: getPercentageWidth(3)),
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          boxShadow: [
            BoxShadow(
              color: ThemeClass.themeNotifier.value == ThemeMode.light
                  ? Color(0xFFF2F2F2).withOpacity(0.5)
                  : Colors.transparent,
              blurRadius: 0.1,
              spreadRadius: 2.6,
            )
          ],
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                  context.watch<CartNotifier>().totalAmmount.toStringAsFixed(2),
                  //Accumulated_cart_price.toStringAsFixed(2),
                  style: mainPriceStyle(context)),
              Text(context.watch<CartNotifier>().cartList.length.toString() +
                  " items in bucket list")
            ],
          ),
          Padding(
            padding: EdgeInsets.all(2.0),
            child: TextBtn(
              vertical: 0,
              horizontal: 5,
              title: "Checkout",
              action: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const CheckoutScreen();
                }));
              },
            ),
          ),
        ],
      ),
    );
  }
}
