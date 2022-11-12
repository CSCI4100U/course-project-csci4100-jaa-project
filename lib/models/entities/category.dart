import 'dart:convert';
import 'package:flutter/material.dart';

class Category {
  int? id;
  String name, description = "";
  Icon? icon;
  List<String>? images = [];
  List<String> eventsIds = [];

  Category({
    this.id,
    this.name = "",
    this.description = "",
    this.icon,
    this.images = const [],
    this.eventsIds = const [],
  });

  Category.fromMap(Map<String, dynamic> map)
      : assert(map['name'] != null),
        assert(map['description'] != null),
        assert(map['eventsIds'] != null),
        id = map['id'],
        name = map['name'],
        description = map['description'],
        icon = Icon(IconData(map['icon'], fontFamily: 'MaterialIcons')),
        eventsIds = List<String>.from(jsonDecode(map['eventsIds'])),
        images = List<String>.from(jsonDecode(map['images']));

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'icon': icon?.icon?.codePoint,
      'eventsIds': jsonEncode(eventsIds),
      'images': jsonEncode(images),
    };
  }
}
