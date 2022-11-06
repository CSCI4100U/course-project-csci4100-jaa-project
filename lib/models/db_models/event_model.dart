import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_project/models/entities/event.dart';
import 'package:course_project/models/entities/favorite.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:course_project/db/firebase_cloud_utils.dart';

class EventModel {
  Future insertEvent(Event event, User author) async {
    final data = event.toMap();
    data.addAll({'userId': author.uid});
    await FirebaseFirestore.instance.collection('events').doc().set(data);
  }

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

  Future<List<Event>> getFavoriteEvents(User user) async {
    var favoritesEventsIds = await getFavoritesEventsIds(user);
    var eventsSnapshot = await FirebaseFirestore.instance
        .collection('events')
        .orderBy('createdAt')
        .where(FieldPath.documentId, whereIn: favoritesEventsIds)
        .get();
    var events = eventsSnapshot.docs
        .map<Event>(
            (doc) => Event.fromMap(FireBaseCloudUtil.generateDocumentMap(doc)))
        .toList();
    return events;
  }

  Future updateEvent(Event event) async {
    final data = event.toMap();
    await event.reference!.update(data);
  }

  Future deleteEventWithId(Event event) async {
    await event.reference!.delete();
  }

  Future<List<String>> getFavoritesEventsIds(User user) async {
    var snapshot = await FirebaseFirestore.instance
        .collection('favorites')
        .where('userId', isEqualTo: user.uid)
        .get();
    return snapshot.docs.map<String>((doc) => doc.id).toList();
  }
}
