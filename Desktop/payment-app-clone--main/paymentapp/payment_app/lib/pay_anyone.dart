import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PayAnyone extends StatefulWidget {
  const PayAnyone({Key? key}) : super(key: key);

  @override
  State<PayAnyone> createState() => _PayAnyoneState();
}

class _PayAnyoneState extends State<PayAnyone> {
  TextEditingController mblcontroller = TextEditingController();
  List<Map<String, dynamic>> userList = [];
  List<Map<String, dynamic>> filteredUserList = [];
  String senderId = FirebaseAuth.instance.currentUser!.uid;
  int senderBalance = 0; // Initialize sender's balance

  @override
  void initState() {
    super.initState();
    fetchUsers();
    fetchSenderBalance(); // Fetch sender's balance on init
  }

  Future<void> fetchUsers() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('users').get();
      setState(() {
        userList = snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
        filteredUserList = List.from(
            userList); // Ensure filteredUserList is a copy of userList initially
      });
    } catch (e) {
      print('Error fetching users: $e');
    }
  }

  Future<void> fetchSenderBalance() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(senderId)
          .get();
      if (snapshot.exists) {
        setState(() {
          // Ensure the balance is cast to int
          senderBalance =
              (snapshot.data() as Map<String, dynamic>)['balance'].toInt();
          print('Sender balance fetched: $senderBalance');
        });
      }
    } catch (e) {
      print('Error fetching sender balance: $e');
    }
  }

  void handleListTileTap(Map<String, dynamic> user) {
    // Removed sender balance check as requested
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
                    int amount = int.tryParse(amountController.text) ?? 0;
                    if (amount <= 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Amount must be greater than zero')),
                      );
                      return;
                    }
                    if (amount > senderBalance) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Insufficient balance!')),
                      );
                      return;
                    }
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

        int currentSenderBalance = senderData['balance'].toInt();
        int currentReceiverBalance = receiverData['balance'].toInt();

        if (currentSenderBalance < amount) {
          throw Exception("Insufficient balance!");
        }

        transaction
            .update(senderRef, {'balance': currentSenderBalance - amount});
        transaction
            .update(receiverRef, {'balance': currentReceiverBalance + amount});

        // Log transactions
        await senderRef.collection('collection_transaction').add({
          'amount': amount,
          'type': 'debit',
          'date': FieldValue.serverTimestamp(),
          'to': receiverId
        });

        await receiverRef.collection('collection_transaction').add({
          'amount': amount,
          'type': 'credit',
          'date': FieldValue.serverTimestamp(),
          'from': senderId
        });
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Transaction successful!')),
      );
      fetchSenderBalance(); // Update sender balance
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
                      style: const TextStyle(color: Colors.white),
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
