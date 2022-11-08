import 'package:course_project/auth/fire_auth.dart';
import 'package:course_project/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../size_config.dart';
import '../all_events.dart';
import 'event_header.dart';


class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            EventHeader(),
            SizedBox(height: getProportionateScreenWidth(20)),
            AllEvents(),
        ],
      ),
    );
  }
}