import 'package:course_project/models/db_models/event_model.dart';
import 'package:course_project/models/entities/event.dart';
import 'package:course_project/screens/event/components/search_field.dart';
import 'package:course_project/screens/event/components/section_title.dart';
import 'package:flutter/material.dart';
import 'package:course_project/components/event_card.dart';
import 'package:course_project/size_config.dart';

class AllEvents extends StatefulWidget {
  @override
  State<AllEvents> createState() => _AllEventsState();
}

class _AllEventsState extends State<AllEvents> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: getProportionateScreenHeight(20)),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              SearchField(),
            ],
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: SectionTitle(title: "All Events", press: () {}),
            ),
            SizedBox(height: getProportionateScreenWidth(20)),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: StreamBuilder(
                stream: Stream.fromFuture(EventModel().getAllEvents()),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Event> events = snapshot.data ?? [];
                    return Row(
                      children: [
                        ...List.generate(
                          events.length,
                          (index) {
                            if (events[index].isPopular) {
                              return EventCard(event: events[index]);
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                        SizedBox(width: getProportionateScreenWidth(20)),
                      ],
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            )
          ],
        ),
      ],
    );
  }
}
