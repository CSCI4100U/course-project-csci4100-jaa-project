import 'package:course_project/models/db_models/event_model.dart';
import 'package:course_project/models/entities/event.dart';
import 'package:flutter/material.dart';
import 'package:course_project/components/event_card.dart';
import 'package:course_project/size_config.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'section_title.dart';

class PopularEvents extends StatefulWidget {
  @override
  State<PopularEvents> createState() => _PopularEventsState();
}

class _PopularEventsState extends State<PopularEvents> {
  final i18nKey = "home_screen.popular_events";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
            title: FlutterI18n.translate(context, "$i18nKey.title"),
            press: () {},
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: StreamBuilder(
            stream: Stream.fromFuture(EventModel().getPopularEvents()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Event> events = snapshot.data ?? [];
                return Padding(
                  padding: const EdgeInsets.only(right: 20, bottom: 20),
                  child: Row(
                    children: events
                        .map((event) => EventCard(
                              event: event,
                              whenReturn: whenReturn,
                            ))
                        .toList(),
                  ),
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        )
      ],
    );
  }

  void whenReturn() {
    setState(() {});
  }
}
