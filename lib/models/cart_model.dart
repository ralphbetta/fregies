import 'package:flutter/material.dart';
import 'package:fregies/models/product_model.dart';

class CartModel {
  late int id;
  late ProductModel product;
  late int count;

  CartModel({required this.id, required this.product, required this.count});

  //factory allows you to use return
  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'] as int,
      product: json['product'] as ProductModel,
      count: json['count'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product'] = this.product;
    data['count'] = this.count;
    return data;
  }
}
