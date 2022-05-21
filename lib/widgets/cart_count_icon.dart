import 'package:flutter/material.dart';
import 'package:fregies/constants/color.dart';
import 'package:fregies/provider/cart_provider.dart';
import 'package:fregies/screen/cart/cart_screen.dart';
import 'package:provider/src/provider.dart';

class CartCountIcon extends StatelessWidget {
  const CartCountIcon({Key? key, this.primary = true}) : super(key: key);
  final bool primary;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          icon: const Icon(
            Icons.shopping_cart_outlined,
            size: 30,
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const CartScreen(
                  // product: {},
                  );
            }));
          },
        ),
        Positioned(
          right: 5,
          child: CircleAvatar(
            backgroundColor: primary ? lightPrimary : white,
            radius: 8,
            child: Text(
              context.watch<CartNotifier>().cartList.length.toString(),
              style: TextStyle(
                  color: !primary ? lightPrimary : white, fontSize: 10),
            ),
          ),
        )
      ],
    );
  }
}
