import 'package:flutter/material.dart';
import 'package:fregies/models/product_model.dart';
import 'package:fregies/screen/product_details/components/body.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({Key? key, required this.product})
      : super(key: key);
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Body(product: product);
  }
}
