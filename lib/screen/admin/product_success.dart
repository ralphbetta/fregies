import 'package:flutter/material.dart';

class ProductSuccess extends StatelessWidget {
  const ProductSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: const [
            Image(image: AssetImage("assets/gif/screen-3.gif")),
            Text("Completed"),
          ],
        ),
      ),
    );
  }
}
