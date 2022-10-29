import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:course_project/firebase_options.dart';
import 'package:course_project/auth/auth_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const AuthGate());
}
