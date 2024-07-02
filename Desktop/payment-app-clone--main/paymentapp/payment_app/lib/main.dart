import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:payment_app/homepage.dart';
import 'package:payment_app/otp.dart';
import 'package:payment_app/phonenumber_verification.dart';
import 'package:payment_app/user_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  bool isProfileComplete = prefs.getBool('isProfileComplete') ?? false;

  String initialRoute;
  if (isLoggedIn) {
    initialRoute = isProfileComplete ? 'homepage' : 'user_details';
  } else {
    initialRoute = 'phonenumber_verification';
  }

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      routes: {
        'phonenumber_verification': (context) => Phonenumber(),
        'otp': (context) => Otp(verificationid: '', phoneNumber: ''),
        'homepage': (context) => MyHomepage(),
        'user_details': (context) => UserDetails(phoneNumber: ''),
      },
    ),
  );
}
