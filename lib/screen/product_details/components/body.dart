import "package:flutter/material.dart";
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
import 'package:fregies/widgets/cart_count_icon.dart';
import 'package:fregies/widgets/checkout_card.dart';
import 'package:fregies/widgets/display_divider.dart';
import 'package:fregies/widgets/square_btn.dart';
import 'package:fregies/widgets/text_btn.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  const Body({Key? key, required this.product}) : super(key: key);
  final ProductModel product;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int itemCount = 1;

  List<dynamic> sugestionsList = [];

  Future<void> sugestion() async {
    List pen = context
        .watch<List<ProductModel>>()
        .where((element) => element.category == widget.product.category)
        .toList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //this is not needed since it's a real time data
    //sugestion();
    //accumulatePrice();
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> sugestionsList = context
        .watch<List<ProductModel>>()
        .where((element) => element.category == widget.product.category)
        .toList();

    CartNotifier cartNotifier = Provider.of<CartNotifier>(context);

    CartModel cartProduct = CartModel(
        id: cartNotifier.cartList.length + 1,
        product: widget.product,
        count: itemCount);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: SizedBox(
              child: ListView(
                children: [
                  SizedBox(
                    height: getPercentageHeight(25),
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: getPercentageHeight(25),
                          decoration: BoxDecoration(
                              color: Theme.of(context).backgroundColor,
                              borderRadius: const BorderRadius.vertical(
                                  bottom: Radius.circular(30))),
                          child: Image(
                            image: NetworkImage(widget.product.image),
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
                                });
                              },
                            )),
                      ],
                    ),
                  ),
                  Container(
                    width: getPercentageWidth(100),
                    padding: EdgeInsets.symmetric(
                        vertical: getPercentageHeight(2),
                        horizontal: getPercentageWidth(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.product.product +
                                  " " +
                                  widget.product.category,
                              style: productNameStyle(size: 20),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                ...List.generate(
                                    5,
                                    (index) => Icon(
                                          Icons.star,
                                          size: 16,
                                          color: index <=
                                                  (widget.product.rating - 1)
                                              ? Colors.orange
                                              : Colors.grey,
                                        )),
                                Text(widget.product.rating.toString())
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(widget.product.discountPrice.toString(),
                                style: mainPriceStyle(context, size: 18)),
                            Text("/"),
                            Text(
                              widget.product.price.toString(),
                              style: slashPriceStyle(context, size: 18),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: getPercentageWidth(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextBtn(
                          vertical: 2,
                          horizontal: 6,
                          title: cartNotifier.inCart(cartProduct)
                              ? "Remove from cart"
                              : "Add to cart",
                          action: () {
                            print("ready to used the provider");

                            !context.read<CartNotifier>().inCart(
                                    cartProduct) // this returns true or false.
                                ? cartNotifier.addProduct(cartProduct)
                                : cartNotifier.deleteProduct(cartProduct);

                            print(cartNotifier.cartList.length);
                            print(context.read<CartNotifier>().cartList);
                            print(context
                                .read<CartNotifier>()
                                .inCart(cartProduct));
                          },
                        ),
                        !cartNotifier.inCart(cartProduct)
                            ? Increamentor(context)
                            : const CartCountIcon()
                      ],
                    ),
                  ),
                  SizedBox(
                    height: getPercentageHeight(1),
                  ),
                  displayDivider(
                      context, "Description", true, true, "More info"),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: getPercentageWidth(5),
                        vertical: getPercentageHeight(1)),
                    margin: EdgeInsets.only(bottom: getPercentageHeight(1)),
                    width: getPercentageWidth(100),
                    child: Text(
                      // "The description of the product is dropped here to aid the customers make posible descisions on what they are upto purchasing The description of the product is dropped here to aid the customers make posible descisions on what they are upto purchasing",
                      widget.product.discription,
                      style: productCatStyle(context),
                    ),
                  ),
                  displayDivider(context, "Sugestions", true, true, ""),
                  Container(
                      height: getPercentageWidth(20) + 3,
                      padding: EdgeInsets.symmetric(
                          horizontal: getPercentageWidth(5)),
                      //color: Colors.amber,
                      child: ListView.builder(
                          itemCount: sugestionsList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) {
                            return suggestionCard(
                              suggestedItem: sugestionsList[index],
                            );
                          })),
                  SizedBox(
                    height: getPercentageHeight(1),
                  )
                ],
              ),
            )),
            Container(
              height: getPercentageHeight(14),
              color: Theme.of(context).backgroundColor,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                    horizontal: getPercentageWidth(5),
                    vertical: getPercentageWidth(6)),
                child: CheckoutHolder(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container Increamentor(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BtnSquare(
            primary: false,
            action: () {
              setState(() {
                itemCount = itemCount > 1 ? itemCount - 1 : itemCount;
              });
            },
            choiceIcon: Icons.remove,
          ),
          Container(
            width: 50,
            height: 28,
            decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
            child: Center(
              child: Text(itemCount.toString()),
            ),
          ),
          BtnSquare(
            action: () {
              setState(() {
                itemCount = itemCount < widget.product.quantity
                    ? itemCount + 1
                    : itemCount;
              });
            },
            choiceIcon: Icons.add,
          )
        ],
      ),
    );
  }
}

class suggestionCard extends StatelessWidget {
  const suggestionCard({
    Key? key,
    required this.suggestedItem,
  }) : super(key: key);

  final ProductModel suggestedItem;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ProductDetailScreen(product: suggestedItem);
      })),
      child: Padding(
        padding: EdgeInsets.only(right: getPercentageWidth(4)),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: getPercentageWidth(2)),
              width: getPercentageWidth(20),
              height: getPercentageWidth(20),
              decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      width: 1.0, color: Theme.of(context).hintColor)),
              child: Image(
                image: NetworkImage(suggestedItem.image),
              ),
            ),
            Positioned(
                bottom: 10,
                child: Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: getPercentageWidth(2)),
                    decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            width: 1.0, color: Theme.of(context).hintColor)),
                    child: Row(
                      children: [
                        Container(
                          width: getPercentageWidth(8),
                          child: Text(
                            suggestedItem.product,
                            overflow: TextOverflow.ellipsis,
                            style: productCatStyle(context, size: 10),
                          ),
                        ),
                        Text(suggestedItem.price.toString(),
                            style: mainPriceStyle(context, size: 10))
                      ],
                    )))
          ],
        ),
      ),
    );
  }
}
