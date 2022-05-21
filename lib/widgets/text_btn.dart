import 'package:flutter/material.dart';
import 'package:fregies/constants/color.dart';
import 'package:fregies/constants/dimmensions.dart';

class TextBtn extends StatelessWidget {
  const TextBtn(
      {Key? key,
      required this.vertical,
      required this.horizontal,
      required this.title,
      this.action,
      this.load = false})
      : super(key: key);

  final int vertical;
  final int horizontal;
  final String title;
  final Function()? action;
  final bool load;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: action,
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: getPercentageWidth(vertical),
              horizontal: getPercentageWidth(horizontal)),
          decoration: BoxDecoration(
              color: lightPrimary, borderRadius: BorderRadius.circular(5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              load
                  ? Container(
                      margin: EdgeInsets.only(right: getPercentageWidth(2)),
                      width: getPercentageWidth(5),
                      height: getPercentageWidth(5),
                      child: const CircularProgressIndicator(
                        backgroundColor: white,
                        color: lightPrimary,
                        strokeWidth: 4,
                      ),
                    )
                  : Container(),
              Text(
                title,
                style: const TextStyle(color: white),
              )
            ],
          ),
        ));
  }
}



// Container(
//           padding: EdgeInsets.symmetric(
//               vertical: getPercentageWidth(vertical),
//               horizontal: getPercentageWidth(horizontal)),
//           decoration: BoxDecoration(
//               color: lightPrimary, borderRadius: BorderRadius.circular(5)),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               load
//                   ? SizedBox(
//                       width: getPercentageWidth(5),
//                       height: getPercentageWidth(5),
//                       child: const CircularProgressIndicator(
//                         backgroundColor: white,
//                         color: lightPrimary,
//                         strokeWidth: 4,
//                       ),
//                     )
//                   : Container(),
//               SizedBox(
//                 width: getPercentageWidth(10),
//               ),
//               Text(
//                 title,
//                 style: const TextStyle(color: white),
//               ),
//             ],
//           )),