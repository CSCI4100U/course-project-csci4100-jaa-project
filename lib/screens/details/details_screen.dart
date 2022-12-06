import 'package:course_project/auth/fire_auth.dart';
import 'package:flutter/material.dart';

import '../../models/entities/event.dart';
import 'components/body.dart';
import 'components/custom_app_bar.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName = "/details";

  @override
  Widget build(BuildContext context) {
    final EventDetailsArguments args =
        ModalRoute.of(context)!.settings.arguments as EventDetailsArguments;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F9),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: CustomAppBar(rating: args.event.rating),
      ),
      body: Body(
        event: args.event,
        currentUser: FireAuth.getCurrentUser(),
      ),
    );
  }
}

class EventDetailsArguments {
  final Event event;

  EventDetailsArguments({required this.event});
}
