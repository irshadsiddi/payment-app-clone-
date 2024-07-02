import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PayAnyone extends StatefulWidget {
  const PayAnyone({super.key});

  @override
  State<PayAnyone> createState() => _PayAnyoneState();
}

class _PayAnyoneState extends State<PayAnyone> {
  TextEditingController mblcontroller = TextEditingController();
  List<Map<String, dynamic>> userList = [];
  List<Map<String, dynamic>> filteredUserList = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('users').get();
      setState(() {
        userList = snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
        filteredUserList = userList;
      });
    } catch (e) {
      print('Error fetching users: $e');
    }
  }

  void handleListTileTap(String userId) {
    // Execute your desired function here with the userId
    print('Tapped user: $userId');
  }

  void filterUsers(String query) {
    List<Map<String, dynamic>> results = [];
    if (query.isEmpty) {
      results = userList;
    } else {
      results = userList
          .where((user) =>
              user['mobilenumber'].contains(query) ||
              user['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    setState(() {
      filteredUserList = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'Send Money',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.qr_code,
                size: 35,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const Text(
            'Send to any mobile number',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: mblcontroller,
              decoration: InputDecoration(
                hintText: 'Search number',
                focusColor: Colors.blue,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              onChanged: (value) {
                filterUsers(value);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredUserList.length,
              itemBuilder: (context, index) {
                final user = filteredUserList[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text(
                      user['name'][0].toUpperCase(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(
                    user['name'],
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Text(user['mobilenumber']),
                  onTap: () => handleListTileTap(user['uid']),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
