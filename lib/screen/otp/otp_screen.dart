import 'package:flutter/material.dart';
import 'package:fregies/models/user_model.dart';
import 'package:fregies/screen/otp/components/body.dart';

class OTPScree extends StatelessWidget {
  const OTPScree({Key? key, required this.user, required this.otp})
      : super(key: key);
  final UserModel user;
  final String otp;

  @override
  Widget build(BuildContext context) {
    return Body(
      user: user,
      otp: otp,
    );
  }
}
