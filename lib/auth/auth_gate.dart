import 'package:course_project/screens/auth/auth_screen.dart';
import 'package:course_project/size_config.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:course_project/screens/home/home_screen.dart';

class AuthGate extends StatelessWidget {
  static String routeName = "/auth";
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    print(user?.email);
    if (user != null) {
      Future.microtask(
          () => Navigator.pushNamed(context, HomeScreen.routeName));
    }
    return AuthScreen();
  }
}
