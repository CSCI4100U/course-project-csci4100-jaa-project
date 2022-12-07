import 'package:course_project/auth/fire_auth.dart';
import 'package:course_project/constants.dart';
import 'package:course_project/models/entities/event.dart';
import 'package:course_project/components/events_grid.dart';
import 'package:flutter/material.dart';
import 'package:course_project/models/db_models/event_model.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../../../size_config.dart';
import 'section_title.dart';

class AssistedEventsDisplay extends StatefulWidget {
  static String routeName = '/assistedEventsList';

  const AssistedEventsDisplay({super.key});

  @override
  State<AssistedEventsDisplay> createState() => _AssistedEventsDisplayState();
}

class _AssistedEventsDisplayState extends State<AssistedEventsDisplay> {
  final i18nKey = "home_screen.assisted_events_display";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          FlutterI18n.translate(context, "$i18nKey.title"),
          style: const TextStyle(color: kPrimaryColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: const Text(""),
            ),
            _buildProductList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProductList(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(695),
      padding: const EdgeInsets.all(20),
      child: StreamBuilder(
        stream: Stream.fromFuture(
            EventModel().getAssistedEvents(FireAuth.getCurrentUser())),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          List<Event> events = snapshot.data as List<Event>;
          return GridEvents(events: events, whenReturn: whenReturn);
        },
      ),
    );
  }

  void whenReturn() {
    setState(() {});
  }
}
