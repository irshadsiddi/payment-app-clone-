import 'package:flutter/material.dart';
import 'package:payment_app/otp.dart';

import 'package:payment_app/phonenumber_verification.dart';
//import 'package:payment_app/phonenumber_verification.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'phonenumber_verification',
    routes: {
      'phonenumber_verification': (context) => Phonenumber(),
      'otp': (context) => Otp(),
    },
    // home: Phonenumber(),
  ));
}
