import 'package:flutter/material.dart';

class editprofile extends StatefulWidget {
  const editprofile({super.key});

  @override
  State<editprofile> createState() => _editprofileState();
}

class _editprofileState extends State<editprofile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.purple[700],
      ),
      body: Column(
        children: [
          const Placeholder(
            fallbackHeight: 150,
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.purple[100],
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Icon(Icons.qr_code_rounded, color: Colors.purple[800]),
              ],
            ),
          ),
          Row(
            children: [Icon(Icons.account_circle_sharp)],
          ),
        ],
      ),
    );
  }
}
