import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:course_project/views/home_page.dart';
import 'package:flutterfire_ui/auth.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        return MaterialApp(
          home: selectScreen(snapshot),
        );
      },
    );
  }

  Widget selectScreen(AsyncSnapshot<User?> snapshot) {
    if (snapshot.connectionState == ConnectionState.active) {
      User? user = snapshot.data;
      if (user == null) {
        return SignInScreen(
          auth: FirebaseAuth.instance,
          providerConfigs: const [
            EmailProviderConfiguration(),
            GoogleProviderConfiguration(
              clientId:
                  '258703453258-0nfp60rmrl55r1vtfren3ild0asemvml.apps.googleusercontent.com',
            ),
          ],
        );
      }
      return HomeScreen(user: user);
    }
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
