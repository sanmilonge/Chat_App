import 'package:chat/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});
  @override
  Widget build(ctx) {
    final user = FirebaseAuth.instance.currentUser!;

    final chatSnapshot = FirebaseFirestore.instance
        .collection('Chat')
        .orderBy('createdAt', descending: true)
        .snapshots();
    return StreamBuilder(
      stream: chatSnapshot,
      builder: (ctx, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (chatSnapshot.hasError) {
          return const Center(
            child: Text('An error occurred while loading messages.'),
          );
        }
        if (!chatSnapshot.hasData || chatSnapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('No messages yet. Start the conversation!'),
          );
        }
        final chatDocs = chatSnapshot.data!.docs;
        return ListView.builder(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          reverse: true,
          itemCount: chatDocs.length,
          itemBuilder: (ctx, index) {
            final chatMessage = chatDocs[index].data();
            final nextChatMessage = index + 1 < chatDocs.length
                ? chatDocs[index + 1].data()
                : null;
            final messageUserId = chatMessage['userID'];
            final nextMessageUserId = nextChatMessage != null
                ? nextChatMessage['userID']
                : null;
            final isSameUser = messageUserId == nextMessageUserId;

            if (isSameUser) {
              return MessageBubble.next(
                message: chatMessage['text'],
                isMe: user.uid == messageUserId,
              );
            } else {
              return MessageBubble.first(
                message: chatMessage['text'],
                username: chatMessage['username'],
                userImage: chatMessage['userImage'],
                isMe: user.uid == messageUserId,
              );
            }
          },
        );
      },
    );
  }
}
