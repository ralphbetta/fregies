import 'package:flutter/material.dart';

// 29ABE2 - username
// ED1C24 - identity
// 0071BC - phone
// FE9C42- rating
// F8F9FA- scaffoldbg
// 64BA02 - opacity 0.24 textinput
// 64BA02 - opacity 0.40
// 64BA02 - primaryColor

// const Color scaffoldBackgroundColorLight = Color(0xFFf2f2f2);
const Color scaffoldBackgroundColorLight = Color(0xFFF8F9FA);
const Color scaffoldBackgroundColorDark = Color(0xFF1E2C33);
const Color darkPrimary = Color(0xFF1A2238);
const Color lightPrimary = Color(0xFF64BA02);
const Color white = Color(0xffffffff);
const kTwitter = Color(0xFF3BA8DF);
const kFacebook = Color(0xFF3E74BA);
const kGoogle = Color(0xFFEE3324);
// const kUsername = Color(0xFF29ABE2);
// const kIdentity = Color(0xFFED1C24);
// const kPhone = Color(0xFF0071BC);

const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);

const kTextColor = Color(0xFF757575);
const kSecondaryTextColor = Color(0xFF979797);
const kNearBlack = Color(0xFF414042);
const kAnimationDuration = Duration(milliseconds: 200);

final kNotificationColorLight = white.withOpacity(0.1);
final kNotificationColorDark = Colors.black.withOpacity(0.2);
