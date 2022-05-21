import 'dart:collection';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:fregies/models/cart_model.dart';
import 'package:fregies/models/product_model.dart';

class CartNotifier extends ChangeNotifier {
  final List<CartModel> _cartList = [];
  int _id = 0;
  double _totalAmmount = 0;

  UnmodifiableListView<CartModel> get cartList =>
      UnmodifiableListView(_cartList);
  int get id => _id;
  double get totalAmmount => _totalAmmount;

  addProduct(CartModel cartModel) async {
    _cartList.add(cartModel);
    //await SQLHelper.createItem(appointmentModel);
    getTotalAmmount();
    notifyListeners();
    print("added");
  }

  getTotalAmmount() async {
    _totalAmmount = 0;
    for (var i = 0; i < _cartList.length; i++) {
      _totalAmmount += _cartList[i].product.price * _cartList[i].count;
    }
    notifyListeners();
  }

  deleteProduct(CartModel cartModel) async {
    _cartList.removeWhere((element) => element.product == cartModel.product);
    getTotalAmmount();
    notifyListeners();
    print("removed " + cartModel.product.product);
  }

  clearCart() async {
    _cartList.clear();
    await getTotalAmmount();
    notifyListeners();
  }

  increaseQty(CartModel cartModel) async {
    var holder = _cartList.where((element) => element == cartModel).first;

    _cartList.where((element) => element == cartModel).first.count =
        holder.count < holder.product.quantity
            ? holder.count + 1
            : holder.count;
    getTotalAmmount();
    notifyListeners();
  }

  decreaseQty(CartModel cartModel) async {
    var holder = _cartList.where((element) => element == cartModel).first;
    _cartList.where((element) => element == cartModel).first.count =
        holder.count > 1 ? holder.count - 1 : holder.count;

    getTotalAmmount();
    notifyListeners();
  }

  inCart(CartModel productModel) {
    List pro = _cartList
        .where((element) => element.product == productModel.product)
        .toList();
    if (pro.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  incrementId() {
    _id++;
  }
}
