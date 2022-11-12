import 'package:course_project/models/entities/category.dart';
import 'package:course_project/screens/event/components/all_events.dart';
import 'package:flutter/material.dart';

import '../../../size_config.dart';

class Body extends StatelessWidget {
  Body({Key? key, this.categoryFilter}) : super(key: key);
  final Category? categoryFilter;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: AllEvents(categoryFilter: categoryFilter),
      ),
    );
  }
}
