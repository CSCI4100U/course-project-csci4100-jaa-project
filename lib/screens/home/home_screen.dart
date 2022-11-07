import 'package:course_project/auth/auth_gate.dart';
import 'package:course_project/components/menu_option.dart';
import 'package:course_project/constants.dart';
import 'package:course_project/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:course_project/components/coustom_bottom_nav_bar.dart';
import 'package:course_project/enums.dart';

import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/";

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
            return DefaultTabController(
              length: options.length,
              child: Scaffold(
                body: buildTabBarView(options),
                bottomNavigationBar: CustomBottomNavBar(
                    selectedOption: options
                        .firstWhere((element) => element.name == "Home")),
              ),
            );
          }
        }
        return const AuthGate();
      },
    );
  }
}
