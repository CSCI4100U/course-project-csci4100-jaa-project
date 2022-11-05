import 'package:course_project/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
}
