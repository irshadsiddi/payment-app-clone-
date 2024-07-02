import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:payment_app/edit_profile.dart';
import 'package:payment_app/pay_anyone.dart';
import 'package:payment_app/phonenumber_verification.dart';
import 'package:payment_app/qr_scanner.dart';

class MyHomepage extends StatefulWidget {
  MyHomepage({Key? key}) : super(key: key);

  @override
  State<MyHomepage> createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  int barindex = 0;
  String userName = '';
  String phoneNumber = '';
  String firstchar = '';

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        setState(() {
          userName = userDoc['name'] ?? 'No Name';
          firstchar = userName.isNotEmpty ? userName.substring(0, 1) : '';
          phoneNumber = userDoc['mobilenumber'] ?? 'No Number';
        });
      }
    } catch (e) {
      print('Error fetching user details: $e');
    }
  }

  get painter => MyPainter();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        shape: CircleBorder(eccentricity: 1),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => QRCodeScanner()),
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
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfile(),
                  ),
                );
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    firstchar,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
                      color: Color.fromARGB(255, 255, 255, 255),
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
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => QRCodeScanner(),
                                  ),
                                );
                              },
                              child: Container(
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
                                child: const Center(
                                  child: (const Icon(
                                    Icons.qr_code,
                                    color: Colors.white,
                                    size: 35,
                                  )),
                                ),
                              ),
                            ),

                            // send money

                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PayAnyone(),
                                  ),
                                );
                              },
                              child: Container(
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
                                child: const Center(
                                  child: (Icon(
                                    Icons.send_sharp,
                                    color: Colors.white,
                                    size: 35,
                                  )),
                                ),
                              ),
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
                              child: const Center(
                                child: (Icon(
                                  Icons.data_exploration_rounded,
                                  color: Colors.white,
                                  size: 35,
                                )),
                              ),
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
                              child: const Center(
                                child: (Icon(
                                  Icons.account_balance,
                                  color: Colors.white,
                                  size: 32,
                                )),
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Scan\n QR'),
                              Text('      Pay\n  Anyone'),
                              Text('     see\n   graph'),
                              Text('   check\n Balance'),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        // to display phone number
                        Container(
                          height: 25,
                          width: 180,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.blue[50],
                          ),
                          child: Center(
                            child: Text(
                              'UNIQ ID:' + phoneNumber,
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
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 500,
                    color: Colors.blue[50],
                  ),
                  /*CustomPaint(
                    painter: MyPainter(),
                  ),*/
                ],
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              padding: const EdgeInsets.all(0), // Adjust padding here
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
                      child: const Center(
                        child: Icon(
                          Icons.account_circle_sharp,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                    ),
                    const Text(
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
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 181, 216, 245),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 90,
                          ),
                          Icon(
                            Icons.qr_code,
                            color: Colors.white,
                          ),
                          SizedBox(width: 9),
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
                // Navigate to edit profile
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfile(),
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
            const SizedBox(height: 150), // Adjusted space between list items
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Phonenumber()),
                );
              },

              // styling the button
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: const Text(
                "Log out",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
            ),
          ],
        ),
      ),
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
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (barindex == 0)
                    Positioned(
                      top: 0,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  Icon(
                    Icons.currency_rupee,
                    size: 35,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  barindex = 3;
                  // Handle tap for fourth icon (people)
                });
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.auto_graph,
                    size: 35,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  if (barindex == 3)
                    Positioned(
                      top: 0,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;

    Offset beginPoint = Offset(50, 50);
    Offset endPoint = Offset(250, 250);
    Offset controlPoint1 = Offset(100, 0);
    Offset controlPoint2 = Offset(200, 300);

    canvas.drawLine(beginPoint, controlPoint1, paint);
    canvas.drawLine(controlPoint1, controlPoint2, paint);
    canvas.drawLine(controlPoint2, endPoint, paint);

    Path path = Path();
    path.moveTo(beginPoint.dx, beginPoint.dy);
    path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
        controlPoint2.dy, endPoint.dx, endPoint.dy);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
