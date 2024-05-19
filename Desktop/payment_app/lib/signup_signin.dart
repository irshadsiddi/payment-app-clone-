import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Color.fromARGB(255, 90, 21, 102),
        body: Column(
          children: <Widget>[
            Text("Get Started!!"),
          ],
        ));
  }
}
