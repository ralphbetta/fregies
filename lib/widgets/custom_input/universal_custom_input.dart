import 'package:flutter/material.dart';
import 'package:fregies/constants/dimmensions.dart';
import 'package:fregies/constants/text_styles.dart';
import 'package:fregies/provider/application_state.dart';

customFormField(BuildContext context, TextEditingController pen, updateState,
    hintText, maxLine) {
  return Container(
    height: getPercentageHeight(5) * maxLine,
    padding: EdgeInsets.symmetric(horizontal: getPercentageWidth(2)),
    margin: EdgeInsets.only(bottom: getPercentageHeight(1)),
    decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(10)),
    child: SizedBox(
      child: TextFormField(
        controller: pen,
        keyboardType: updateState == ApplicationUpdateState.phone
            ? TextInputType.phone
            : maxLine > 1
                ? TextInputType.multiline
                : TextInputType.text,

        maxLines: maxLine,
        //use this instead of maxlength
        onChanged: (value) {},
        decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
            hintStyle: productNameStyle()),
      ),
    ),
  );
}

// customEditFormField(
//     BuildContext context, String digitInitial, updateState, hintText, maxLine) {
//   return CustomEditFormField();
// }

// class CustomEditFormField extends StatefulWidget {
//   CustomEditFormField({
//     Key? key,
//     required this.maxLine,
//     required this.updateState,
//     required this.digitInitial,
//     required this.hintText,
//   }) : super(key: key);
//   final int maxLine;
//   final ApplicationUpdateState updateState;
//   String digitInitial;
//   final String hintText;

//   @override
//   State<CustomEditFormField> createState() => _CustomEditFormFieldState();
// }

// class _CustomEditFormFieldState extends State<CustomEditFormField> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: getPercentageHeight(5) * widget.maxLine,
//       padding: EdgeInsets.symmetric(horizontal: getPercentageWidth(2)),
//       margin: EdgeInsets.only(bottom: getPercentageHeight(1)),
//       decoration: BoxDecoration(
//           color: Theme.of(context).backgroundColor,
//           borderRadius: BorderRadius.circular(10)),
//       child: SizedBox(
//         child: TextFormField(
//           initialValue: widget.digitInitial,
//           keyboardType: widget.updateState == ApplicationUpdateState.phone
//               ? TextInputType.phone
//               : widget.maxLine > 1
//                   ? TextInputType.multiline
//                   : TextInputType.text,

//           maxLines: widget.maxLine,
//           //use this instead of maxlength
//           onChanged: (value) {
//             setState(() {
//               widget.digitInitial = value;
//               print(widget.digitInitial);
//             });
//           },
//           decoration: InputDecoration(
//               border: InputBorder.none,
//               hintText: widget.hintText,
//               hintStyle: productNameStyle()),
//         ),
//       ),
//     );
//   }
// }
