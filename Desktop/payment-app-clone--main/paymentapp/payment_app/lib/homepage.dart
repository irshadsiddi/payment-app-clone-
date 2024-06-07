import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:payment_app/edit_profile.dart';
import 'package:payment_app/qr_scanner.dart';
//import 'package:payment_app/phonenumber_verification.dart';

class MyHomepage extends StatefulWidget {
  MyHomepage({Key? key}) : super(key: key);

  @override
  State<MyHomepage> createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  int barindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[800],
        elevation: 0,
        // profile in icon button
        /* leading: IconButton(
          onPressed: () {
            
          },
          icon: Icon(
            Icons.account_circle_sharp,
            color: Colors.white,
            size: 30,
          ),
        ),*/

        // right side top action buttons
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => QRCodeScannerApp()));
            },
            icon: Icon(
              Icons.qr_code_scanner,
              color: Colors.white,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),

      // drawer
      drawer: Drawer(
        child: Container(
          color: Colors.purple[50],
          child: ListView(
            children: [
              Column(
                children: [
                  const DrawerHeader(
                    child: Column(
                      children: [
                        Icon(
                          Icons.account_circle_sharp,
                          size: 40,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text("Irshad"),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Color.fromARGB(47, 0, 0, 0),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 30),
                    leading: Icon(Icons.account_box),
                    title: Text("Edit Profile"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => editprofile(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 30),
                    leading: Icon(Icons.history),
                    title: Text("History"),
                    onTap: () {},
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 30),
                    leading: Icon(Icons.settings),
                    title: Text("Settings"),
                    onTap: () {},
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 30),
                    leading: Icon(Icons.phone_in_talk_outlined),
                    title: Text("Contact"),
                    onTap: () {},
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 30),
                    leading: Icon(Icons.question_mark),
                    title: Text("About App"),
                    onTap: () {},
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("Log out"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      body: Center(
        child: Column(
          children: [
            /*Text(
              "Your balance",
              style: TextStyle(fontSize: 19),
            ),*/
            const SizedBox(
              height: 20,
            ),
            Stack(
              children: [
                Container(
                  height: 175,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.purple[800],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.purple[100],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 11, horizontal: 15),
                      child: const Icon(
                        Icons.send,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.purple[100],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 11, horizontal: 15),
                      child: const Icon(
                        Icons.wallet_rounded,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.purple[100],
                      ),
                    ),
                    const Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 11, horizontal: 15),
                      child: const Icon(
                        Icons.account_balance_sharp,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.purple[100],
                      ),
                    ),
                    const Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 11, horizontal: 15),
                      child: const Icon(
                        Icons.send,
                        color: Color.fromARGB(218, 255, 255, 255),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("send"),
                Text("      top up"),
                Text(" balance"),
                Text("history"),
              ],
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.purple,
          onTap: (index) {
            setState(() {
              barindex = index;
            });
          },
          currentIndex: barindex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.purple[200],
                ),
                label: "Home",
                backgroundColor: Colors.purple[800]),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                  color: Colors.purple[200],
                ),
                label: "search"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.show_chart_rounded,
                  size: 25,
                  color: Colors.purple[200],
                ),
                label: "data"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.compare_arrows_rounded,
                  color: Colors.purple[200],
                ),
                label: "History"),
          ]),
    );
  }
}
