import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:payment_app/user_details';
import 'package:pinput/pinput.dart';

class Otp extends StatefulWidget {
  final String verificationid;

  Otp({Key? key, required this.verificationid}) : super(key: key);

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final TextEditingController otpcontroller = TextEditingController();

  @override
  void dispose() {
    otpcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    ).copyWith(
      decoration: BoxDecoration(
        color: Color.fromRGBO(234, 239, 243, 1),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/image copy.png'),
              const Text(
                "Phone Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 1),
              const Text(
                "Verify your phone number",
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 5),
              Pinput(
                length: 6,
                controller: otpcontroller,
                defaultPinTheme: defaultPinTheme,
                showCursor: true,
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                      verificationId: widget.verificationid,
                      smsCode: otpcontroller.text.trim(),
                    );
                    await FirebaseAuth.instance
                        .signInWithCredential(credential);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => UserDetails()),
                    );
                  } catch (ex) {
                    log(ex.toString());
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Invalid OTP'),
                    ));
                  }
                },
                child: Text("Verify Phone Number"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, "phonenumber_verification");
                },
                child: Text("Edit Phone Number?"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
