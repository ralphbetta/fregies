import 'package:flutter/material.dart';
import 'package:fregies/constants/color.dart';
import 'package:fregies/constants/dimmensions.dart';
import 'package:fregies/constants/maps.dart';
import 'package:fregies/provider/product_provider.dart';
import 'package:provider/src/provider.dart';

class AdvertIndicator extends StatelessWidget {
  final bool active;

  const AdvertIndicator({
    Key? key,
    required this.active,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: CircleAvatar(
        radius: 5,
        backgroundColor: active ? lightPrimary : lightPrimary.withOpacity(0.3),
      ),
    );
  }
}

class AdvertBanners extends StatelessWidget {
  final int index;
  const AdvertBanners({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(context.read<ProductNotifier>().productList.length);
        context.read<ProductNotifier>().fetchDoc();
      },
      child: Container(
        width: getPercentageWidth(90),
        margin: EdgeInsets.only(
            left: getPercentageWidth(5), right: getPercentageWidth(5)),
        height: 120,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
                image: AssetImage(adverts[index]), fit: BoxFit.fitWidth)),
      ),
    );
  }
}
