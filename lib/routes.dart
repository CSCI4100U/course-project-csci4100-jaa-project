import 'package:course_project/screens/calendar/calendar_view.dart';
import 'package:course_project/screens/charts/horizontal_bar_chart.dart';
import 'package:course_project/screens/charts/vertical_bar_chart.dart';
import 'package:course_project/screens/event/event_screen.dart';
import 'package:course_project/screens/event_form/event_form.dart';
import 'package:course_project/screens/event_form/location_map.dart';
import 'package:course_project/screens/home/components/assisted_events_display.dart';
import 'package:course_project/screens/home/components/events_display.dart';
import 'package:course_project/screens/map/map_screen.dart';
import 'package:course_project/screens/profile/my_account.dart';
import 'package:course_project/screens/profile/profile_screen.dart';
import 'package:course_project/screens/table/event_table.dart';
import 'package:flutter/widgets.dart';
import 'package:course_project/screens/details/details_screen.dart';
import 'package:course_project/screens/home/home_screen.dart';
import 'package:course_project/screens/notifications/notifications_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  HomeScreen.routeName: (context) => HomeScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  EventForm.routeName: (context) => EventForm(),
  MapScreen.routeName: (context) => MapScreen(),
  EventsDisplay.routeName: (context) => EventsDisplay(),
  AssistedEventsDisplay.routeName: (context) => AssistedEventsDisplay(),
  EventScreen.routeName: (context) => EventScreen(),
  LocationMap.routeName: (context) => LocationMap(),
  EventTable.routeName: (context) => EventTable(),
  HorizontalChart.routeName: (context) => HorizontalChart(),
  VerticalChart.routeName: (context) => VerticalChart(),
  NotificationsScreen.routeName: (context) => NotificationsScreen(),
  MyAccount.routeName: (context) => MyAccount(),
  CalendarView.routeName: (context) => CalendarView(),
};
