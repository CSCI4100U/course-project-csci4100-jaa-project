import 'package:flutter/material.dart';
import 'package:course_project/components/coustom_bottom_nav_bar.dart';
import 'package:course_project/enums.dart';
import 'package:course_project/constants.dart';

import 'components/body.dart';

class MapScreen extends StatelessWidget {
  static String routeName = "/Map";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Map"),
      ),
      body: const Body(),
      bottomNavigationBar: CustomBottomNavBar(
          selectedOption:
              options.firstWhere((element) => element.name == "Map")),
    );
  }
}
