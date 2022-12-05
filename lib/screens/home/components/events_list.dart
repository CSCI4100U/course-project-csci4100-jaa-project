import 'package:course_project/auth/fire_auth.dart';
import 'package:course_project/models/entities/event.dart';
import 'package:course_project/screens/home/components/events_grid.dart';
import 'package:flutter/material.dart';
import 'package:course_project/models/db_models/event_model.dart';

import '../../../size_config.dart';
import 'section_title.dart';

class EventsList extends StatefulWidget {
  static String routeName = '/eventsList';
  const EventsList({super.key});

  @override
  State<EventsList> createState() => _EventsListState();
}

class _EventsListState extends State<EventsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("My Events"),
        ),
        body: Column(children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: const Text("My Events",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          _buildProductList(context),
        ]));
  }

  Widget _buildProductList(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(695),
      padding: const EdgeInsets.all(20),
      child: StreamBuilder(
          stream: Stream<List<Event>>.fromFuture(
              EventModel().getUserEvents(FireAuth.getCurrentUser())),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            List<Event> events = snapshot.data as List<Event>;
            return GridEvents(events: events);
          }),
    );
  }
}
