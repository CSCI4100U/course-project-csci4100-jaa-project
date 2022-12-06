import 'package:course_project/auth/fire_auth.dart';
import 'package:course_project/main.dart';
import 'package:course_project/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import '/constants.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyAccount extends StatelessWidget {
  static String routeName = "/my_account";

  const MyAccount({super.key});

  final i18nKey = "profile_screen.my_account";

  @override
  Widget build(BuildContext context) {
    var user = FireAuth.getCurrentUser();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(FlutterI18n.translate(context, "$i18nKey.title")),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 70),
        child: Center(
          child: Column(
            children: [
              Text(
                FlutterI18n.translate(
                  context,
                  "$i18nKey.email",
                  translationParams: {"email": user.email!},
                ),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 60),
              if (user.displayName != null && user.displayName!.isNotEmpty)
                Text(
                  FlutterI18n.translate(
                    context,
                    "$i18nKey.name",
                    translationParams: {"name": user.displayName!},
                  ),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              const SizedBox(height: 60),
              if (user.phoneNumber != null && user.phoneNumber!.isNotEmpty)
                Text(
                  FlutterI18n.translate(
                    context,
                    "$i18nKey.phone",
                    translationParams: {"phone": user.phoneNumber!},
                  ),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
