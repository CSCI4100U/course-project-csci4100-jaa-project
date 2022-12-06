import 'package:course_project/auth/fire_auth.dart';
import 'package:course_project/screens/home/home_screen.dart';
import 'package:course_project/screens/notifications/notifications_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../my_account.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  final i18nKey = "profile_screen.body";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 70),
      child: Column(
        children: [
          const ProfilePic(),
          const SizedBox(height: 50),
          ProfileMenu(
            text: FlutterI18n.translate(context, "$i18nKey.my_account"),
            icon: "assets/icons/User Icon.svg",
            press: () async =>
                await Navigator.pushNamed(context, MyAccount.routeName),
          ),
          ProfileMenu(
            text: FlutterI18n.translate(context, "$i18nKey.notifications"),
            icon: "assets/icons/Bell.svg",
            press: () async => await Navigator.pushNamed(
              context,
              NotificationsScreen.routeName,
            ),
          ),
          ProfileMenu(
            text: FlutterI18n.translate(context, "$i18nKey.log_out"),
            icon: "assets/icons/Log out.svg",
            press: () async => await FireAuth.signOut(context),
          ),
        ],
      ),
    );
  }
}
