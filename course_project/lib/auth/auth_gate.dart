import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:course_project/views/home_page.dart';
import 'package:course_project/views/login_page.dart';
import 'package:flutterfire_ui/auth.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;
          if (user == null) {
            return const MaterialApp(
              home: SignInScreen(
                providerConfigs: [
                  EmailProviderConfiguration(),
                  GoogleProviderConfiguration(
                    clientId:
                        '258703453258-0nfp60rmrl55r1vtfren3ild0asemvml.apps.googleusercontent.com',
                  ),
                ],
              ),
            );
          }
          return HomeScreen(user: user);
        }
        return const MaterialApp(
            home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ));
      },
    );
  }
}
