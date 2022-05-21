import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fregies/constants/color.dart';
import 'package:fregies/constants/dimmensions.dart';
import 'package:fregies/constants/functions.dart';
import 'package:fregies/constants/maps.dart';
import 'package:fregies/constants/text_styles.dart';
import 'package:fregies/constants/values.dart';
import 'package:fregies/provider/card_provider.dart';
import 'package:fregies/provider/cart_provider.dart';
import 'package:fregies/screen/cart/cart_screen.dart';
import 'package:fregies/screen/checkout/chechout_screen.dart';
import 'package:fregies/screen/checkout/components/payment_method.dart';
import 'package:fregies/utility/card/card_form.dart';
import 'package:fregies/utility/card/constant.dart';
import 'package:fregies/utility/delivery_point_form.dart';
import 'package:fregies/utility/virtual_card.dart';
import 'package:fregies/widgets/alertBox/alert_box.dart';
import 'package:fregies/widgets/cart_count_icon.dart';
import 'package:fregies/widgets/horizontal_line.dart';
import 'package:fregies/widgets/text_btn.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    double sWidth = MediaQuery.of(context).size.width;

    CartNotifier cartNotifier = Provider.of<CartNotifier>(context);
    CardNotifier cardNotifier = Provider.of<CardNotifier>(context);

    /////////////////////////////////////////////////////////////////////////////////////
    ///This is a list of payment method, but the card is stacked so it can be deleted ///
    /////////////////////////////////////////////////////////////////////////////////////

    List paymentMethodListPages = [
      context.watch<CardNotifier>().cardList.isEmpty
          ? const AddCard()
          : Stack(
              children: [
                VirtualCard(),
                Positioned(
                  right: 40,
                  bottom: 0,
                  child: GestureDetector(
                    onTap: () {
                      print("deleted");
                      context.read<CardNotifier>().deleteProduct(
                          context.read<CardNotifier>().cardList.first);
                    },
                    child: const CircleAvatar(
                      radius: 14,
                      backgroundColor: lightPrimary,
                      child: Icon(
                        Icons.delete_forever,
                        color: white,
                        size: 17,
                      ),
                    ),
                  ),
                )
              ],
            ),
      const NetBanking(),
      const PayOnDelivery(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Checkout",
          style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 22),
        ),
        actions: [
          const CartCountIcon(),
          SizedBox(
            width: getPercentageWidth(2),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: sWidth * 0.05),
          child: ListView(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(top: sWidth * 0.01, bottom: sWidth * 0.01),
                child: Text(
                  "Payment Mode",
                  style: productNameStyle(),
                ),
              ),
              Text(
                "Select your prefered payment mode",
                style: productCatStyle(context, size: 12),
              ),
              SizedBox(
                height: getPercentageHeight(3),
              ),
              Column(
                children: [
                  ...List.generate(
                    paymentMethodList.length,
                    (index) => Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedPaymentMethod = index;
                            });
                          },
                          child: PaymetMethodCard(
                              icon: paymentMethodList[index]['icon'],
                              caption: paymentMethodList[index]['caption'],
                              index: index),
                        ),
                        horizontalLine(
                          topMargin: getPercentageHeight(1),
                          bottomMargin: getPercentageHeight(1),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: getPercentageHeight(3),
              ),
              paymentMethodListPages[selectedPaymentMethod],
              SizedBox(
                height: getPercentageHeight(3),
              ),
              const DeliveryPointVerv(
                edge: 0,
                alert: false,
              ),
              SizedBox(
                height: getPercentageHeight(2),
              ),
              TextBtn(
                vertical: 4,
                horizontal: 1,
                action: () {
                  //print("proceed");

                  if (cartNotifier.totalAmmount < 0.1) {
                    popUp(context, "Error Alert", <Widget>[
                      const Text("There are no items to checkout"),
                    ]);
                  } else if (selectedPaymentMethod == 0 &&
                      cardNotifier.cardList.isEmpty) {
                    popUp(context, "Error Alert", <Widget>[
                      Text(
                        "You do not have any active card",
                        style: productNameStyle(),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Kindly add a card",
                        style: productCatStyle(context, size: 14),
                        textAlign: TextAlign.center,
                      )
                    ]);
                  } else if (selectedPaymentMethod == 1) {
                    popUp(context, "Error Alert", <Widget>[
                      Text(
                        "Sorry this payment method is temporarily unaccepted",
                        style: productNameStyle(),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Kindly Select another payment method",
                        style: productCatStyle(context, size: 14),
                        textAlign: TextAlign.center,
                      )
                    ]);
                  } else if (deliveryAddress.isEmpty) {
                    popUp(context, "Error Alert", <Widget>[
                      Text(
                        "Delivery Point is unverifed",
                        style: productNameStyle(),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Kindly include your delivery location",
                        style: productCatStyle(context, size: 14),
                        textAlign: TextAlign.center,
                      )
                    ]);
                  } else {
                    //_verifyCard()
                    popUp(context, "Success Alert", <Widget>[
                      Container(
                        width: getPercentageWidth(100),
                        height: getPercentageWidth(50),
                        //color: Colors.red,
                        child: const Image(
                          image: AssetImage("assets/gif/screen-1.gif"),
                        ),
                      ),
                      Text(
                        "Payment Successful",
                        style: productNameStyle(size: 20),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: getPercentageWidth(2),
                      ),
                      Text(
                        "The payment of \$" +
                            context
                                .read<CartNotifier>()
                                .totalAmmount
                                .toStringAsFixed(2) +
                            " has been successfully completed for the purchase of groceries on Fregies",
                        style: productCatStyle(context, size: 13),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: getPercentageWidth(2),
                      ),
                      const horizontalLine(),
                      const vertGap(
                        height: 5,
                      ),
                      const dualStyleText(
                        leftText: "Transaction ID",
                        rightText: "#0056736547",
                      ),
                      const vertGap(
                        height: 1,
                      ),
                      dualStyleText(
                        leftText: "executed on",
                        rightText: DateFormat.yMMMEd().format(DateTime.now()),
                      ),
                      const vertGap(
                        height: 5,
                      ),
                      TextBtn(
                        vertical: 3,
                        horizontal: 1,
                        title: "done",
                        action: () {
                          Navigator.pop(context);
                        },
                      )
                    ]);
                  }
                },
                title: "Proceed - \$" +
                    context
                        .watch<CartNotifier>()
                        .totalAmmount
                        .toStringAsFixed(2),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class vertGap extends StatelessWidget {
  const vertGap({
    Key? key,
    required this.height,
  }) : super(key: key);

  final int height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getPercentageWidth(5),
    );
  }
}

class dualStyleText extends StatelessWidget {
  const dualStyleText({
    Key? key,
    required this.leftText,
    required this.rightText,
  }) : super(key: key);
  final String leftText;
  final String rightText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          leftText,
          style: productCatStyle(context, size: 15),
        ),
        Text(rightText, style: mainPriceStyle(context))
      ],
    );
  }
}

//This is for the card payment method
class AddCard extends StatefulWidget {
  const AddCard({Key? key}) : super(key: key);

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: getPercentageWidth(100),
      //height: 200,
      padding: EdgeInsets.symmetric(
          vertical: getPercentageHeight(10), horizontal: getPercentageWidth(8)),
      child: TextBtn(
        vertical: 4,
        horizontal: 1,
        title: "+ Add Card",
        action: () {
          showCardDialog(context, const CheckoutScreen());
        },
      ),
    );
  }
}

class AddCardLabel extends StatelessWidget {
  const AddCardLabel({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: productCatStyle(context),
    );
  }
}

//this is for the on delivery payment method
class PayOnDelivery extends StatelessWidget {
  const PayOnDelivery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getPercentageWidth(100),
      height: 200,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/gif/home-del.gif"),
              fit: BoxFit.fitWidth)),
    );
  }
}

//this is the net banking payment method * currently unavailable
class NetBanking extends StatelessWidget {
  const NetBanking({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getPercentageWidth(100),
      height: 200,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "OOPS!",
            style: productNameStyle(size: 25),
          ),
          const Text(
            "Net Banking payment method is temporarily disabled",
            textAlign: TextAlign.center,
          )
        ],
      )),
    );
  }
}
