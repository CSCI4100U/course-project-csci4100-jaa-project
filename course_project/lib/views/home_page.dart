import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/auth.dart';

class HomeScreen extends StatelessWidget {
  final User user;
  const HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FlutterFire UI Authentication"),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Text(user.email!),
            Center(child: Text("This is Home Screen")),
            SignOutButton(),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
