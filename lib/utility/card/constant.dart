import 'package:flutter/material.dart';
import 'package:fregies/models/card_model.dart';

TextEditingController cardNumber = TextEditingController();
TextEditingController cardHolder = TextEditingController();
TextEditingController expiryDate = TextEditingController();
TextEditingController CVV = TextEditingController();

enum CardType {
  MasterCard,
  Visa,
  Verve,
  Others, // Any other card issuer
  Invalid // We'll use this when the card is invalid
}

CardType defaultCardType = CardType.Others;

List<CardModel> cardDB = [];

bool saveCardState = false;
