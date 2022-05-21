import "package:flutter/material.dart";
import 'package:fregies/constants/color.dart';
import 'package:fregies/constants/dimmensions.dart';
import 'package:fregies/constants/functions.dart';
import 'package:fregies/constants/maps.dart';
import 'package:fregies/constants/text_styles.dart';
import 'package:fregies/constants/values.dart';
import 'package:fregies/models/cart_model.dart';
import 'package:fregies/models/user_model.dart';
import 'package:fregies/provider/cart_provider.dart';
import 'package:fregies/provider/theme_notifier.dart';
import 'package:fregies/screen/home/homescreen.dart';
import 'package:fregies/screen/product_details/product_detail_screen.dart';
import 'package:fregies/widgets/checkout_card.dart';
import 'package:fregies/widgets/square_btn.dart';
import 'package:fregies/widgets/text_btn.dart';
import 'package:provider/src/provider.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //accumulatePrice();
  }

  @override
  Widget build(BuildContext context) {
    // print("this is the cart list");
    // print(cart);

    CartNotifier cartNotifier = Provider.of<CartNotifier>(context);

    // print(cartNotifier.cartList.first.product.product);
    // print(cartNotifier.cartList.length);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return HomeScreen();
            }));
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          "Shopping Cart",
          style:
              TextStyle(color: Theme.of(context).appBarTheme.iconTheme!.color),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<CartNotifier>().clearCart();
            },
            icon: const Icon(Icons.delete_forever),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.03,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: cartNotifier.cartList.isNotEmpty
                    ? const CardListHolder()
                    : Center(
                        child: Text(
                          "You do not have any item in your cart",
                          style: productCatStyle(context),
                        ),
                      )),
            cartNotifier.cartList.isNotEmpty
                ? Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: getPercentageHeight(1)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          color: Theme.of(context).hintColor,
                        ),
                        Text(
                          "Swipe to delete",
                          style: productCatStyle(context),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Theme.of(context).hintColor,
                        ),
                      ],
                    ),
                  )
                : Container(),
            Container(
              height: getPercentageHeight(14),
              color: Theme.of(context).backgroundColor,
              child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                      horizontal: getPercentageWidth(5),
                      vertical: getPercentageWidth(6)),
                  child: const CheckoutHolder()),
            )
          ],
        ),
      ),
    );
  }
}

class CartProduct extends StatefulWidget {
  const CartProduct({Key? key, required this.productInCart}) : super(key: key);
  final CartModel productInCart;

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProductDetailScreen(product: widget.productInCart.product);
        }));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).backgroundColor,
        ),
        margin: EdgeInsets.symmetric(
            vertical: getPercentageWidth(2), horizontal: getPercentageWidth(5)),
        padding: EdgeInsets.symmetric(
            vertical: getPercentageWidth(2), horizontal: getPercentageWidth(2)),
        child: Row(
          children: [
            Container(
              width: getPercentageWidth(15),
              height: getPercentageWidth(15),
              padding: EdgeInsets.all(getPercentageWidth(2)),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).scaffoldBackgroundColor),
              child: Image(
                image: NetworkImage(widget.productInCart.product.image),
              ),
            ),
            SizedBox(
              width: getPercentageWidth(4),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.productInCart.product.product,
                  style: productNameStyle(),
                ),
                SizedBox(
                  height: getPercentageWidth(2),
                ),
                Row(
                  children: [
                    Text(
                      widget.productInCart.product.price.toString(),
                      style: mainPriceStyle(context),
                    ),
                    Text("/ 0.5" + widget.productInCart.product.rate)
                  ],
                ),
              ],
            ),
            Expanded(child: Container()),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BtnSquare(
                    primary: false,
                    action: () {
                      context
                          .read<CartNotifier>()
                          .decreaseQty(widget.productInCart);
                    },
                    choiceIcon: Icons.remove,
                  ),
                  Container(
                    width: 50,
                    height: 25,
                    decoration:
                        BoxDecoration(color: Theme.of(context).backgroundColor),
                    child: Center(
                      child: Text(widget.productInCart.count.toString()),
                    ),
                  ),
                  BtnSquare(
                    action: () {
                      context
                          .read<CartNotifier>()
                          .increaseQty(widget.productInCart);
                    },
                    choiceIcon: Icons.add,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CardListHolder extends StatelessWidget {
  const CardListHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartNotifier cartNotifier = Provider.of<CartNotifier>(context);
    return Container(
        child: ListView.builder(
            itemCount: cartNotifier.cartList.length,
            itemBuilder: (_, index) {
              return Dismissible(
                key: Key("wow" +
                    context
                        .watch<CartNotifier>()
                        .cartList[index]
                        .id
                        .toString()),
                //key: Key('item ${cart[index]}'),
                child: CartProduct(
                    productInCart:
                        context.watch<CartNotifier>().cartList[index]),
                background: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: getPercentageWidth(5)),
                  color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Icon(
                        Icons.delete_forever,
                        color: white,
                      ),
                      Icon(
                        Icons.delete_forever,
                        color: white,
                      )
                    ],
                  ),
                ),
                onDismissed: (DismissDirection direction) {
                  if (direction == DismissDirection.startToEnd) {
                    print('deleted');
                  } else {
                    print('Remove Add to favourite');
                  }

                  // cartNotifier.deleteProduct(cartNotifier.cartList[index]);
                },

                confirmDismiss: (DismissDirection direction) async {
                  return await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Confirm'),
                          content: const Text(
                              'Are you sure you want to delete this?'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                                child: Text('Cancel')),
                            TextButton(
                                onPressed: () {
                                  cartNotifier.deleteProduct(
                                      cartNotifier.cartList[index]);

                                  Navigator.of(context).pop(true);
                                },
                                child: const Text('Proceed')),
                          ],
                        );
                      });
                },
              );
            }));
  }
}
