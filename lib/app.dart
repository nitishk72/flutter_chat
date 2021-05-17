import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'utils/routes.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: MyRoutes.routes,
      initialRoute: MyRoutes.initalRoute,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          elevation: 0.0,
        ),
      ),
    );
  }
}
