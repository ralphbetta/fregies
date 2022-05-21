import 'package:flutter/material.dart';

class CardModel {
  late String cardNumber;
  late String cardType;
  late String cardHolder;
  late String expiryDate;
  late String cVV;

  CardModel(
      {required this.cardNumber,
      required this.cardHolder,
      required this.cardType,
      required this.expiryDate,
      required this.cVV});

  //factory allows you to use return
  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      cardNumber: json['cardNumber'] as String,
      cardType: json['cardType'] as String,
      cardHolder: json['cardHolder'] as String,
      expiryDate: json['expiryDate'] as String,
      cVV: json['cVV'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cardNumber'] = this.cardNumber;
    data['cardType'] = this.cardType;
    data['cardHolder'] = this.cardHolder;
    data['cardHolder'] = this.cardHolder;
    return data;
  }
}
