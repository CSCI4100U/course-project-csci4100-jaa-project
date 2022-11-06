import 'package:cloud_firestore/cloud_firestore.dart';

class Favorite {
  String id, eventId, userId = "";
  DocumentReference? reference;

  Favorite.fromMap(Map<String, dynamic> map)
      : assert(map['id'] != null),
        assert(map['eventId'] != null),
        assert(map['userId'] != null),
        id = map['id'],
        eventId = map['eventId'],
        userId = map['userId'],
        reference = map['reference'];

  Map<String, Object?> toMap() {
    return {
      'eventId': eventId,
      'userId': userId,
    };
  }
}
