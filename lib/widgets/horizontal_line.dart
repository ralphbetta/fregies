import 'package:flutter/material.dart';

class horizontalLine extends StatelessWidget {
  const horizontalLine({
    Key? key,
    this.topMargin = 0,
    this.bottomMargin = 0,
  }) : super(key: key);
  final double topMargin;
  final double bottomMargin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: topMargin, bottom: bottomMargin),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  width: 1,
                  color: Theme.of(context).hintColor.withOpacity(0.2)))),
    );
  }
}
