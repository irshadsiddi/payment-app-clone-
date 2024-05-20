import 'dart:js_interop';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:payment_app/otp.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  TextEditingController phonecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 134, 17, 129),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextField(
                controller: phonecontroller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: "Enter Phone Number",
                    suffixIcon: const Icon(Icons.phone),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                    )),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.verifyPhoneNumber(
                      verificationCompleted:
                          (PhoneAuthCredential credentials) {},
                      verificationFailed: (FirebaseAuthException ex) {},
                      codeSent: (String verificationid, int? resendtoken) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Otp(
                                      verificationid: '',
                                    )));
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {},
                      phoneNumber: phonecontroller.text.toString());
                },
                child: const Text("Verify Number"))
          ],
        ));
  }
}
