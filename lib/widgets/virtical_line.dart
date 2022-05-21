import 'package:flutter/material.dart';

class VirticalLine extends StatelessWidget {
  const VirticalLine({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              right: BorderSide(
                  width: 0.8,
                  color: Theme.of(context).hintColor.withOpacity(0.2)))),
    );
  }
}
