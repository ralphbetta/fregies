import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:fregies/models/user_model.dart';

class UserNotifier extends ChangeNotifier {
  final List<UserModel> _userDB = [];
  bool _isLoggedIn = false;
  bool _keepMeLoggedIN = false;

  UnmodifiableListView<UserModel> get cardList => UnmodifiableListView(_userDB);
  bool get isLoggedIn => _isLoggedIn;
  bool get keepMeLoggedIN => _isLoggedIn;

  addAddress(String address) async {
    _userDB.first.location = address;
    notifyListeners();
  }

  addUser(UserModel userModel) {
    _userDB.add(userModel);
    notifyListeners();
  }

  logIn() {
    _isLoggedIn = true;
    notifyListeners();
  }

  logOutAndKeep() {
    _isLoggedIn = false;
    notifyListeners();
  }

  logOut() {
    _isLoggedIn = false;
    _userDB.clear();
    notifyListeners();
  }
}
