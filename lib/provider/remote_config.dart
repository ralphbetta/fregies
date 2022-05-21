import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
//import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteState extends ChangeNotifier {
  RemoteState() {
    init();
    initConfig();
  }

  String _sendGridApi = "5828733e8emsh6ae2d070ec26136p157983jsn343b7a69aa59";
  String get sendGridApi => _sendGridApi;

  String _homePageCaption = "";
  String get homePageCaption => _homePageCaption;

  Future<void> init() async {
    await Firebase.initializeApp();
    notifyListeners();
  }

  Future<void> initConfig() async {
    final RemoteConfig _remoteConfig = RemoteConfig.instance;

    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 1),
        minimumFetchInterval: const Duration(seconds: 10)));

    _homePageCaption = _remoteConfig.getString("home-caption").isEmpty
        ? "Find your favourite groceries"
        : _remoteConfig.getString("home-caption");

    notifyListeners();
  }

  getString() async {
    final RemoteConfig _remoteConfig = RemoteConfig.instance;
    _homePageCaption = _remoteConfig.getString("home-caption").isEmpty
        ? "Find your favourite items"
        : _remoteConfig.getString("home-caption");
    notifyListeners();
  }
}
