import 'package:flutter/material.dart';
import 'package:fregies/constants/color.dart';
import 'package:fregies/constants/dimmensions.dart';
import 'package:fregies/constants/text_styles.dart';
import 'package:fregies/provider/card_provider.dart';
import 'package:fregies/provider/theme_notifier.dart';
import 'package:fregies/screen/home/homescreen.dart';
import 'package:fregies/screen/transaction/transaction_screen.dart';
import 'package:fregies/utility/card/card_form.dart';
import 'package:fregies/utility/card/constant.dart';
import 'package:fregies/utility/virtual_card.dart';
import 'package:fregies/widgets/green_appbar.dart';
import 'package:fregies/widgets/text_btn.dart';
import 'package:fregies/widgets/title_divider.dart';
import 'package:fregies/widgets/transaction_card.dart';
import 'package:fregies/widgets/transaction_count.dart';
import 'package:fregies/widgets/virtical_line.dart';
import 'package:provider/src/provider.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List trans = [
    {
      "title": "Groceries",
      "id": "003463",
      "amount": "32.25",
      "date": "Jan 12",
      "status": "success"
    },
    {
      "title": "Groceries",
      "id": "009273",
      "amount": "23.22",
      "date": "Jan 17",
      "status": "success"
    },
    {
      "title": "Groceries",
      "id": "004892",
      "amount": "352.24",
      "date": "Jan 22",
      "status": "success"
    },
    {
      "title": "Groceries",
      "id": "003875",
      "amount": "22.25",
      "date": "Feb 11",
      "status": "fail"
    },
    {
      "title": "Groceries",
      "id": "004974",
      "amount": "434.33",
      "date": "Feb 13",
      "status": "success"
    },
    {
      "title": "Groceries",
      "id": "007983",
      "amount": "345.20",
      "date": "Mar 10",
      "status": "fail"
    },
    {
      "title": "Groceries",
      "id": "003972",
      "amount": "332.50",
      "date": "Mar 18",
      "status": "success"
    },
    {
      "title": "Groceries",
      "id": "009735",
      "amount": "344.20",
      "date": "Mar 19",
      "status": "success"
    },
    {
      "title": "Groceries",
      "id": "006626",
      "amount": "144.30",
      "date": "Apr 15",
      "status": "success"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: greenAppbar(context, "Transactions"),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: getPercentageHeight(100),
              // color: Colors.red,
            ),
            Container(
              height: getPercentageHeight(8),
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: lightPrimary,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(15))),
            ),
            Positioned(
                top: getPercentageHeight(3),
                left: 0,
                right: 0,
                child: const TransactionCount()),
            Positioned(
                top: getPercentageHeight(14),
                left: 0,
                right: 0,
                child: Container(
                  height: getPercentageHeight(100),
                  width: getPercentageWidth(100),
                  // color: Colors.red,
                  padding:
                      EdgeInsets.symmetric(horizontal: getPercentageWidth(5)),
                  child: Center(
                    child: ListView(
                      children: [
                        titleDivider("Active Card", false),

                        // this part is for virtual card
                        context.watch<CardNotifier>().cardList.isNotEmpty
                            ? const VirtualCard()
                            : Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: getPercentageWidth(7),
                                    vertical: getPercentageHeight(8)),
                                child: Wrap(
                                  children: [
                                    const Center(
                                      child: Text(
                                          "Sorry you do not have an active card"),
                                    ),
                                    SizedBox(
                                      height: getPercentageHeight(3),
                                    ),
                                    TextBtn(
                                      horizontal: 1,
                                      vertical: 4,
                                      action: () {
                                        showCardDialog(
                                            context,
                                            HomeScreen(
                                              setPage: 2,
                                            ));
                                      },
                                      title: "+Add Card",
                                    ),
                                  ],
                                ),
                              ),

                        titleDivider("Recent Transactions", true),
                        Container(
                            width: getPercentageWidth(100),
                            height: getPercentageHeight(29),
                            padding: EdgeInsets.symmetric(
                                horizontal: getPercentageWidth(5),
                                vertical: getPercentageWidth(2)),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context).backgroundColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: ThemeClass.themeNotifier.value ==
                                            ThemeMode.light
                                        ? Color(0xFF414042).withOpacity(0.3)
                                        : Colors.transparent,
                                    blurRadius: 4.5,
                                    spreadRadius: 1.6,
                                  ),
                                ]),
                            child: ListView.builder(
                                itemCount: trans.length,
                                itemBuilder: (_, index) {
                                  return TransactionCard(trans: trans[index]);
                                }))
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
