import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:payment_app/otp.dart';

class Phonenumber extends StatefulWidget {
  const Phonenumber({super.key});

  @override
  State<Phonenumber> createState() => _PhonenumberState();
}

class _PhonenumberState extends State<Phonenumber> {
  get assets => null;

  TextEditingController countrycode = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    countrycode.text = "+91";
    super.initState();
  }

  TextEditingController phonenumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: avoid_unnecessary_containers
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/image copy.png'),
              const Text(
                "Phone Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 1,
              ),
              const Text(
                "verify your phone number",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 8,
                    ),
                    SizedBox(
                      width: 40,
                      /* child: TextField(
                        controller: countrycode,
                        decoration: InputDecoration(border: InputBorder.none),
                      ),*/
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    /*Text(
                      "|",
                      style: TextStyle(fontSize: 33, color: Colors.black12),
                    ),*/
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: TextField(
                        controller: phonenumber,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter your Phone Number"),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    // newly added
                    FirebaseAuth.instance.verifyPhoneNumber(
                        verificationCompleted:
                            (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException ex) {},
                        codeSent: (String verificationid, int? resendtoken) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Otp(
                                        verificationid: 'verificationid',
                                      )));
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {},
                        phoneNumber: phonenumber.text.toString());
                    Navigator.pushNamed(context, "otp");
                    // newly added
                  },
                  child: Text("verify")),
            ],
          ),
        ),
      ),
    );
  }
}
