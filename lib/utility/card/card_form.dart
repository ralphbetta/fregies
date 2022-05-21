import 'package:flutter/material.dart';
import 'package:fregies/constants/dimmensions.dart';
import 'package:fregies/models/card_model.dart';
import 'package:fregies/provider/card_provider.dart';
import 'package:fregies/screen/checkout/chechout_screen.dart';
import 'package:fregies/screen/checkout/components/body.dart';
import 'package:fregies/screen/checkout/components/card_switch.dart';
import 'package:fregies/utility/card/card_utility.dart';
import 'package:fregies/utility/card/constant.dart';
import 'package:fregies/widgets/alertBox/alert_box.dart';
import 'package:fregies/widgets/custom_input/custome_input.dart';
import 'package:fregies/widgets/square_btn.dart';
import 'package:fregies/widgets/text_btn.dart';
import 'package:provider/src/provider.dart';

Future<void> showCardDialog(BuildContext context, Widget navigation) async {
  return showGeneralDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    barrierLabel: "Barrier",
    transitionDuration: const Duration(milliseconds: 700),
    //  pageBuilder: (BuildContext context, Animation<double> animation,
    //     Animation<double> secondaryAnimation) {},
    pageBuilder: (_, __, ___) {
      return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Center(child: Text("Add Credit Card")),
            BtnSquare(
                action: () {
                  Navigator.pop(context);
                },
                primary: false,
                choiceIcon: Icons.cancel)
          ],
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              const AddCardLabel(
                title: "Card Number",
              ),
              CustomTextInput(
                hintText: "XXXX XXXX XXXX XXXX",
                keyType: TextInputType.number,
                controller: cardNumber,
                image: "assets/icons/visa-logo.png",
                formatter: cardNumberFormatter,
                maxLength: 19,
              ),
              const SizedBox(
                height: 10,
              ),
              const AddCardLabel(
                title: "Card Holder",
              ),
              CustomTextInput(
                hintText: "John Doe",
                controller: cardHolder,
                image: "",
                formatter: nameFormatter,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const AddCardLabel(
                          title: "Expiry Date",
                        ),
                        CustomTextInput(
                          hintText: "12/23",
                          maxLength: 5,
                          controller: expiryDate,
                          keyType: TextInputType.number,
                          image: "",
                          formatter: expiryDateFormatter,
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: Container()),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AddCardLabel(
                          title: "CVV",
                        ),
                        CustomTextInput(
                          hintText: "1**",
                          controller: CVV,
                          image: "",
                          visibility: true,
                          keyType: TextInputType.number,
                          maxLength: 3,
                          formatter: cvvFormatter,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: const [
                  SaveCardSwitch(),
                  AddCardLabel(
                    title: "Save this card",
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              //i am here
              TextBtn(
                  vertical: 3,
                  horizontal: 1,
                  action: () async {
                    print(CardUtils.getCardTypeName(defaultCardType));

                    print("All the card details");

                    var result = CardModel(
                        cardNumber: cardNumber.text,
                        cardHolder: cardHolder.text,
                        cardType: CardUtils.getCardTypeName(defaultCardType),
                        expiryDate: expiryDate.text,
                        cVV: CVV.text);

                    if (cardNumber.text.isNotEmpty &&
                        cardHolder.text.isNotEmpty &&
                        expiryDate.text.isNotEmpty &&
                        CVV.text.isNotEmpty) {
                      print("input complete");

                      if (defaultCardType == CardType.Invalid ||
                          defaultCardType == CardType.Others) {
                        // data complete with invalid card
                        popUp(context, "Error Alert",
                            <Widget>[Text("This card type is not accepted")]);
                      } else {
                        //"valid card and ready to submit"
                        cardDB.add(result);

                        await context.read<CardNotifier>().addCard(result);

                        Navigator.pop(context);
                      }
                    } else {
                      //"input incomplete";
                    }
                  },
                  title: "Done")
            ],
          ),
        ),
        actions: <Widget>[],
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      Tween<Offset> tween;
      if (animation.status == AnimationStatus.reverse) {
        tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
      } else {
        tween = Tween(begin: Offset(1, 0), end: Offset.zero);
      }

      return SlideTransition(
        position: tween.animate(animation),
        child: FadeTransition(
          opacity: animation,
          child: child,
        ),
      );
    },
  );
}

bool validInput() {
  if (cardNumber.text.isNotEmpty &&
      cardHolder.text.isNotEmpty &&
      expiryDate.text.isNotEmpty &&
      CVV.text.isNotEmpty) {
    return true;
  } else {
    return false;
  }
}

bool validCard() {
  if (defaultCardType == CardType.Invalid ||
      defaultCardType == CardType.Others) {
    return false;
  } else {
    return true;
  }
}
