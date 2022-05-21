import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:fregies/models/card_model.dart';

class CardNotifier extends ChangeNotifier {
  final List<CardModel> _cardList = [];
  int _id = 0;
  final double _accountBalance = 0;

  UnmodifiableListView<CardModel> get cardList =>
      UnmodifiableListView(_cardList);
  int get id => _id;
  double get accountBalance => _accountBalance;

  addCard(CardModel cardModel) async {
    _cardList.clear();
    _cardList.add(cardModel);
    //await SQLHelper.createItem(appointmentModel);
    notifyListeners();
  }

  deleteProduct(CardModel cardModel) async {
    _cardList
        .removeWhere((element) => element.cardNumber == cardModel.cardNumber);
    notifyListeners();
  }

  incrementId() {
    _id++;
  }
}
