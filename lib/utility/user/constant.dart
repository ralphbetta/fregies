import 'package:flutter/material.dart';
import 'package:fregies/models/user_model.dart';

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController password2Controller = TextEditingController();

enum User {
  isLogged,
  notLogged,
}

//User userState = User.notLogged;

bool userLoginState = true;

List<UserModel> userDB = [
  UserModel(
      email: "user1@gmail.com",
      username: "Williams Mark",
      password: "12345",
      location: "Williams Lane")
];
bool keepMeLoggedIn = false;

class LoginState {
  bool loggedIn = false;
}
