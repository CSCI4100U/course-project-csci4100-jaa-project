import 'dart:convert';
import 'package:flutter/material.dart';

class Category {
  int? id;
  String name, description, imagesPath = "";
  Icon? icon;
  List<String>? images = [];
  List<String> eventsIds = [];

  Category({
    this.id,
    this.name = "",
    this.description = "",
    this.imagesPath = "",
    this.icon,
    this.images = const [],
    this.eventsIds = const [],
  });

  Category.fromMap(Map<String, dynamic> map)
      : assert(map['name'] != null),
        assert(map['description'] != null),
        assert(map['eventsIds'] != null),
        assert(map['imagesPath'] != null),
        id = map['id'],
        name = map['name'],
        description = map['description'],
        imagesPath = map['imagesPath'],
        icon = Icon(IconData(map['icon'], fontFamily: 'MaterialIcons')),
        eventsIds = List<String>.from(jsonDecode(map['eventsIds'])),
        images = List<String>.from(jsonDecode(map['images']));

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imagesPath': imagesPath,
      'icon': icon?.icon?.codePoint,
      'eventsIds': jsonEncode(eventsIds),
      'images': jsonEncode(images),
    };
  }
}
