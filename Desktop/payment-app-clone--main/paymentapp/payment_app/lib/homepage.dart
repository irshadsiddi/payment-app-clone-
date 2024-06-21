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
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => QRCodeScannerApp()),
          );
        },
        child: const Icon(
          Icons.qr_code,
          size: 35,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 254, 254),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /*GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    'SI',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),*/
            const SizedBox(
              width: 0,
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.all(7.0),
                child: Text(
                  'Just Launched',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  'SI',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),

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
        /* actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => QRCodeScannerApp()));
            },
            icon: const Icon(
              Icons.qr_code_scanner,
              color: Colors.white,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],*/
      ),

      // drawer
      /*drawer: Drawer(
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
                        SizedBox(
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
                    contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                    leading: const Icon(Icons.account_box),
                    title: const Text("Edit Profile"),
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
                    contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                    leading: const Icon(Icons.history),
                    title: const Text("History"),
                    onTap: () {},
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                    leading: const Icon(Icons.settings),
                    title: const Text("Settings"),
                    onTap: () {},
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                    leading: const Icon(Icons.phone_in_talk_outlined),
                    title: const Text("Contact"),
                    onTap: () {},
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                    leading: const Icon(Icons.question_mark),
                    title: const Text("About App"),
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
      ),*/

      /* body: Center(
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
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 11, horizontal: 15),
                      child: Icon(
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
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 11, horizontal: 15),
                      child: Icon(
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
                      padding:
                          EdgeInsets.symmetric(vertical: 11, horizontal: 15),
                      child: Icon(
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
                      padding:
                          EdgeInsets.symmetric(vertical: 11, horizontal: 15),
                      child: Icon(
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
      ),*/

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const Text(
                'AAAAA',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              const Text(
                'aaaaaaaaaaaaaaaaaaaa',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              Stack(
                children: [
                  Container(
                    height: 550,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(30),
                        topEnd: Radius.circular(30),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //QR
                            Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Colors.blue, Colors.blueAccent],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(17),
                              ),
                              child: (const Icon(
                                Icons.qr_code,
                                color: Colors.white,
                                size: 35,
                              )),
                            ),

                            // send money

                            Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Colors.blue, Colors.blueAccent],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(17),
                              ),
                              child: (Icon(
                                Icons.qr_code,
                                color: Colors.white,
                                size: 35,
                              )),
                            ),

                            // bank balance

                            Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Colors.blue, Colors.blueAccent],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(17),
                              ),
                              child: (Icon(
                                Icons.qr_code,
                                color: Colors.white,
                                size: 35,
                              )),
                            ),

                            // transactions

                            Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Colors.blue, Colors.blueAccent],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(17),
                              ),
                              child: (const Icon(
                                Icons.qr_code,
                                color: Colors.white,
                                size: 35,
                              )),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('data'),
                              Text('data'),
                              Text('data'),
                              Text('data'),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        // to display phone number
                        Center(
                          child: Container(
                            height: 20,
                            width: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.blue[50],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        // just for decoration

                        Center(
                          child: Container(
                            height: 200,
                            width: 500,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue[50],
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 35,
                        ),

                        const Placeholder(
                          fallbackWidth: 500,
                          fallbackHeight: 100,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: 500,
                color: Colors.blue[50],
              ),
            ],
          ),
        ),
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 163, 214, 255),
              ),
              padding: EdgeInsets.all(0), // Adjust padding here
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    Text(
                      'Drawer Header',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                    const Text(
                      'Phonenumber',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 90,
                          ),
                          Icon(Icons.qr_code),
                          const SizedBox(width: 9),
                          Text(
                            'QR Code',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 30),
              leading: const Icon(Icons.account_box),
              title: const Text("Edit Profile"),
              onTap: () {
                // Navigate to edit profile screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => editprofile(),
                  ),
                );
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 30),
              leading: const Icon(Icons.history),
              title: const Text("History"),
              onTap: () {
                // Handle history tap
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 30),
              leading: const Icon(Icons.settings),
              title: const Text("Settings"),
              onTap: () {
                // Handle settings tap
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 30),
              leading: const Icon(Icons.phone_in_talk_outlined),
              title: const Text("Contact"),
              onTap: () {
                // Handle contact tap
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 30),
              leading: const Icon(Icons.question_mark),
              title: const Text("About App"),
              onTap: () {
                // Handle about app tap
              },
            ),
            SizedBox(height: 150), // Adjusted space between list items
            ElevatedButton(
              onPressed: () {
                // Handle logout button tap
              },
              child: const Text("Log out"),
            ),
          ],
        ),
      ),
      /* floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.purple[800],
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
          ]),*/

      /*floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        
        padding: const EdgeInsets.symmetric(horizontal: 0),
        height: 60,
        color: Color.fromARGB(255, 38, 134, 218),
        shape: const CircularNotchedRectangle(),
        
        notchMargin: 10,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            
            IconButton(
              
              icon: const Icon(
                Icons.home,
                size: 30,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.search,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.print,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.people,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),*/

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        height: 60,
        color: const Color.fromARGB(255, 38, 134, 218),
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            InkWell(
              onTap: () {
                setState(() {
                  barindex = 0;
                  // Handle tap for first icon (home)
                });
              },
              child: Icon(
                Icons.home,
                size: 30,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  barindex = 1;
                  // Handle tap for second icon (search)
                });
              },
              child: Icon(
                Icons.search,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  barindex = 2;

                  // Handle tap for third icon (print)
                });
              },
              child: Icon(
                Icons.print,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  barindex = 3;
                  // Handle tap for fourth icon (people)
                });
              },
              child: Icon(
                Icons.people,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
