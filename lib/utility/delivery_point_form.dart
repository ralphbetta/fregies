import 'package:flutter/material.dart';
import 'package:fregies/constants/color.dart';
import 'package:fregies/constants/dimmensions.dart';
import 'package:fregies/constants/text_styles.dart';
import 'package:fregies/constants/values.dart';
import 'package:fregies/provider/theme_notifier.dart';

class DeliveryPointVerv extends StatefulWidget {
  const DeliveryPointVerv({
    Key? key,
    this.edge = 5,
    this.alert = true,
  }) : super(key: key);
  final int edge;
  final bool alert;

  @override
  State<DeliveryPointVerv> createState() => _DeliveryPointVervState();
}

class _DeliveryPointVervState extends State<DeliveryPointVerv> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
          left: getPercentageWidth(widget.edge),
          right: getPercentageWidth(widget.edge),
          top: getPercentageWidth(3)),
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Delivery Point Verification",
                    style: productNameStyle(size: 16),
                  ),
                  Text("pending....", style: productCatStyle(context, size: 12))
                ],
              ),
              deliveryAddress.isNotEmpty
                  ? const Icon(
                      Icons.check_rounded,
                      color: lightPrimary,
                    )
                  : IconButton(
                      onPressed: () {
                        print("ready to update");
                      },
                      icon: const Icon(Icons.border_color_rounded))
            ],
          ),
          Container(
              width: double.infinity,
              height: getPercentageHeight(8),
              color: Theme.of(context).scaffoldBackgroundColor,
              child: TextFormField(
                //controller: TextEditingController(),
                keyboardType: TextInputType.multiline,
                initialValue: deliveryAddress,
                maxLines: 3,
                onChanged: (value) {
                  //print(value);
                  setState(() {
                    deliveryAddress = value;
                  });
                },
                decoration: const InputDecoration(
                    hintText: "", border: InputBorder.none),
              )),
          widget.alert
              ? Row(
                  children: const [
                    Icon(
                      Icons.error_outline_rounded,
                      color: lightPrimary,
                    )
                  ],
                )
              : Container()
        ],
      ),
    );
  }
}
