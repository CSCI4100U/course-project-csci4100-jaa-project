import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_project/models/entities/event.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:course_project/db/firebase_cloud_utils.dart';

class EventModel {
  //Inserts an event into the database
  Future insertEvent(Event event, User author) async {
    final data = event.toMap();
    data.addAll({'userId': author.uid});
    await FirebaseFirestore.instance.collection('events').doc().set(data);
  }

  //Gets all events from the database
  Future<List<Event>> getAllEvents() async {
    var snapshot = await FirebaseFirestore.instance
        .collection('events')
        .orderBy('createdAt')
        .get();
    var events = snapshot.docs
        .map<Event>((doc) =>
            Event.fromMap(FireBaseCloudUtil.generateDocumentMap((doc))))
        .toList();
    return events;
  }

  //Gets all popular events from the database
  Future<List<Event>> getPopularEvents() async {
    var snapshot = await FirebaseFirestore.instance
        .collection('events')
        .orderBy('createdAt')
        .where('isPopular', isEqualTo: true)
        .get();
    var events = snapshot.docs
        .map<Event>((doc) =>
            Event.fromMap(FireBaseCloudUtil.generateDocumentMap((doc))))
        .toList();
    return events;
  }

  //Gets all events created by the user from the database
  Future<List<Event>> getUserEvents(User user) async {
    var snapshot = await FirebaseFirestore.instance
        .collection('events')
        .orderBy('createdAt')
        .where('userId', isEqualTo: user.uid)
        .get();
    var events = snapshot.docs
        .map<Event>((doc) =>
            Event.fromMap(FireBaseCloudUtil.generateDocumentMap((doc))))
        .toList();
    return events;
  }

  //Updates an event in the database
  Future updateEvent(Event event) async {
    final data = event.toMap();
    await event.reference!.update(data);
  }

  //Deletes an event from the database
  Future deleteEvent(Event event) async {
    await event.reference!.delete();
  }
}
