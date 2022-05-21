import 'package:flutter/material.dart';
import 'package:fregies/constants/dimmensions.dart';
import 'package:fregies/constants/maps.dart';
import 'package:fregies/models/product_model.dart';
import 'package:fregies/widgets/product_card.dart';
import 'package:provider/src/provider.dart';

class FavouriteProductDisplay extends StatelessWidget {
  const FavouriteProductDisplay({
    Key? key,
    required this.category,
    required this.all,
  }) : super(key: key);
  final String category;
  final bool all;

  @override
  Widget build(BuildContext context) {
    List<ProductModel> fruits1 = context
        .watch<List<ProductModel>>()
        .toList()
        .where((element) => element.favourite == true)
        .toList();

    List fruits2 =
        fruits1.where((element) => element.category == category).toList();

    List fruits = all ? fruits1 : fruits2;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: getPercentageWidth(5)),
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 5.0,
              childAspectRatio: 3 / 3.5,
              crossAxisCount: 2),
          itemCount: fruits.length,
          itemBuilder: (_, index) {
            return allProductCard(fruits[index], context);
          }),
    );
  }
}
