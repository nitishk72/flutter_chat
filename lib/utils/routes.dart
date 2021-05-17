import 'package:flutter_firebase_chat/screens/chat/home.dart';
import 'package:flutter_firebase_chat/screens/dashboard/all_user.dart';
import 'package:flutter_firebase_chat/screens/dashboard/home.dart';
import 'package:flutter_firebase_chat/screens/profile/home.dart';
import 'package:flutter_firebase_chat/screens/settings/home.dart';

import '../screens/auth/login.dart';
import '../screens/welcome/splash.dart';

class MyRoutes {
  static final String initalRoute = SplashScreen.name;
  static final String splashScreen = SplashScreen.name;
  static final String loginScreen = LoginScreen.name;
  static final String dashboardScreen = DashboardScreen.name;
  static final String profileScreen = ProfileScreen.name;
  static final String settingScreen = SettingScreen.name;
  static final String allPublicUserScreen = AllPublicUserScreen.name;
  static final String chatScreen = ChatScreen.name;

  static final routes = {
    splashScreen: (context) => SplashScreen(),
    loginScreen: (context) => LoginScreen(),
    dashboardScreen: (context) => DashboardScreen(),
    profileScreen: (context) => ProfileScreen(),
    settingScreen: (context) => SettingScreen(),
    allPublicUserScreen: (context) => AllPublicUserScreen(),
    chatScreen: (context) => ChatScreen(),
  };
}
