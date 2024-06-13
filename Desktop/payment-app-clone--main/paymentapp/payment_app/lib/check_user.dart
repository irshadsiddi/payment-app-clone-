import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InitialScreen extends StatefulWidget {
  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  void initState() {
    super.initState();
    _checkUserDetails();
  }

  Future<void> _checkUserDetails() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (userDoc.exists) {
        Navigator.pushReplacementNamed(context, 'homepage');
      } else {
        Navigator.pushReplacementNamed(context, 'user_details');
      }
    } else {
      // this handles unauthenticated case
      Navigator.pushReplacementNamed(context, 'user_details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
