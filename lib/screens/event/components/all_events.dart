import 'package:course_project/components/events_grid.dart';
import 'package:course_project/models/db_models/event_model.dart';
import 'package:course_project/models/entities/category.dart';
import 'package:course_project/models/entities/event.dart';
import 'package:course_project/screens/event/components/section_title.dart';
import 'package:flutter/material.dart';
import 'package:course_project/size_config.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class AllEvents extends StatefulWidget {
  AllEvents({Key? key, required this.categoryFilter}) : super(key: key);

  final Category? categoryFilter;

  @override
  State<AllEvents> createState() => _AllEventsState();
}

class _AllEventsState extends State<AllEvents> {
  final i18nKey = "event_screen.all_events";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [],
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: SectionTitle(
                  title: FlutterI18n.translate(
                    context,
                    "$i18nKey.title",
                    translationParams: {
                      "categoryFilter":
                          widget.categoryFilter?.i18nName(context) ?? "",
                      "connectionFilter": FlutterI18n.plural(
                        context,
                        "$i18nKey.connection_filter",
                        widget.categoryFilter != null ? 1 : 0,
                      ),
                    },
                  ),
                  press: () {}),
            ),
            SizedBox(height: getProportionateScreenWidth(20)),
            SizedBox(
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
