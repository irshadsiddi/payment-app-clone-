import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  String senderId = FirebaseAuth.instance.currentUser!.uid;

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

  void handleListTileTap(Map<String, dynamic> user) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        TextEditingController amountController = TextEditingController();
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context)
                .viewInsets
                .bottom, // Adjusts the bottom padding based on the keyboard height
            left: 20.0,
            right: 20.0,
            top: 20.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Send Money to ${user['name']}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Enter Amount',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    int amount = int.parse(amountController.text);
                    await sendCurrency(senderId, user['mobilenumber'], amount);
                    Navigator.pop(context);
                  },
                  child: const Text('Send'),
                ),
              ],
            ),
          ),
        );
      },
    );
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

  Future<void> sendCurrency(
      String senderId, String receiverPhoneNumber, int amount) async {
    try {
      // Lookup receiver by phone number
      QuerySnapshot query = await FirebaseFirestore.instance
          .collection('users')
          .where('mobilenumber', isEqualTo: receiverPhoneNumber)
          .get();

      if (query.docs.isEmpty) {
        throw Exception("Receiver not found!");
      }

      String receiverId = query.docs.first.id;

      // Begin transaction
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentReference senderRef =
            FirebaseFirestore.instance.collection('users').doc(senderId);
        DocumentReference receiverRef =
            FirebaseFirestore.instance.collection('users').doc(receiverId);

        DocumentSnapshot senderSnapshot = await transaction.get(senderRef);
        DocumentSnapshot receiverSnapshot = await transaction.get(receiverRef);

        if (!senderSnapshot.exists || !receiverSnapshot.exists) {
          throw Exception("User does not exist!");
        }

        Map<String, dynamic> senderData =
            senderSnapshot.data() as Map<String, dynamic>;
        Map<String, dynamic> receiverData =
            receiverSnapshot.data() as Map<String, dynamic>;

        int senderBalance = senderData['balance'];
        int receiverBalance = receiverData['balance'];

        if (senderBalance < amount) {
          throw Exception("Insufficient balance!");
        }

        transaction.update(senderRef, {'balance': senderBalance - amount});
        transaction.update(receiverRef, {'balance': receiverBalance + amount});

        // Log transactions
        await senderRef.collection('transactions').add({
          'amount': amount,
          'type': 'debit',
          'date': FieldValue.serverTimestamp(),
          'to': receiverId
        });

        await receiverRef.collection('transactions').add({
          'amount': amount,
          'type': 'credit',
          'date': FieldValue.serverTimestamp(),
          'from': senderId
        });
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Transaction successful!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Transaction failed: $e')),
      );
    }
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
                  onTap: () => handleListTileTap(user),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
