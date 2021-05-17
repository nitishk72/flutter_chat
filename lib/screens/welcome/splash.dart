import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/utils/routes.dart';

class SplashScreen extends StatelessWidget {
  final auth = FirebaseAuth.instance;
  static final name = '/splash';
  final delay = 1;

  void navigateLazily(BuildContext context) {
    final duration = Duration(seconds: delay);
    Timer(duration, () => navigate(context));
  }

  void navigate(context) {
    String route = MyRoutes.dashboardScreen;
    User firebaseUser = auth.currentUser;
    if (firebaseUser == null) {
      route = MyRoutes.loginScreen;
    }
    Navigator.pushReplacementNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    navigateLazily(context);
    return Scaffold(
      body: Center(
        child: Text(
          'Flutter Chat',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
    );
  }
}
