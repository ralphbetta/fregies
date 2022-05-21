import 'package:fregies/utility/card/constant.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CardUtils {
  static String getCardIcon(CardType cardType) {
    String img = "";
    switch (cardType) {
      case CardType.MasterCard:
        img = 'mastercard.png';
        break;
      case CardType.Visa:
        img = 'visa-logo.png';
        break;
      case CardType.Verve:
        img = 'verve.png';
        break;
      case CardType.Others:
        img = 'card-dark.png';
        break;
      case CardType.Invalid:
        img = 'card.png';
        break;
    }

    String widget;
    if (img.isNotEmpty) {
      widget = "assets/icons/$img";
    } else {
      widget = "assets/icons/card-dark.png";
    }
    return widget;
  }

  static CardType getCardTypeFrmNumber(String input) {
    CardType cardType;
    if (input.startsWith(RegExp(
        r'((5[1-5])|(222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720))'))) {
      cardType = CardType.MasterCard;
    } else if (input.startsWith(RegExp(r'[4]'))) {
      cardType = CardType.Visa;
    } else if (input.startsWith(RegExp(r'((506(0|1))|(507(8|9))|(6500))'))) {
      cardType = CardType.Verve;
    } else if (input.length <= 8) {
      cardType = CardType.Others;
    } else {
      cardType = CardType.Invalid;
    }
    return cardType;
  }

  static String getCardTypeName(CardType input) {
    String card;
    if (input == CardType.MasterCard) {
      card = "master";
    } else if (input == CardType.Visa) {
      card = "visa";
    } else if (input == CardType.Verve) {
      card = "verve";
    } else if (input == CardType.Others) {
      card = "others";
    } else {
      card = "invalid";
    }

    return card;
  }
}

var maskFormatter = MaskTextInputFormatter(
    mask: '+# (###) ###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy);

var cardNumberFormatter = MaskTextInputFormatter(
    mask: '#### #### #### ####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy);

var expiryDateFormatter = MaskTextInputFormatter(
    mask: '##/##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy);

var nameFormatter = MaskTextInputFormatter();

var cvvFormatter = MaskTextInputFormatter();
