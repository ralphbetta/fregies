import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fregies/constants/dimmensions.dart';
import 'package:fregies/constants/text_styles.dart';
import 'package:fregies/utility/card/card_utility.dart';
import 'package:fregies/utility/card/constant.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CustomTextInput extends StatefulWidget {
  const CustomTextInput({
    Key? key,
    required this.hintText,
    required this.controller,
    this.visibility = false,
    this.keyType = TextInputType.text,
    this.maxLength,
    required this.image,
    required this.formatter,
  }) : super(key: key);

  final String hintText;
  final TextEditingController controller;
  final String image;
  final bool visibility;
  final int? maxLength; //maxlenght for card is 19
  final TextInputType keyType;
  final MaskTextInputFormatter formatter;

  @override
  State<CustomTextInput> createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<CustomTextInput> {
  //late CardType kCardType;

  void _getCardTypeFrmNumber() {
    CardType cardType =
        CardUtils.getCardTypeFrmNumber(widget.formatter.getUnmaskedText());
    print("this is where we update card type");
    setState(() {
      defaultCardType = cardType;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getPercentageHeight(5),
      decoration: BoxDecoration(
          border: Border(
              bottom:
                  BorderSide(width: 1, color: Theme.of(context).hintColor))),
      child: Row(
        children: [
          Expanded(
              child: SizedBox(
            child: TextFormField(
              obscureText: widget.visibility,
              controller: widget.controller,
              keyboardType: widget.keyType,
              inputFormatters: [
                //LengthLimitingTextInputFormatter(widget.maxLength),
                //FilteringTextInputFormatter(filterPattern, allow: allow)
                LengthLimitingTextInputFormatter(widget.maxLength),
                widget.formatter,
                //CardNumberInputFormatter(),
              ], //use this instead of maxlength
              onChanged: (value) {
                _getCardTypeFrmNumber();

                if (widget.controller == cardNumberFormatter) {
                  print("handling card number to obtain card");
                }
                // print(maskFormatter.getMaskedText());
                // print(maskFormatter.getUnmaskedText());
              },
              decoration: InputDecoration(
                  hintText: widget.hintText,
                  border: InputBorder.none,
                  hintStyle: productNameStyle()),
            ),
          )),
          widget.image.isNotEmpty
              ? SizedBox(
                  width: getPercentageWidth(
                    10,
                  ),
                  child: Image(
                      image:
                          AssetImage(CardUtils.getCardIcon(defaultCardType))),
                )
              : Container()
        ],
      ),
    );
  }
}
