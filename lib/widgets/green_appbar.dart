import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fregies/constants/color.dart';
import 'package:fregies/constants/dimmensions.dart';
import 'package:fregies/widgets/cart_count_icon.dart';

AppBar greenAppbar(BuildContext context, String title) {
  return AppBar(
    backgroundColor: lightPrimary,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: lightPrimary,
    ),
    leading: IconButton(
      icon: const Icon(
        Icons.more_vert,
        color: white,
        size: 32,
      ),
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
    ),
    actions: [
      SizedBox(
        width: getPercentageWidth(5),
      ),
      Row(
        children: [
          SizedBox(
            width: getPercentageWidth(10),
          ),
          Text(title,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: white, fontSize: 22)),
        ],
      ),
      Expanded(child: Container()),
      const CartCountIcon(
        primary: false,
      ),
      SizedBox(
        width: getPercentageWidth(2),
      )
    ],
  );
}
