import 'package:flutter/material.dart';
import 'package:fregies/constants/color.dart';
import 'package:fregies/constants/dimmensions.dart';
import 'package:fregies/constants/functions.dart';
import 'package:fregies/constants/maps.dart';
import 'package:fregies/constants/text_styles.dart';
import 'package:fregies/constants/values.dart';
import 'package:fregies/models/cart_model.dart';
import 'package:fregies/models/product_model.dart';
import 'package:fregies/provider/cart_provider.dart';
import 'package:fregies/provider/theme_notifier.dart';
import 'package:fregies/screen/cart/cart_screen.dart';
import 'package:fregies/screen/product_details/product_detail_screen.dart';
import 'package:fregies/widgets/square_btn.dart';
import 'package:provider/src/provider.dart';

Widget allProductCard(ProductModel product, BuildContext context) {
  return ProudctCard(
    product: product,
  );
}

class ProudctCard extends StatefulWidget {
  const ProudctCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  State<ProudctCard> createState() => _ProudctCardState();
}

class _ProudctCardState extends State<ProudctCard> {
  @override
  Widget build(BuildContext context) {
    CartModel cartProduct = CartModel(
        id: context.read<CartNotifier>().cartList.length + 1,
        product: widget.product,
        count: 1);

    return GestureDetector(
      onTap: () {
        print("tapped product card");
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProductDetailScreen(product: widget.product);
        }));
      },
      child: Container(
          margin: EdgeInsets.only(
            right: getPercentageWidth(0),
            top: getPercentageWidth(2),
            bottom: getPercentageWidth(2),
          ),
          width: getPercentageWidth(42),
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
          child: Column(
            children: [
              Expanded(
                  flex: 2,
                  child: Container(
                    width: getPercentageWidth(42),
                    padding: EdgeInsets.only(bottom: 7),
                    decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(10),
                        border: Border(
                            bottom: BorderSide(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                width: 2))),
                    child: Stack(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                                // Image(image: AssetImage(widget.product.image)),
                                Image(
                                    image: NetworkImage(widget.product.image)),
                          ),
                        ),
                        Positioned(
                            right: 0,
                            child: IconButton(
                              icon: Icon(
                                Icons.favorite,
                                color: !widget.product.favourite
                                    ? Theme.of(context).scaffoldBackgroundColor
                                    : lightPrimary,
                              ),
                              onPressed: () {
                                print("marked");
                                setState(() {
                                  widget.product.favourite =
                                      !widget.product.favourite;

                                  // if (favouriteList.contains(widget.product)) {
                                  //   favouriteList.remove(widget.product);
                                  // } else {
                                  //   favouriteList.add(widget.product);
                                  // }
                                });
                              },
                            ))
                      ],
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.product.product,
                              style: productNameStyle(),
                            ),
                            Text(
                              widget.product.category,
                              style: productCatStyle(context),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: Text(
                                    widget.product.discountPrice.toString(),
                                    style: mainPriceStyle(context),
                                  ),
                                ),
                                Text(
                                  widget.product.price.toString(),
                                  style: slashPriceStyle(context),
                                ),
                              ],
                            ),
                          ],
                        ),
                        BtnSquare(
                          primary:
                              !context.read<CartNotifier>().inCart(cartProduct),
                          action: () {
                            !context.read<CartNotifier>().inCart(cartProduct)
                                ? context
                                    .read<CartNotifier>()
                                    .addProduct(cartProduct)
                                : context
                                    .read<CartNotifier>()
                                    .deleteProduct(cartProduct);

                            // if (context
                            //     .read<CartNotifier>()
                            //     .inCart(cartProduct)) {
                            //   Navigator.push(context,
                            //       MaterialPageRoute(builder: (context) {
                            //     return CartScreen(product: widget.product);
                            //   }));
                            // } else {
                            //   Navigator.pop(context);
                            // }
                          },
                          choiceIcon:
                              context.watch<CartNotifier>().inCart(cartProduct)
                                  ? Icons.shopping_cart_outlined
                                  : Icons.add_shopping_cart,
                        )
                      ],
                    ),
                  )),
            ],
          )),
    );
  }
}
