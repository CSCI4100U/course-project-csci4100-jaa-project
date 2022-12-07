import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class Category {
  String _name = "";

  get name => _name;
  set name(value) => _name = value;

  int? id;
  String description, imagesPath = "";
  Icon? icon;
  List<String>? images = [];
  List<String> eventsIds = [];

  Category({
    this.id,
    name = "",
    this.description = "",
    this.imagesPath = "",
    this.icon,
    this.images = const [],
    this.eventsIds = const [],
  }) {
    _name = name;
  }

  Category.fromMap(Map<String, dynamic> map)
      : assert(map['name'] != null),
        assert(map['description'] != null),
        assert(map['eventsIds'] != null),
        assert(map['imagesPath'] != null),
        id = map['id'],
        _name = map['name'],
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

  String i18nName(BuildContext context) {
    return FlutterI18n.translate(context, "categories.$name");
  }
}
