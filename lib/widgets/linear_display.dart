import 'package:flutter/material.dart';
import 'package:fregies/constants/dimmensions.dart';
import 'package:fregies/constants/maps.dart';
import 'package:fregies/models/product_model.dart';
import 'package:fregies/provider/product_provider.dart';
import 'package:fregies/widgets/product_card.dart';
import 'package:provider/src/provider.dart';

class LinearProductDisplay extends StatelessWidget {
  const LinearProductDisplay({
    Key? key,
    required this.sort,
  }) : super(key: key);

  final String sort;

  @override
  Widget build(BuildContext context) {
    // List groceries =
    //     productDB.where((element) => element.category == sort).toList();

    List sortedGroceries = context
        .watch<List<ProductModel>>()
        .where((element) => element.category == sort)
        .toList();

    List groceries = context.watch<List<ProductModel>>();

    // List pen = context.watch<ProductNotifier>().productList.isNotEmpty
    //     ? context
    //         .watch<ProductNotifier>()
    //         .productList
    //         .where((element) => element['category'] == 'Others')
    //         .toList()
    //     : [];

    // print("this is pen");
    // print(pen);

    return Container(
      //color: Colors.red,
      height: getPercentageHeight(24),
      width: getPercentageWidth(100),
      padding: EdgeInsets.symmetric(horizontal: getPercentageWidth(5)),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: sort.isEmpty ? groceries.length : sortedGroceries.length,
          itemBuilder: (_, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: sort.isEmpty
                  ? allProductCard(groceries[index], context)
                  : allProductCard(sortedGroceries[index], context),
            );
          }),
    );
  }
}
