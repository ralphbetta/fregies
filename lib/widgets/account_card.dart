import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fregies/constants/color.dart';
import 'package:fregies/constants/dimmensions.dart';
import 'package:fregies/constants/text_styles.dart';
import 'package:fregies/provider/application_state.dart';
import 'package:fregies/provider/theme_notifier.dart';
import 'package:fregies/screen/checkout/chechout_screen.dart';
import 'package:fregies/utility/card/card_form.dart';
import 'package:fregies/widgets/alertBox/alert_box.dart';
import 'package:fregies/widgets/square_btn.dart';
import 'package:fregies/widgets/text_btn.dart';
import 'package:provider/src/provider.dart';

class AccountCard extends StatelessWidget {
  const AccountCard({
    Key? key,
    required this.ccolor,
    required this.ctitle,
    required this.ccaption,
    required this.cicon,
    required this.updateState,
    required this.hintText,
  }) : super(key: key);

  final Color ccolor;
  final String ctitle;
  final String ccaption;
  final IconData cicon;
  final String hintText;
  final ApplicationUpdateState updateState;

  @override
  Widget build(BuildContext context) {
    TextEditingController editController = TextEditingController();
    return Container(
      width: double.infinity,
      height: getPercentageHeight(9),
      margin: EdgeInsets.only(
          left: getPercentageWidth(5),
          right: getPercentageWidth(5),
          top: getPercentageWidth(3)),
      padding: EdgeInsets.symmetric(
          horizontal: getPercentageWidth(3), vertical: getPercentageWidth(3)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).backgroundColor,
          boxShadow: [
            BoxShadow(
              color: ThemeClass.themeNotifier.value == ThemeMode.light
                  ? Color(0xFF414042).withOpacity(0.1)
                  : Colors.transparent,
              blurRadius: 5,
              spreadRadius: 1.0,
            )
          ]),
      child: Row(children: [
        Container(
          width: getPercentageWidth(10),
          height: getPercentageWidth(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: ccolor.withOpacity(0.3)),
          child: Icon(
            cicon,
            color: ccolor,
          ),
        ),
        SizedBox(
          width: getPercentageWidth(5),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              ctitle,
              style: productNameStyle(size: 16),
            ),
            SizedBox(
              height: getPercentageWidth(1),
            ),
            Text(
              ccaption,
              style: productCatStyle(context, size: 12),
            )
          ],
        ),
        Expanded(child: Container()),
        !ccaption.contains("pending")
            ? IconButton(
                icon: const Icon(
                  Icons.check_rounded,
                ),
                color: lightPrimary,
                onPressed: () {
                  popUp(context, "Update $ctitle",
                      <Widget>[newMethod(context, editController)]);
                },
              )
            : IconButton(
                onPressed: () {
                  print("ready to update");
                  popUp(context, "Update $ctitle",
                      <Widget>[newMethod(context, editController)]);
                },
                icon: const Icon(Icons.border_color_rounded))
      ]),
    );
  }

  newMethod(BuildContext context, TextEditingController pen) {
    return Column(
      children: [
        Container(
          height: getPercentageHeight(5),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 1, color: Theme.of(context).hintColor))),
          child: TextFormField(
            controller: pen,
            keyboardType: updateState == ApplicationUpdateState.phone
                ? TextInputType.phone
                : TextInputType.text,
            //use this instead of maxlength
            onChanged: (value) {},
            decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                hintStyle: productNameStyle()),
          ),
        ),
        SizedBox(
          height: getPercentageHeight(3),
        ),
        TextBtn(
          vertical: 2,
          horizontal: 10,
          title: "Update",
          action: () {
            print(pen.text);
            print(updateState);
            _processUpdate(updateState, context, pen);

            Navigator.pop(context);
          },
        )
      ],
    );
  }
}

void _processUpdate(ApplicationUpdateState updateState, BuildContext context,
    TextEditingController pen) {
  if (updateState == ApplicationUpdateState.email) {
    context.read<ApplicationState>().updateEmail(pen.text, (e) {
      print(e);
    });
  } else if (updateState == ApplicationUpdateState.phone) {
    //PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode)()
    // context.read<ApplicationState>().verifyPhoneNumber(pen.text, (e) {
    //   print(e);
    // });
    context.read<ApplicationState>().updateTempNumber(pen.text);
  } else if (updateState == ApplicationUpdateState.username) {
    print("it's here");
    context.read<ApplicationState>().UpdateUsename(pen.text, (e) {
      print(e);
    });
  }
}
