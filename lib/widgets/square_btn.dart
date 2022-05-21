import 'package:flutter/material.dart';
import 'package:fregies/constants/color.dart';

class BtnSquare extends StatelessWidget {
  final double? size;
  final Function() action;
  final IconData choiceIcon;
  final bool primary;
  final bool load;
  const BtnSquare({
    Key? key,
    this.size,
    required this.action,
    this.load = false,
    required this.choiceIcon,
    this.primary = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        width: size ?? 30,
        height: size ?? 30,
        padding: load ? EdgeInsets.all(10) : EdgeInsets.all(0),
        child: load
            ? const CircularProgressIndicator(
                backgroundColor: white,
                color: lightPrimary,
                strokeWidth: 4,
              )
            : Icon(
                choiceIcon,
                color: primary ? white : lightPrimary,
                size: 25,
              ),
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: lightPrimary),
          color: primary ? lightPrimary : Colors.transparent,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}

class BtnSquareError extends StatelessWidget {
  final double? size;
  final Function() action;
  final IconData choiceIcon;
  final bool primary;
  const BtnSquareError({
    Key? key,
    this.size,
    required this.action,
    required this.choiceIcon,
    this.primary = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        width: size ?? 30,
        height: size ?? 30,
        child: Icon(
          choiceIcon,
          color: primary ? white : kGoogle,
          size: 20,
        ),
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: kGoogle),
          color: primary ? lightPrimary : Colors.transparent,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
