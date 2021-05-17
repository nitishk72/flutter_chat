import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/utils/routes.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatelessWidget {
  static final name = '/auth/login';
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          child: Text('Login with Google'),
          onPressed: () => loginWithGoogle(context),
        ),
      ),
    );
  }

  Future<void> loginWithGoogle(context) async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return;

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    UserCredential userCredential = await auth.signInWithCredential(credential);
    User loggedInUser = userCredential.user;

    // If user logged in then open dashboard
    if (loggedInUser != null) {
      createProfileIfnotExist(context, loggedInUser);
      Navigator.pushReplacementNamed(context, MyRoutes.dashboardScreen);
    }
  }

  Future<void> createProfileIfnotExist(BuildContext context, User user) async {
    final profile = firestore.collection('profile');
    DocumentSnapshot<Map<String, dynamic>> jsonProfile =
        await profile.doc(user.uid).get();
    if (jsonProfile.exists) return;
    final profileData = {
      'uid': user.uid,
      'isPublic': true,
      'bio': 'Hey there! I am using Firebase Flutter Chat',
      'name': user.displayName,
      'phone': null,
      'email': user.email,
      'avatar': user.photoURL,
      'isEmailVerified': user.emailVerified,
      'loggedIn': 'Google',
      'lastLoggedIn': FieldValue.serverTimestamp(),
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': null,
      'meta': {
        'creationTime': user.metadata.creationTime,
        'lastSignInTime': user.metadata.lastSignInTime,
      },
    };
    profile.doc(user.uid).set(profileData);
  }
}
