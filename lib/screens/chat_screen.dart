// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats/mgRznE1ybJtLRZA09soi/messages')
            .snapshots(),
        builder: (context, streamSnapshop) {
          if (streamSnapshop.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = streamSnapshop.data?.docs;
          return ListView.builder(
            itemCount: documents?.length,
            itemBuilder: (context, index) => Container(
              padding: const EdgeInsets.all(8),
              child: Text(documents?[index]['text']),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/mgRznE1ybJtLRZA09soi/messages')
              .add({'text': 'This was added after clicking the button'});
        },
      ),
    );
  }
}
