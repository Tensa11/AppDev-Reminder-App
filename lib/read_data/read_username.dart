import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class getUserName extends StatelessWidget {

  final String documentId;
  getUserName({required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('user');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder: ((context, snapshot){
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            return Text("${data['username']}");
          }
          return const Text('Loading...');
          }
        ),
    );
  }
}
