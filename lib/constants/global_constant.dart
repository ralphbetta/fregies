import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

DateTime today = DateTime.now();
DateFormat formatter = DateFormat('yyyy-MM-dd');
String currentDate_1 = formatter.format(today); //yyyy-mm-dd format
String currentDate_2 = DateFormat.yMMMd().format(today);
String currentTime_1 = DateFormat.jm().format(today);



//TextEditingController emailController = TextEditingController();
