import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({super.key});

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  late String userId;
  List<Map<String, dynamic>> transactions = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    userId = FirebaseAuth.instance.currentUser!.uid;
    fetchTransactions();
  }

  Future<void> fetchTransactions() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('collection_transaction')
          .orderBy('date', descending: true)
          .get();

      setState(() {
        transactions = snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching transactions: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction History'),
        backgroundColor: Colors.blue,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                final isDebit = transaction['type'] == 'debit';
                final amount = transaction['amount'];
                final date = (transaction['date'] as Timestamp).toDate();
                final formattedDate =
                    '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';

                return ListTile(
                  leading: Icon(
                    isDebit ? Icons.arrow_upward : Icons.arrow_downward,
                    color: isDebit ? Colors.red : Colors.green,
                  ),
                  title: Text(
                    '${isDebit ? 'Sent to' : 'Received from'} ${transaction['to'] ?? transaction['from']}',
                  ),
                  subtitle: Text('Amount: $amount\nDate: $formattedDate'),
                  isThreeLine: true,
                );
              },
            ),
    );
  }
}
