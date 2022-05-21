import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fregies/config/route_config.dart';
import 'package:fregies/constants/color.dart';
import 'package:fregies/constants/dimmensions.dart';
import 'package:fregies/constants/maps.dart';
import 'package:fregies/constants/values.dart';
import 'package:fregies/provider/application_state.dart';
import 'package:fregies/provider/cart_provider.dart';
import 'package:fregies/provider/remote_config.dart';
import 'package:fregies/screen/cart/cart_screen.dart';
import 'package:provider/src/provider.dart';

AppBar homeAppBar(BuildContext context) {
  return AppBar(
    leading: IconButton(
      icon: const Icon(
        Icons.more_vert,
        size: 34,
      ),
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
    ),
    actions: [
      Row(
        children: [
          SizedBox(
            width: getPercentageHeight(8),
          ),
          Container(
            width: getPercentageWidth(9),
            height: getPercentageWidth(9),
            decoration: BoxDecoration(
                border:
                    Border.all(width: 1, color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: NetworkImage(context
                            .watch<ApplicationState>()
                            .activeUser
                            .first
                            .photoURL ??
                        "https://icons.iconarchive.com/icons/custom-icon-design/pretty-office-2/256/man-icon.png"),
                    fit: BoxFit.contain)),
          ),
          SizedBox(
            width: getPercentageWidth(5),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Container()),
              Container(
                width: getPercentageWidth(50),
                child: Text(
                  context
                          .watch<ApplicationState>()
                          .activeUser
                          .first
                          .displayName ??
                      "Annoymous",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontSize: 13, overflow: TextOverflow.ellipsis),
                ),
              ),
              Text(
                context.watch<RemoteState>().homePageCaption,
                style: Theme.of(context).textTheme.caption,
              ),
              Expanded(child: Container()),
            ],
          )
        ],
      ),
      Expanded(child: Container()),
      Stack(
        children: [
          IconButton(
            icon: const Icon(
              Icons.shopping_cart_outlined,
              size: 30,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const CartScreen(
                    // product: {},
                    );
              }));
            },
          ),
          Positioned(
            right: 5,
            child: CircleAvatar(
              backgroundColor: lightPrimary,
              radius: 8,
              child: Text(
                context.watch<CartNotifier>().cartList.length.toString(),
                style: TextStyle(color: white, fontSize: 10),
              ),
            ),
          )
        ],
      ),
      SizedBox(
        width: getPercentageWidth(2),
      )
    ],
  );
}
