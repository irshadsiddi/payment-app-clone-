import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:payment_app/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDetails extends StatefulWidget {
  final String phoneNumber;

  const UserDetails({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();

  @override
  void initState() {
    super.initState();
    mobileController.text = widget.phoneNumber;
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    super.dispose();
  }

  Future<void> saveUserDetails() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        // Check if the user already exists in Firestore
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        // If the user does not exist, set initial balance
        if (!userDoc.exists) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({
            'name': nameController.text.trim(),
            'email': emailController.text.trim(),
            'mobilenumber': mobileController.text.trim(),
            'balance': 10000, // Initial balance
          });
        } else {
          // If the user exists, update their details without changing the balance
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .update({
            'name': nameController.text.trim(),
            'email': emailController.text.trim(),
            'mobilenumber': mobileController.text.trim(),
          });
        }

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isProfileComplete', true);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyHomepage()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving user details: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Your Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Name field
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Enter your Name',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            // Email field
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: 'Enter your Email',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            // Mobile number field
            TextFormField(
              controller: mobileController,
              decoration: const InputDecoration(
                hintText: 'Enter your Mobile Number',
                border: OutlineInputBorder(),
              ),
              readOnly: true,
            ),

            const SizedBox(height: 20),

            // Save button
            ElevatedButton(
              onPressed: () async {
                if (nameController.text.isNotEmpty &&
                    emailController.text.isNotEmpty &&
                    mobileController.text.isNotEmpty) {
                  await saveUserDetails();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill all the fields')),
                  );
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
