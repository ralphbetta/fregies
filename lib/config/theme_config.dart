import 'package:flutter/material.dart';
import 'package:fregies/provider/theme_notifier.dart';

class ThemeConfig {
  void switchTheme() {
    ThemeClass.themeNotifier.value =
        ThemeClass.themeNotifier.value == ThemeMode.dark
            ? ThemeMode.light
            : ThemeMode.dark;
  }
}
