import 'package:flutter/material.dart';
import 'package:fregies/constants/dimmensions.dart';
import 'package:fregies/constants/maps.dart';
import 'package:fregies/models/product_model.dart';
import 'package:fregies/widgets/product_card.dart';
import 'package:provider/src/provider.dart';

class TapProductDisplay extends StatelessWidget {
  const TapProductDisplay({
    Key? key,
    required this.category,
  }) : super(key: key);
  final String category;

  @override
  Widget build(BuildContext context) {
    getCat(String item) {
      List fruits = context
          .watch<List<ProductModel>>()
          .where((element) => element.category == item)
          .toList();
      return fruits;
    }

    return Container(
      // color: Colors.red,
      height: getPercentageHeight(24),
      width: getPercentageWidth(100),
      padding: EdgeInsets.symmetric(horizontal: getPercentageWidth(5)),
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 10.0,
              childAspectRatio: 3 / 3.5,
              crossAxisCount: 2),
          itemCount: getCat(category).length,
          itemBuilder: (_, index) {
            return allProductCard(getCat(category)[index], context);
          }),
    );
  }
}
