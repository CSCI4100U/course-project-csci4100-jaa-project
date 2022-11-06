import 'package:course_project/auth/auth_gate.dart';
import 'package:course_project/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:course_project/components/coustom_bottom_nav_bar.dart';
import 'package:course_project/enums.dart';

import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      initialData: FirebaseAuth.instance.currentUser,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          User? user = snapshot.data;
          if (user != null) {
            return Scaffold(
              body: Body(),
              bottomNavigationBar:
                  CustomBottomNavBar(selectedMenu: MenuState.home),
            );
          }
        }
        return AuthGate();
      },
    );
  }
}
