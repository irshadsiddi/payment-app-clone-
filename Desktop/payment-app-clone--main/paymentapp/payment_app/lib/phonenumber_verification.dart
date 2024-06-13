import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:payment_app/otp.dart';

class Phonenumber extends StatefulWidget {
  const Phonenumber({Key? key}) : super(key: key);

  @override
  State<Phonenumber> createState() => _PhonenumberState();
}

class _PhonenumberState extends State<Phonenumber> {
  final TextEditingController countrycode = TextEditingController(text: "+91");
  final TextEditingController phonenumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/image copy.png'),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Phone Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 1),
              const Text(
                "Verify your phone number",
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 7),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        controller: countrycode,
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: phonenumber,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter your Phone Number"),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: countrycode.text + phonenumber.text,
                      verificationCompleted:
                          (PhoneAuthCredential credential) {},
                      verificationFailed: (FirebaseAuthException e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Verification failed: ${e.message}'),
                        ));
                      },
                      codeSent: (String verificationId, int? resendToken) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Otp(
                              verificationid: verificationId,
                            ),
                          ),
                        );
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {},
                    );
                  } catch (e) {
                    log(e.toString());
                  }
                },
                child: const Text("Verify"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
