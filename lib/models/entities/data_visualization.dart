import 'dart:convert';
import 'package:flutter/material.dart';

class DataVisualization {
  int? id;
  String name, description;
  Icon? icon;

  DataVisualization({
    this.id,
    this.name = "",
    this.description = "",
    this.icon,
  });

  DataVisualization.fromMap(Map<String, dynamic> map)
      : assert(map['name'] != null),
        assert(map['description'] != null),
        id = map['id'],
        name = map['name'],
        description = map['description'],
        icon = Icon(IconData(map['icon'], fontFamily: 'MaterialIcons'));

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'icon': icon?.icon?.codePoint,
    };
  }
}
