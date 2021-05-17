import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/models/chat_user.dart';

class ProfileScreen extends StatefulWidget {
  static final name = '/profile';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance.collection('profile');
  final _nameController = TextEditingController();
  final _bioController = TextEditingController();
  ChatUser user;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    User authUser = auth.currentUser;
    DocumentSnapshot<Map<String, dynamic>> snaphsot =
        await firestore.doc(authUser.uid).get(GetOptions(source: Source.cache));
    Map<String, dynamic> jsonProfile = snaphsot.data();
    user = ChatUser.fromJson(jsonProfile);
    _nameController.text = user.name;
    _bioController.text = user.bio;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: saveAction,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(user.avatar),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text('Change Image'),
                    )
                  ],
                ),
                SizedBox(width: 20.0),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 25.0),
                    child: Text(
                      'Update your name and optional profile picture',
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 25.0),
            Text('Public Name'),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(hintText: 'Your Name'),
            ),
            SizedBox(height: 25.0),
            Text('Your Bio'),
            TextField(
              controller: _bioController,
              decoration: InputDecoration(hintText: 'Your Bio'),
            ),
            SizedBox(height: 30.0),
            TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.red,
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(10),
                )),
              ),
              onPressed: () {},
              child: Center(
                child: Text(
                  'Delete my account',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void saveAction() {}
}
