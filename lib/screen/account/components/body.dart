import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fregies/constants/color.dart';
import 'package:fregies/constants/dimmensions.dart';
import 'package:fregies/constants/maps.dart';
import 'package:fregies/constants/text_styles.dart';
import 'package:fregies/models/product_model.dart';
import 'package:fregies/provider/application_state.dart';
import 'package:fregies/provider/theme_notifier.dart';
import 'package:fregies/utility/delivery_point_form.dart';
import 'package:fregies/widgets/account_card.dart';
import 'package:fregies/widgets/green_appbar.dart';
import 'package:fregies/widgets/title_divider.dart';
import 'package:fregies/widgets/transaction_card.dart';
import 'package:fregies/widgets/transaction_count.dart';
import 'package:fregies/widgets/virtical_line.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/src/provider.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // Pick an image

  List UserProfile = [
    {
      "username": "Williams Jerry",
      "saved": "\$35.45",
      "amount": "32.25",
      "favourite": "456",
      "email": "williamsj@gmail.com",
      "phone": "08036473867",
      "idenity": "",
      "address": "",
      "dp": "assets/user/team1.jpg",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: greenAppbar(context, "User Account"),
      body: SafeArea(
        child: Column(
          children: [
            //this is a stak with 16% height
            const GreenAfterAppbar(),
            Expanded(
                child: Container(
              //color: Colors.grey,
              child: ListView(
                children: [
                  AccountCard(
                    ccolor: kTwitter,
                    ctitle: "Username",
                    ccaption: context
                            .watch<ApplicationState>()
                            .activeUser
                            .first
                            .displayName ??
                        "pending....",
                    // FirebaseAuth.instance.currentUser!.displayName ??
                    //     "pending....",
                    cicon: Icons.person,
                    updateState: ApplicationUpdateState.username,
                    hintText: "Enter Username",
                  ),
                  const DeliveryPointVerv(),
                  AccountCard(
                    ccolor: lightPrimary,
                    ctitle: "Email Address",
                    ccaption: context
                            .watch<ApplicationState>()
                            .activeUser
                            .first
                            .email ??
                        "pending....",
                    cicon: Icons.email_rounded,
                    updateState: ApplicationUpdateState.email,
                    hintText: "Enter your email",
                  ),
                  AccountCard(
                    ccolor: kFacebook,
                    ctitle: "Phone Number",
                    ccaption: context.watch<ApplicationState>().tempNumber ??
                        "pending....",
                    cicon: Icons.settings_phone_rounded,
                    updateState: ApplicationUpdateState.phone,
                    hintText: "2347936XXXX",
                  ),
                  AccountCard(
                    ccolor: kGoogle,
                    ctitle: "Identity verification",
                    ccaption: context
                            .watch<ApplicationState>()
                            .activeUser
                            .first
                            .emailVerified
                        ? "verified"
                        : "pending....",
                    cicon: Icons.admin_panel_settings_sharp,
                    updateState: ApplicationUpdateState.profileImage,
                    hintText: "upload",
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}

class GreenAfterAppbar extends StatelessWidget {
  const GreenAfterAppbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: getPercentageHeight(16),
          // color: Colors.red,
        ),
        Container(
          height: getPercentageHeight(8),
          width: double.infinity,
          decoration: const BoxDecoration(
              color: lightPrimary,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(15))),
        ),
        Positioned(
            top: getPercentageHeight(3),
            left: 0,
            right: 0,
            child: TopAccountCard()),
      ],
    );
  }
}

class TopAccountCard extends StatelessWidget {
  const TopAccountCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: getPercentageHeight(12),
      margin: EdgeInsets.symmetric(horizontal: getPercentageWidth(5)),
      padding: EdgeInsets.symmetric(
          horizontal: getPercentageWidth(3), vertical: getPercentageWidth(3)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).backgroundColor,
          boxShadow: [
            BoxShadow(
              color: ThemeClass.themeNotifier.value == ThemeMode.light
                  ? Color(0xFF414042).withOpacity(0.1)
                  : Colors.transparent,
              blurRadius: 5,
              spreadRadius: 1.0,
            )
          ]),
      child: Row(
        children: [
          Container(
            child: Row(
              children: [
                Stack(
                  children: [
                    Container(
                      width: getPercentageWidth(17),
                      height: getPercentageWidth(18),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 2, color: lightPrimary),
                          image: DecorationImage(
                              image: NetworkImage(context
                                      .watch<ApplicationState>()
                                      .activeUser
                                      .first
                                      .photoURL ??
                                  "https://icons.iconarchive.com/icons/custom-icon-design/pretty-office-2/256/man-icon.png"),
                              fit: BoxFit.cover
                              //AssetImage("assets/user/team2.jpg"),
                              )),
                    ),
                    Positioned(
                      bottom: 5,
                      left: 10,
                      child: GestureDetector(
                        onTap: () {
                          context.read<ApplicationState>().uploadFile();
                          // context
                          //     .read<ApplicationState>()
                          //     .fetchAllStorageFiles();
                        },
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            decoration: BoxDecoration(
                                color: lightPrimary,
                                borderRadius: BorderRadius.circular(1)),
                            child: const Text(
                              "upload",
                              style: TextStyle(fontSize: 10, color: white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: getPercentageWidth(3),
                ),
              ],
            ),
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.only(left: getPercentageWidth(2)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context
                          .watch<ApplicationState>()
                          .activeUser
                          .first
                          .displayName ??
                      "Anonymous",
                  style: productNameStyle(size: 18),
                ),
                Row(
                  children: [
                    const Text(
                      "\$0.00",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: getPercentageWidth(2),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: getPercentageWidth(2)),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: lightPrimary),
                      child: const Text("Saved",
                          style: TextStyle(fontSize: 12, color: white)),
                    )
                  ],
                ),
                Container(
                  width: getPercentageWidth(40),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    border: Border.all(
                        width: 1, color: Theme.of(context).hintColor),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: getPercentageWidth(1),
                      ),
                      Text(
                        context
                            .watch<List<ProductModel>>()
                            .where((element) => element.favourite == true)
                            .toList()
                            .length
                            .toString(),
                        style: productNameStyle(size: 10),
                      ),
                      SizedBox(
                        width: getPercentageWidth(1),
                      ),
                      Text(
                        "Favourite Groceries",
                        style: productCatStyle(context, size: 11),
                      ),
                      SizedBox(
                        width: getPercentageWidth(1),
                      ),
                      const Icon(
                        Icons.favorite,
                        size: 13,
                        color: lightPrimary,
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
        ],
      ),
    );
  }
}
