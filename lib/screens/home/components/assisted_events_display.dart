import 'package:course_project/auth/fire_auth.dart';
import 'package:course_project/models/entities/event.dart';
import 'package:course_project/components/events_grid.dart';
import 'package:flutter/material.dart';
import 'package:course_project/models/db_models/event_model.dart';

import '../../../size_config.dart';
import 'section_title.dart';

class AssistedEventsDisplay extends StatefulWidget {
  static String routeName = '/assistedEventsList';
  AssistedEventsDisplay({super.key});

  @override
  State<AssistedEventsDisplay> createState() => _AssistedEventsDisplayState();
}

class _AssistedEventsDisplayState extends State<AssistedEventsDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Events I'm Assisting"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: const Text("Events I'm Assisting",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey)
              ),
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