import 'package:course_project/models/db_models/event_model.dart';
import 'package:course_project/models/entities/event.dart';
import 'package:course_project/screens/event/components/search_field.dart';
import 'package:course_project/screens/event/components/section_title.dart';
import 'package:flutter/material.dart';
import 'package:course_project/components/event_card.dart';
import 'package:course_project/size_config.dart';

class GridEvents extends StatefulWidget {
  GridEvents({Key? key, required this.events}) : super(key: key);

  final List<Event> events;

  @override
  State<GridEvents> createState() => _GridEventsState();
}

class _GridEventsState extends State<GridEvents> {
  @override
  Widget build(BuildContext context) {
    List<Event> events = widget.events;
    return GridView.count(
      primary: false,
      scrollDirection: Axis.vertical,
      crossAxisCount: 3, //items per row of the grid
      mainAxisSpacing: 0, //vertical spacing between the rows
      crossAxisSpacing: 0, //horizontal spacing between the items in a row
      childAspectRatio: 0.64, //maximum width of the items in a row
      children: events.map((event) => EventCard(event: event)).toList(),
    );
  }
}
