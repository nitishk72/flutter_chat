import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/models/chat_user.dart';
import 'package:flutter_firebase_chat/utils/routes.dart';

class AllPublicUserScreen extends StatefulWidget {
  static String name = '/dashboard/all_public_user';
  @override
  _AllPublicUserScreenState createState() => _AllPublicUserScreenState();
}

class _AllPublicUserScreenState extends State<AllPublicUserScreen> {
  final profile = FirebaseFirestore.instance.collection('profile');
  List<ChatUser> users;
  @override
  void initState() {
    super.initState();
    loadAllUser();
  }

  Future<void> loadAllUser() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await profile.limit(20).get();
    users = snapshot.docs.map((e) => ChatUser.fromJson(e.data())).toList();
    if (users == null) users = [];
    if (this.mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All User'),
      ),
      body: users == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemBuilder: itemBuilder,
              itemCount: users.length,
            ),
    );
  }

  Widget itemBuilder(context, index) {
    ChatUser user = users[index];
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage('${user.avatar}'),
      ),
      title: Text('${user.name}'),
      subtitle: Text('${user.bio}'),
      onTap: () => openChat(user),
    );
  }

  void openChat(ChatUser user) {
    Navigator.pop(context);
    Navigator.pushNamed(context, MyRoutes.chatScreen, arguments: user);
  }
}
