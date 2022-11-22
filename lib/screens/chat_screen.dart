import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final fireStore = FirebaseFirestore.instance;
late User signedInUser;

class ChatScreen extends StatefulWidget {
  static const screenRoute = '/ChatScreen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final textController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  late String _sentMessage;

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() {
    final user = _auth.currentUser;
    if (user != null) {
      signedInUser = user;
      print(signedInUser.email);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[900],
        leading: Image.asset('images/logo.png'),
        title: Text('heyChat'),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              _auth.signOut();
              Navigator.pop(context);
            },
            icon: Icon(Icons.logout_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: MessageStreamBuilder(),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.yellow[900] ?? Colors.yellow,
                    width: 2,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: textController,
                      onChanged: (value) {
                        _sentMessage = value;
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        hintText: 'Write your message here...',
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      fireStore.collection('messages').add({
                        'text': _sentMessage,
                        'email': signedInUser.email,
                        'time': FieldValue.serverTimestamp(),
                      });
                      textController.clear();
                    },
                    child: Text(
                      'send',
                      style: TextStyle(
                        color: Colors.blue[900] ?? Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStreamBuilder extends StatelessWidget {
  const MessageStreamBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: fireStore.collection('messages').orderBy('time').snapshots(),
      builder: (context, snapshot) {
        List<Widget> messageWidgets = [];

        if (snapshot.hasData) {
          final messages = snapshot.data?.docs.reversed;

          for (var message in messages!) {

            final text = message['text'];
            final sender = message['email'];
            final currentUser = signedInUser.email;

            final messageWidget = MessageWidget(
              text: text,
              sender: sender,
              isMe: currentUser == sender,
            );

            if (currentUser == sender) {}

            messageWidgets.add(messageWidget);
          }
        }

        return ListView(
          reverse: true,
          children: messageWidgets,
        );
      },
    );
  }
}


class MessageWidget extends StatelessWidget {
  late String text;
  late String sender;
  late bool isMe;

  MessageWidget({required this.text, required this.sender, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 15,
      ),
      child: Column(
        crossAxisAlignment:
        (isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start),
        children: [
          Text(
            sender,
            style: TextStyle(
              color: Colors.yellow[900],
              fontSize: 12,
            ),
          ),
          Material(
            color: (isMe ? Colors.blue : Colors.white),
            borderRadius: BorderRadius.circular(30),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(text, style: TextStyle(
                color: (isMe ? Colors.white : Colors.black),
              ),),
            ),
          ),
        ],
      ),
    );
  }
}