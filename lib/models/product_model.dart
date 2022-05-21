import 'package:flutter/material.dart';

enum productState {
  inCart,
  isFavorite,
}

class ProductModel {
  late int id;
  late String product;
  late String category;
  late double price;
  late double discountPrice;
  late bool favourite;
  late String image;
  late double rating;
  late int quantity;
  late String discription;
  late String unit;
  late String rate;
  late bool specialOffer;

  ProductModel(
      {required this.id,
      required this.product,
      required this.category,
      required this.price,
      required this.discountPrice,
      required this.favourite,
      required this.image,
      required this.rating,
      required this.quantity,
      required this.discription,
      required this.unit,
      required this.rate,
      required this.specialOffer});

  //factory allows you to use return
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json['id'] as int,
        product: json['product'] as String,
        category: json['category'] as String,
        price: json['price'] as double,
        discountPrice: json["discountPrice"] as double,
        favourite: json['favourite'] as bool,
        image: json['image'] as String,
        rating: json["rating"] as double,
        quantity: json['quantity'] as int,
        discription: json['discription'] as String,
        unit: json['unit'] as String,
        rate: json['rate'] as String,
        specialOffer: json["specialOffer"] as bool);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product'] = this.product;
    data['category'] = this.category;
    data['price'] = this.price;
    data['discountPrice'] = this.discountPrice;
    data['favourite'] = this.favourite;
    data['image'] = this.image;
    data['rating'] = this.rating;
    data['quantity'] = this.quantity;
    data['discription'] = this.discription;
    data['unit'] = this.unit;
    data['rate'] = this.rate;
    data['specialOffer'] = this.specialOffer;
    return data;
  }
}

//this is for firebase

class ProductMod {
  late int id;
  late String product;
  late String category;
  late double price;
  late double discountPrice;
  late bool favourite;
  late String image;
  late double rating;
  late int quantity;
  late String discription;
  late String unit;
  late String rate;
  late bool specialOffer;

  ProductMod(
      {required this.id,
      required this.product,
      required this.category,
      required this.price,
      required this.discountPrice,
      required this.favourite,
      required this.image,
      required this.rating,
      required this.quantity,
      required this.discription,
      required this.unit,
      required this.rate,
      required this.specialOffer});

  Map<String, dynamic> createMap() {
    return {
      "id": id,
      "product": product,
      "category": category,
      "price": price,
      "discountPrice": discountPrice,
      "favourite": favourite,
      "image": image,
      "rating": rating,
      "quantity": quantity,
      "discription": discription,
      "unit": unit,
      "rate": rate,
      "specialOffer": specialOffer,
      //"date": DateTime.now(),
    };
  }

  ProductMod.fromFirestore(Map<String, dynamic> firestoreMap)
      : id = firestoreMap['id'],
        product = firestoreMap['product'],
        price = firestoreMap['price'],
        category = firestoreMap['category'],
        discountPrice = firestoreMap['discountPrice'],
        favourite = firestoreMap['favourite'],
        image = firestoreMap['image'],
        rating = firestoreMap['rating'],
        quantity = firestoreMap['quantity'],
        discription = firestoreMap['discription'],
        unit = firestoreMap['unit'],
        rate = firestoreMap['rate'],
        specialOffer = firestoreMap['specialOffer'];
}
