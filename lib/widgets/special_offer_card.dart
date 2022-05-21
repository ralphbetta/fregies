import 'package:flutter/material.dart';
import 'package:fregies/constants/color.dart';
import 'package:fregies/constants/dimmensions.dart';
import 'package:fregies/constants/text_styles.dart';
import 'package:fregies/models/cart_model.dart';
import 'package:fregies/models/product_model.dart';
import 'package:fregies/provider/cart_provider.dart';
import 'package:fregies/provider/theme_notifier.dart';
import 'package:fregies/widgets/square_btn.dart';
import 'package:provider/src/provider.dart';

class SpecialOfferCard extends StatefulWidget {
  const SpecialOfferCard({
    Key? key,
    required this.specialOffer,
  }) : super(key: key);

  final ProductModel specialOffer;

  @override
  State<SpecialOfferCard> createState() => _SpecialOfferCardState();
}

class _SpecialOfferCardState extends State<SpecialOfferCard> {
  int itemCount = 1;
  @override
  Widget build(BuildContext context) {
    CartModel cartProduct = CartModel(
        id: context.read<CartNotifier>().cartList.length + 1,
        product: widget.specialOffer,
        count: itemCount);

    return Container(
      width: getPercentageWidth(80),
      height: getPercentageHeight(15),
      margin: const EdgeInsets.only(right: 8),
      padding: EdgeInsets.symmetric(
          vertical: getPercentageHeight(1), horizontal: getPercentageWidth(4)),
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
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                height: getPercentageHeight(8),
                width: getPercentageHeight(12),
                child: Image(
                  image: NetworkImage(widget.specialOffer.image),
                ),
              ),
              Expanded(
                  child: Container(
                margin: EdgeInsets.only(left: getPercentageWidth(2)),
                // color: Colors.blue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.specialOffer.product,
                      style: productNameStyle(size: 12),
                    ),
                    SizedBox(
                      height: getPercentageHeight(1) - 3,
                    ),
                    Row(
                      children: [
                        Text(
                          widget.specialOffer.unit +
                              widget.specialOffer.discountPrice.toString(),
                          style: mainPriceStyle(context, size: 12),
                        ),
                        Text(
                          " /" + widget.specialOffer.rate,
                          style: productNameStyle(size: 12),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getPercentageHeight(1) - 3,
                    ),
                    Row(
                      children: [
                        Text(
                          "Express Delivery -",
                          style: productCatStyle(context, size: 12),
                        ),
                        const Text(
                          "Friday",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    )
                  ],
                ),
              )),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: getPercentageHeight(1)),
            child: Row(
              children: [
                SpeacialOfferBtn(cartProduct: cartProduct),
                Expanded(
                    child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BtnSquare(
                        primary: false,
                        action: () {
                          setState(() {
                            itemCount =
                                itemCount > 1 ? itemCount - 1 : itemCount;
                          });
                        },
                        choiceIcon: Icons.remove,
                        size: 25,
                      ),
                      Container(
                        width: 50,
                        height: 25,
                        decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor),
                        child: Center(
                          child: Text(itemCount.toString()),
                        ),
                      ),
                      BtnSquare(
                        action: () {
                          setState(() {
                            itemCount = itemCount < widget.specialOffer.quantity
                                ? itemCount + 1
                                : itemCount;
                          });
                        },
                        choiceIcon: Icons.add,
                        size: 25,
                      )
                    ],
                  ),
                )),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SpeacialOfferBtn extends StatelessWidget {
  const SpeacialOfferBtn({
    Key? key,
    required this.cartProduct,
  }) : super(key: key);

  final CartModel cartProduct;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        !context.read<CartNotifier>().inCart(cartProduct)
            ? context.read<CartNotifier>().addProduct(cartProduct)
            : context.read<CartNotifier>().deleteProduct(cartProduct);
      },
      child: Container(
          height: 25,
          width: getPercentageHeight(12),
          decoration: BoxDecoration(
              color: lightPrimary, borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Text(
              context.watch<CartNotifier>().inCart(cartProduct)
                  ? "Remove"
                  : "Add to Cart",
              style: const TextStyle(color: white),
            ),
          )),
    );
  }
}
