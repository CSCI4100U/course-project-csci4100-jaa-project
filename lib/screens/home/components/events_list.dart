import 'package:course_project/auth/fire_auth.dart';
import 'package:course_project/models/entities/event.dart';
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
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SectionTitle(
          title: "Your Events",
          press: () {},
        ),
      ),
      _buildProductList(context),
    ])
    );
  }

  Widget _buildEvent(Event event) {
    return GestureDetector(
      child: ListTile(
        title: Text(event.name),
        subtitle: Text(event.date.toString()),
      ),
    );
  }

  Widget _buildProductList(BuildContext context) {
    return StreamBuilder(
        stream: Stream<List<Event>>.fromFuture(EventModel().getUserEvents(FireAuth.getCurrentUser())),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          List<Event> events = snapshot.data;
          return ListView.builder(
            itemCount: events.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: EdgeInsets.all(16),
            itemBuilder: ((context, index) => _buildEvent(events[index])),
          );
        });
  }
}
