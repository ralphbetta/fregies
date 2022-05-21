import 'package:flutter/material.dart';

enum UserLoginState {
  loggedOut,
  emailAddress,
  register,
  password,
  loggedIn,
}

class UserModel {
  late String email;
  late String? username;
  late String password;
  late String? location;

  UserModel({
    required this.email,
    this.username,
    required this.password,
    this.location,
  });

  //factory allows you to use return
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      location: json['location'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['username'] = this.username;
    data['password'] = this.password;
    data['location'] = this.location;
    return data;
  }
}
