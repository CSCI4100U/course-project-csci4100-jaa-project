import 'package:flutter/material.dart';
import 'package:course_project/size_config.dart';

import 'assisted_events_banner.dart';
import 'categories.dart';
import 'data_visualizations.dart';
import 'your_events_banner.dart';
import 'home_header.dart';
import 'popular_events.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            const HomeHeader(),
            SizedBox(height: getProportionateScreenWidth(10)),
            const MyEventBanner(),
            Categories(),
            DataVisualizationsDisplay(),
            AssistedEventsBanner(),
            SizedBox(height: getProportionateScreenWidth(30)),
            PopularEvents(),
          ],
        ),
      ),
    );
  }
}
