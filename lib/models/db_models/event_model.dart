import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:course_project/models/db_models/notifications_model.dart';
import 'package:course_project/models/entities/notification.dart';
import 'package:course_project/models/notifications.dart';
import 'package:course_project/models/entities/category.dart';
import 'package:course_project/models/entities/event.dart';
import 'package:course_project/db/firebase_cloud_utils.dart';

class EventModel {
  final _notifications = Notifications();

  //Inserts an event into the database
  Future insertEvent(Event event, User author) async {
    final data = event.toMap();
    data.addAll({'userId': author.uid});
    await FirebaseFirestore.instance.collection('events').doc().set(data);

    var createdEvent = Notification(
      title: 'Event ${event.name} created',
      body: 'Starting in ${event.stringDate()}',
      payload: 'Event id: ${event.id}',
    );
    await NotificationModel().insertNotification(createdEvent, now: true);
  }

  //Gets all events from the database
  Future<List<Event>> getAllEvents(
      {Category? categoryFilter, bool withLocation: false}) async {
    try {
      var eventsQuery =
          FirebaseFirestore.instance.collection('events').orderBy('createdAt');
      if (categoryFilter != null) {
        eventsQuery =
            eventsQuery.where('categoryId', isEqualTo: categoryFilter.id);
      }
      var snapshot = await eventsQuery.get();
      var events = snapshot.docs
          .map<Event>((doc) =>
              Event.fromMap(FireBaseCloudUtil.generateDocumentMap((doc))))
          .toList();
      if (withLocation) {
        events = events.where((event) => event.location != null).toList();
      }
      return events;
    } catch (e) {
      print(e);
    }
    return [];
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

  //Returns if user assist to an event
  static bool userAssists(Event event, User currentUser) {
    return event.assistantsIds.contains(currentUser.uid);
  }

  static Future addAssistant(Event event, User currentUser) async {
    event.assistantsIds.add(currentUser.uid);
    await event.reference!.update({'assistantsIds': event.assistantsIds});
  }

  static Future removeAssistant(Event event, User currentUser) async {
    event.assistantsIds.remove(currentUser.uid);
    await event.reference!.update({'assistantsIds': event.assistantsIds});
  }

  static Future<int> getTotalAssistants(Event event) async {
    var data = (await event.reference!.get()).data() as Map<String, dynamic>;
    return data['assistantsIds'].length;
  }

  static Future<bool> isFull(Event event) async {
    var data = (await event.reference!.get()).data() as Map<String, dynamic>;
    return data['assistantsIds'].length >= data['capacity'];
  }
}
