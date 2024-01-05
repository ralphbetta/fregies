import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fregies/config/route_config.dart';
import 'package:fregies/config/theme_config.dart';
import 'package:fregies/constants/dimmensions.dart';
import 'package:fregies/constants/text_styles.dart';
import 'package:fregies/provider/application_state.dart';
import 'package:fregies/provider/theme_notifier.dart';
import 'package:fregies/screen/admin/products/product_action.dart';
import 'package:fregies/screen/admin/products/products_screen.dart';
import 'package:fregies/screen/home/homescreen.dart';
import 'package:fregies/screen/signin/signin_screen.dart';
import 'package:fregies/widgets/horizontal_line.dart';
import 'package:fregies/widgets/square_btn.dart';
import 'package:provider/src/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class CustomDraw extends StatefulWidget {
  const CustomDraw({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDraw> createState() => _CustomDrawState();
}

class _CustomDrawState extends State<CustomDraw> {
  final adminEmail = "gxaviprank@gmail.com";

  @override
  void initState() {
    super.initState();
    this.initMyLibrary();
  }

  void initMyLibrary() {
    LicenseRegistry.reset();
    LicenseRegistry.addLicense(() async* {
      yield const LicenseEntryWithLineBreaks(<String>['ACustomLibrary'], '''
                            Copyright 2022 Fregies.com.
                            All rights reserved.

     *The Redistributions of this source code must retain the above copyright
  notice, this list of conditions and the following disclaimer.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT 
        HOLDERS''');
    });
  }

  @override
  Widget build(BuildContext context) {
    void _browserRedirect() async {
      String phone = "2347080712994";
      String message = "Hello! looking to talk to a custommer care agent";
      //const url = 'https://blog.logrocket.com';

      String url() {
        if (Platform.isAndroid) {
          return "https://wa.me/$phone/?text=${Uri.parse(message)}"; // new line
        } else {
          return "https://api.whatsapp.com/send?phone=$phone=${Uri.parse(message)}"; // new line
        }
      }

      if (await canLaunch(url())) {
        await launch(url(), forceSafariVC: false);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.only(top: getPercentageHeight(6)),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: getPercentageWidth(7),
              ),
              Container(
                width: getPercentageWidth(15),
                height: getPercentageWidth(15),
                decoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage("assets/icon/icon1.png"),
                    )),
              ),
              SizedBox(
                width: getPercentageWidth(5),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: getPercentageWidth(2),
                  ),
                  Text(
                    "Fregies",
                    style: productNameStyle(size: 18),
                  ),
                  Text(
                    "Version: 1.0",
                    style: productCatStyle(
                      context,
                    ),
                  )
                ],
              ),
              Expanded(child: Container()),
              Container(
                margin: EdgeInsets.only(
                    top: getPercentageHeight(2), right: getPercentageWidth(5)),
                child: BtnSquare(
                    action: () {
                      Navigator.pop(context);
                    },
                    choiceIcon: Icons.cancel),
              )
            ],
          ),
          const horizontalLine(),
          SizedBox(
            height: getPercentageHeight(10),
          ),
          DrawerBtn(
              caption: "Your Favourite",
              icon: Icons.favorite,
              action: () {
                // I am here
                irreversibleNavigate(
                    context,
                    HomeScreen(
                      setPage: 1,
                    ));
                print("favourite");
              }),
          DrawerBtn(
              caption: "Payments",
              icon: Icons.credit_card,
              action: () {
                irreversibleNavigate(
                    context,
                    HomeScreen(
                      setPage: 2,
                    ));
              }),
          DrawerBtn(
              caption: "Contact Us",
              icon: Icons.chat_bubble,
              action: () async {
                print("contact us");

                _browserRedirect();
              }),
          DrawerBtn(
              caption: "About Us",
              icon: Icons.info_rounded,
              action: () {
                showAboutDialog(
                    context: context,
                    applicationVersion: "Version 1.0.0",
                    applicationName: "Fregies",
                    children: <Widget>[
                      const Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Text(
                            'This is Fregies groceries store app that allows only purchase of fruits, vegetables, nuts and other groceries. Groceries can be added to favourite for regular purchase with e-payment systems enabled',
                            textAlign: TextAlign.center,
                          ))
                    ],
                    applicationLegalese: "©2022 fregies.com",
                    applicationIcon: Image(
                      image: AssetImage("assets/icon/icon1.png"),
                      width: getPercentageWidth(12),
                    ));
              }),
          context.read<ApplicationState>().activeUser.first.email == adminEmail
              ? DrawerBtn(
                  caption: "Add product",
                  icon: Icons.library_add,
                  action: () async {
                    reversibleNavigation(context, ProductScreen());
                  })
              : Container(),
          context.read<ApplicationState>().activeUser.first.email == adminEmail
              ? DrawerBtn(
                  caption: "Manage Product",
                  icon: Icons.folder_outlined,
                  action: () async {
                    reversibleNavigation(context, ProductAction());
                  })
              : Container(),
          DrawerBtn(
              caption: "Change Theme",
              icon: Icons.brightness_4_rounded,
              action: () {
                ThemeConfig().switchTheme();
              }),
          SizedBox(
            height: context.read<ApplicationState>().activeUser.first.email ==
                    adminEmail
                ? getPercentageHeight(9)
                : getPercentageHeight(22),
          ),
          DrawerBtn(
              caption: "Log Out",
              icon: Icons.logout_outlined,
              action: () {
                irreversibleNavigate(context, const SignInScreen());
                context.read<ApplicationState>().signOut();
              }),
        ],
      ),
    );
  }
}

class DrawerBtn extends StatelessWidget {
  const DrawerBtn({
    Key? key,
    required this.caption,
    required this.icon,
    required this.action,
  }) : super(key: key);
  final String caption;
  final IconData icon;
  final Function() action;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: getPercentageHeight(2) - 4,
            horizontal: getPercentageWidth(6)),
        margin: EdgeInsets.symmetric(
            horizontal: getPercentageWidth(6),
            vertical: getPercentageWidth(1) + 2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).backgroundColor,
            boxShadow: [
              BoxShadow(
                color: ThemeClass.themeNotifier.value == ThemeMode.light
                    ? Color(0xFFF2F2F2).withOpacity(0.5)
                    : Colors.transparent,
                blurRadius: 0.1,
                spreadRadius: 2.6,
              )
            ]),
        child: Row(
          children: [
            BtnSquare(
              action: () {},
              choiceIcon: icon,
              primary: false,
            ),
            SizedBox(
              width: getPercentageWidth(5),
            ),
            Text(caption)
          ],
        ),
      ),
    );
  }
}
