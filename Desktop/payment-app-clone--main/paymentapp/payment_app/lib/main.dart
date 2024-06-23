import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:payment_app/homepage.dart';
import 'package:payment_app/otp.dart';
import 'package:payment_app/phonenumber_verification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Check if a user is already verified his phone number
  User? user = FirebaseAuth.instance.currentUser;

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: user == null ? 'phonenumber_verification' : 'homepage',
    routes: {
      'phonenumber_verification': (context) => Phonenumber(),
      'otp': (context) => Otp(verificationid: '', phoneNumber: ''),
      'homepage': (context) => MyHomepage(),
    },
  ));
}
