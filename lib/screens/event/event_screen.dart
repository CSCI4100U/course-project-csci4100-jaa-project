import 'package:course_project/models/entities/category.dart';
import 'package:flutter/material.dart';
import 'package:course_project/components/coustom_bottom_nav_bar.dart';
import 'package:course_project/constants.dart';

import 'components/body.dart';

class EventScreen extends StatelessWidget {
  static String routeName = "/events";

  @override
  Widget build(BuildContext context) {
    Category? categoryFilter =
        ModalRoute.of(context)!.settings.arguments as Category;
    return Scaffold(
        appBar: AppBar(
          title: Text("Events"),
        ),
        body: Body(categoryFilter: categoryFilter));
  }
}
