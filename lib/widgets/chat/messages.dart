import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/widgets/chat/message_bubble.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy(
            'createdAt',
            descending: true,
          )
          .snapshots(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final chatDocs = snapshot.data!.docs;
        final user = FirebaseAuth.instance.currentUser;

        return ListView.builder(
          reverse: true,
          itemCount: chatDocs.length,
          itemBuilder: ((context, index) => MessageBubble(
                chatDocs[index].data()['text'],
                chatDocs[index].data()['userId'] == user?.uid,
                chatDocs[index].data()['username'],
                chatDocs[index].data()['userImage'],
                key: ValueKey(
                  chatDocs[index].id,
                ),
              )),
        );
      }),
    );
  }
}
