import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'package:course_project/models/db_models/event.dart';

import '../../../size_config.dart';
import 'section_title.dart';

class EventsList extends StatefulWidget {
  const EventsList({super.key});

  @override
  State<EventsList> createState() => _EventsListState();
}

class _EventsListState extends State<EventsList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
            title: "Events for you",
            press: () {},
          ),
        ),
        _buildProductList(context),
      ]
    );
  }

  Future getEvents() async{
    return await FirebaseFirestore.instance.collection('events').get();
  }

  Widget _buildEvent(BuildContext context, DocumentSnapshot eventData){
    final event = Event.fromMap(
        eventData.data(),
        reference: eventData.reference);
    return GestureDetector(
      child: ListTile(
        title: Text(event.name!),
        subtitle: Text(event.date!),
        trailing: Text(event.time!),
      ),
    );
  }

  Widget _buildProductList(BuildContext context){
    return FutureBuilder(
        future: getEvents(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if (!snapshot.hasData){
            return CircularProgressIndicator();
          }
          return ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: EdgeInsets.all(16),
            children: snapshot.data.docs.map<Widget>( (document)
              => _buildEvent(context, document)
            ).toList(),
          );
        }
    );
  }

}
