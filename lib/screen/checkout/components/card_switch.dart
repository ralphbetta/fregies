import 'package:flutter/material.dart';
import 'package:fregies/constants/color.dart';
import 'package:fregies/utility/card/constant.dart';

class SaveCardSwitch extends StatefulWidget {
  const SaveCardSwitch({
    Key? key,
  }) : super(key: key);

  @override
  State<SaveCardSwitch> createState() => _SaveCardSwitchState();
}

class _SaveCardSwitchState extends State<SaveCardSwitch> {
  @override
  Widget build(BuildContext context) {
    return Switch(
        onChanged: (bool newValue) {
          setState(() {
            saveCardState = newValue;
          });
        },
        value: saveCardState,
        activeColor: lightPrimary,
        inactiveThumbColor: Colors.white60,
        activeTrackColor: Color.fromRGBO(0, 0, 0, 0.08),
        inactiveTrackColor: Color.fromRGBO(0, 0, 0, 0.08));
  }
}
