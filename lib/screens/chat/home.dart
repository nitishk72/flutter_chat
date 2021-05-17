import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/models/chat_user.dart';

class ChatScreen extends StatefulWidget {
  static String name = '/dashboard/chat';
  @override
  CchatScreenState createState() => CchatScreenState();
}

class CchatScreenState extends State<ChatScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final TextEditingController messgeController = TextEditingController();
  ChatUser user;

  @override
  Widget build(BuildContext context) {
    user = ModalRoute.of(context).settings.arguments;
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('${user.name}'),
          actions: [
            Icon(Icons.more_vert),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: firestore
                    .collection('chat')
                    .doc('1')
                    .collection('messages')
                    .orderBy('timeStamp', descending: true)
                    .limit(100)
                    .snapshots(),
                builder: (
                  BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot,
                ) {
                  if (!snapshot.hasData) return new Text('Loading...');
                  print(snapshot.data.docs.length);
                  firestore
                      .collection('chat')
                      .doc('1')
                      .collection('messages')
                      .orderBy('timeStamp')
                      .get()
                      .then((value) {
                    print(value.docs);
                  });
                  return messagebodyBuilder(context, snapshot);
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10.0),
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messgeController,
                      decoration: InputDecoration(hintText: 'Your Message'),
                    ),
                  ),
                  CircleAvatar(
                    child: IconButton(
                      tooltip: 'Send',
                      icon: Icon(
                        Icons.send,
                        size: 18.0,
                      ),
                      onPressed: sendMessage,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget messagebodyBuilder(
    BuildContext context,
    AsyncSnapshot<QuerySnapshot> snapshot,
  ) {
    List<QueryDocumentSnapshot<Object>> messages = snapshot.data.docs;
    return ListView.builder(
      reverse: true,
      itemBuilder: (context, index) {
        Map message = messages[index].data();
        AlignmentGeometry alignemnt = message['sender'] == user.uid
            ? Alignment(1.0, 0.0)
            : Alignment(-1.0, 0.0);
        return Align(
          alignment: alignemnt,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Text(
              "${message['value']}",
            ),
          ),
        );
      },
      itemCount: messages.length,
    );
  }

  void sendMessage() {
    firestore.collection('chat').doc('1').collection('messages').add({
      'value': messgeController.text,
      'type': 'text',
      'sender': user.uid,
      'timeStamp': FieldValue.serverTimestamp(),
    });
    messgeController.text = '';
  }
}
