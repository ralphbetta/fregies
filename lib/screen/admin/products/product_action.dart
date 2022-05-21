import "package:flutter/material.dart";
import 'package:fregies/config/route_config.dart';
import 'package:fregies/constants/color.dart';
import 'package:fregies/constants/dimmensions.dart';
import 'package:fregies/constants/functions.dart';
import 'package:fregies/constants/maps.dart';
import 'package:fregies/constants/text_styles.dart';
import 'package:fregies/constants/values.dart';
import 'package:fregies/models/cart_model.dart';
import 'package:fregies/models/product_model.dart';
import 'package:fregies/models/user_model.dart';
import 'package:fregies/provider/cart_provider.dart';
import 'package:fregies/provider/product_provider.dart';
import 'package:fregies/provider/theme_notifier.dart';
import 'package:fregies/screen/admin/products/edit_screen.dart';
import 'package:fregies/screen/admin/products/products_screen.dart';
import 'package:fregies/screen/home/homescreen.dart';
import 'package:fregies/screen/product_details/product_detail_screen.dart';
import 'package:fregies/widgets/checkout_card.dart';
import 'package:fregies/widgets/square_btn.dart';
import 'package:fregies/widgets/text_btn.dart';
import 'package:provider/src/provider.dart';

class ProductAction extends StatefulWidget {
  const ProductAction({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductAction> createState() => _ProductActionState();
}

class _ProductActionState extends State<ProductAction> {
  @override
  Widget build(BuildContext context) {
    //CartNotifier cartNotifier = Provider.of<CartNotifier>(context);

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
          "All Products",
          style:
              TextStyle(color: Theme.of(context).appBarTheme.iconTheme!.color),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: context.watch<List<ProductModel>>().isNotEmpty
                    ? const CardListHolder()
                    : Center(
                        child: Text(
                          "You do not have any product",
                          style: productCatStyle(context),
                        ),
                      )),
          ],
        ),
      ),
    );
  }
}

class FetchedProduct extends StatefulWidget {
  const FetchedProduct({Key? key, required this.products, required this.index})
      : super(key: key);
  final ProductModel products;
  final int index;

  @override
  State<FetchedProduct> createState() => _FetchedProductState();
}

class _FetchedProductState extends State<FetchedProduct> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProductDetailScreen(product: widget.products);
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
                image: NetworkImage(widget.products.image),
              ),
            ),
            SizedBox(
              width: getPercentageWidth(4),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.products.product,
                  style: productNameStyle(),
                ),
                SizedBox(
                  height: getPercentageWidth(2),
                ),
                Row(
                  children: [
                    Text(
                      widget.products.unit + widget.products.price.toString(),
                      style: mainPriceStyle(context),
                    ),
                    Text(" / " + widget.products.rate)
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
                      reversibleNavigation(
                          context,
                          ProductEditScreen(
                              product: widget.products, index: widget.index));
                    },
                    choiceIcon: Icons.edit,
                  ),
                  const SizedBox(
                    width: 30,
                    height: 25,
                  ),
                  BtnSquare(
                    action: () {
                      print("getting ready to delete");
                      print(widget.index);
                      context
                          .read<ProductNotifier>()
                          .deleteProduct(widget.index);
                    },
                    choiceIcon: Icons.delete_forever,
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
    return Container(
        child: ListView.builder(
            itemCount: context.watch<List<ProductModel>>().length,
            itemBuilder: (_, index) {
              return FetchedProduct(
                  products: context.watch<List<ProductModel>>()[index],
                  index: index);
            }));
  }
}
