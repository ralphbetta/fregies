import 'package:flutter/material.dart';
import 'package:fregies/models/product_model.dart';
import 'package:fregies/screen/cart/components/body.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key, this.product}) : super(key: key);
  final ProductModel? product;

  @override
  Widget build(BuildContext context) {
    return Body();
  }
}
