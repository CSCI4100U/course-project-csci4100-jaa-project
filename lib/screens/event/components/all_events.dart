import 'package:course_project/components/events_grid.dart';
import 'package:course_project/models/db_models/event_model.dart';
import 'package:course_project/models/entities/category.dart';
import 'package:course_project/models/entities/event.dart';
import 'package:course_project/screens/event/components/section_title.dart';
import 'package:flutter/material.dart';
import 'package:course_project/size_config.dart';

class AllEvents extends StatefulWidget {
  AllEvents({Key? key, required this.categoryFilter}) : super(key: key);

  final Category? categoryFilter;

  @override
  State<AllEvents> createState() => _AllEventsState();
}

class _AllEventsState extends State<AllEvents> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //SizedBox(height: getProportionateScreenHeight(20)),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              //SearchField(),
            ],
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: SectionTitle(
                  title: "All ${widget.categoryFilter?.name ?? ""} Events",
                  press: () {}),
            ),
            SizedBox(height: getProportionateScreenWidth(20)),
            Container(
              height: getProportionateScreenHeight(60000),
              child: StreamBuilder(
                stream: Stream.fromFuture(EventModel()
                    .getAllEvents(categoryFilter: widget.categoryFilter)),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Event> events = snapshot.data as List<Event>;
                    return GridEvents(events: events, whenReturn: whenReturn);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  void whenReturn() {
    setState(() {});
  }
}
