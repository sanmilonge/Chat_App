import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() {
    return _NewMessageState();
  }
}

class _NewMessageState extends State<NewMessage> {
  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  Future<void> sendMessage() async {
    final enteredMessage = textController.text.trim();
    if (enteredMessage.isEmpty) return;

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      final userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      final userData = userSnap.data();
      if (userData == null) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User profile not found. Please re-login.'),
          ),
        );
        return;
      }

      textController.clear();

      await FirebaseFirestore.instance.collection('Chat').add({
        'text': enteredMessage,
        'createdAt': Timestamp.now(),
        'userID': user.uid,
        'username': userData['username'] ?? 'Anonymous',
        'userImage': userData['imageUrl'] ?? '',
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Could not send message: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      // ✅ small fix: use EdgeInsets not EdgeInsetsGeometry constructor
      padding: const EdgeInsets.only(left: 15, right: 1, bottom: 14),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: textController,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: const InputDecoration(
                label: Text("Enter message..."),
              ),
            ),
          ),
          IconButton(
            color: Theme.of(context).colorScheme.primary,
            onPressed: sendMessage,
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
