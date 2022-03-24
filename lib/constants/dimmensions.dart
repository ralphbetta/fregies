import 'package:flutter/material.dart';
import 'package:fregies/config/size_config.dart';
import 'package:fregies/constants/color.dart';

const double kVertical = 10.0;
const double khorizonal = 5.0;
const double kRadius = 30.0;
const double bodyTextSize = 16.0;
const double mediumTextSize = 20.0;
const double largeTextSize = 26.0;
const double khorizonalPercent = 0.05;

double getPercentageHeight(int percentage) {
  return SizeConfig.screenHeight * percentage * 0.01;
}

double getPercentageWidth(int percentage) {
  return SizeConfig.screenWidth * percentage * 0.01;
}

const skipText = TextStyle(
    fontWeight: FontWeight.bold, fontSize: mediumTextSize, color: white);
