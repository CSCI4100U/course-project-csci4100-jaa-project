import 'package:course_project/auth/fire_auth.dart';
import 'package:course_project/main.dart';
import 'package:course_project/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import '/constants.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyAccount extends StatelessWidget {
  MyAccount({super.key});
  static String routeName = "/my_account";

  @override
  Widget build(BuildContext context) {
    var user = FireAuth.getCurrentUser();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text("My Account Details"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 70),
        child: Center(
          child: Column(
            children: [
              Text("Email: ${user.email}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 60),
              if (user.displayName != null)
                Text("Name: ${user.displayName}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
              ),
              SizedBox(height: 60),
              if (user.phoneNumber != null)
              Text("Phone: ${user.phoneNumber}",
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