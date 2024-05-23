/*import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:payment_app/otp.dart';

import 'package:payment_app/phonenumber_verification.dart';
//import 'package:payment_app/phonenumber_verification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'phonenumber_verification',
    routes: {
      'phonenumber_verification': (context) => Phonenumber(),
      'otp': (context) => Otp(
            verificationid: 'verificationid',
          ),
    },
    // home: Phonenumber(),
  ));
}*/
// gpt checking
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:payment_app/otp.dart';
import 'package:payment_app/phonenumber_verification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'phonenumber_verification',
    routes: {
      'phonenumber_verification': (context) => Phonenumber(),
      'otp': (context) => Otp(
            verificationid: '', // This will be set dynamically
          ),
    },
  ));
}
