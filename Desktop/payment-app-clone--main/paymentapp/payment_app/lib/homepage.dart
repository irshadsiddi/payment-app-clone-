import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:payment_app/phonenumber_verification.dart';

class MyHomepage extends StatefulWidget {
  MyHomepage({Key? key}) : super(key: key);

  @override
  State<MyHomepage> createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  int barindex = 0;
  String display_name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[600],
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
            onPressed: () {},
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
          color: Color.fromARGB(255, 255, 255, 255),
          child: ListView(
            children: [
              Column(
                children: [
                  const DrawerHeader(
                    child: Icon(
                      Icons.account_circle_sharp,
                      size: 40,
                    ),
                  ),
                  const Divider(
                    color: Colors.black12,
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 30),
                    leading: Icon(Icons.account_box),
                    title: Text("Edit Profile"),
                    onTap: () {},
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

      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.purple,
          onTap: (index) {
            setState(() {
              barindex = index;
            });
          },
          currentIndex: barindex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "search"),
            BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.history), label: "history"),
          ]),
    );
  }
}
