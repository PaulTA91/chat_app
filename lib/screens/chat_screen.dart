// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Chat"),
        backgroundColor: Colors.pink[900],
        actions: [
          DropdownButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            items: [
              DropdownMenuItem(
                value: 'logout',
                child: Container(
                  child: Row(
                    children: const [
                      Icon(
                        Icons.exit_to_app,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text("logout"),
                    ],
                  ),
                ),
              )
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
      ),
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
