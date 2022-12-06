import 'package:course_project/models/entities/event.dart';
import 'package:flutter/material.dart';
import 'package:course_project/components/event_card.dart';

class GridEvents extends StatefulWidget {
  const GridEvents({
    Key? key,
    required this.events,
    required this.whenReturn,
  }) : super(key: key);

  final List<Event> events;
  final void Function() whenReturn;

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
      children: events
          .map((event) => EventCard(
                event: event,
                whenReturn: widget.whenReturn,
              ))
          .toList(),
    );
  }
}
