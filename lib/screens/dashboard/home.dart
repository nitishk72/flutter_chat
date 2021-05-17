import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/models/chat_user.dart';
import 'package:flutter_firebase_chat/utils/routes.dart';

class DashboardScreen extends StatefulWidget {
  static final name = '/dashboard';
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final auth = FirebaseAuth.instance;
  final chat = FirebaseFirestore.instance.collection('chat');
  final profile = FirebaseFirestore.instance.collection('profile');
  List<QueryDocumentSnapshot<Map<String, dynamic>>> users = [];
  User loggedInUser;

  Map<String, String> popupOptions = {
    'Profile': 'navigateProfile',
    'Settings': 'navigateSettings',
    'Logout': 'logout',
  };

  @override
  void initState() {
    super.initState();
    getAllREcent();
  }

  Future<void> getAllREcent() async {
    loggedInUser = auth.currentUser;
    QuerySnapshot<Map<String, dynamic>> snap = await chat
        .where('members', arrayContains: '${loggedInUser.uid}')
        .limit(10)
        .get();
    users = snap.docs;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Chat'),
        actions: [
          PopupMenuButton(
            child: Icon(Icons.more_vert),
            itemBuilder: showPopupMenu,
          )
        ],
      ),
      body: buildList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _navigateSearchUser,
      ),
    );
  }

  List<PopupMenuEntry<dynamic>> showPopupMenu(
    BuildContext context,
  ) {
    return popupOptions.keys.map((e) {
      return PopupMenuItem(
        child: TextButton(
          child: Text('$e'),
          onPressed: () => popupAction(popupOptions[e]),
        ),
      );
    }).toList();
  }

  Widget buildList() {
    return ListView.builder(
      itemBuilder: itemBuilder,
      itemCount: users.length,
    );
  }

  Widget itemBuilder(BuildContext contex, int index) {
    QueryDocumentSnapshot<Map<String, dynamic>> snap = users[index];
    Map user = snap.data();
    final id = (user['meta'] as Map)
        .keys
        .where((element) => element == loggedInUser.uid)
        .toList()
        .first;
    return FutureBuilder(
      future: profile.doc(id).get(),
      builder: (context, snap) {
        if (!snap.hasData) return Text('Loading');
        DocumentSnapshot<Map<String, dynamic>> json = snap.data;
        ChatUser user = ChatUser.fromJson(json.data());
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage('${user.avatar}'),
          ),
          title: Text("${user.name}"),
          subtitle: Text("${user.bio}"),
        );
      },
    );
  }

  void popupAction(String e) {
    print('$e');
    if ('navigateSettings' == e) {
      navigateSettings();
    } else if ('navigateProfile' == e) {
      navigateProfile();
    } else if ('logout' == e) {
      logout();
    }
  }

  void navigateProfile() {
    Navigator.pop(context);
    Navigator.pushNamed(
      context,
      MyRoutes.profileScreen,
    );
  }

  void navigateSettings() {
    Navigator.pop(context);
    Navigator.pushNamed(
      context,
      MyRoutes.settingScreen,
    );
  }

  void _navigateSearchUser() {
    Navigator.pushNamed(
      context,
      MyRoutes.allPublicUserScreen,
    );
  }

  void logout() async {
    await auth.signOut();
    Navigator.pushNamedAndRemoveUntil(
      context,
      MyRoutes.loginScreen,
      (route) => false,
    );
  }
}
