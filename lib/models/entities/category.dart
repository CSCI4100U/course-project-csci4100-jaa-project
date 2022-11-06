import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Category {
  String id, name, description = "";
  List<String> eventsIds = [];
  DocumentReference? reference;

  Category.fromMap(Map<String, dynamic> map)
      : assert(map['id'] != null),
        assert(map['name'] != null),
        assert(map['description'] != null),
        assert(map['eventsIds'] != null),
        id = map['id'],
        name = map['name'],
        description = map['description'],
        eventsIds = List<String>.from(map['eventsIds']),
        reference = map['reference'];

  Map<String, Object?> toMap() {
    return {
      'name': name,
      'description': description,
      'eventsIds': eventsIds,
    };
  }
}
