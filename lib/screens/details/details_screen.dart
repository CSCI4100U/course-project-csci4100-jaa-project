import 'package:flutter/material.dart';

import '../../models/entities/event.dart';
import 'components/body.dart';
import 'components/custom_app_bar.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName = "/details";

  @override
  Widget build(BuildContext context) {
    final EventDetailsArguments agrs =
        ModalRoute.of(context)!.settings.arguments as EventDetailsArguments;
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: CustomAppBar(rating: agrs.event.rating),
      ),
      body: Body(event: agrs.event),
    );
  }
}

class EventDetailsArguments {
  final Event event;

  EventDetailsArguments({required this.event});
}
