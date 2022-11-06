import 'package:course_project/screens/event_scheduler/event_scheduler.dart';
import 'package:course_project/screens/profile/profile_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:course_project/screens/details/details_screen.dart';
import 'package:course_project/screens/home/home_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  HomeScreen.routeName: (context) => HomeScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  ScheduleEventPage.routeName: (context) => ScheduleEventPage(),
};
