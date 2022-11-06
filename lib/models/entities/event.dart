import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Event {
  static List<Color> defaultColors = [
    Color(0xFFF6625E),
    Color(0xFF836DB8),
    Color(0xFFDECB9C),
    Colors.white,
  ];

  int capacity, assistants, price = 0;
  String? id;
  String name, description, userId = "";
  DateTime? date;
  List<String>? images;
  List<Color>? colors;
  double rating;
  bool isPopular;
  DocumentReference? reference;

  Event({
    this.id,
    this.images,
    this.colors,
    this.date,
    this.rating = 0.0,
    this.isPopular = false,
    this.name = "",
    this.description = "",
    this.capacity = 0,
    this.assistants = 0,
    this.userId = "",
    this.price = 0,
  });

  Event.fromMap(Map<String, dynamic> map)
      : assert(map['date'] != null),
        assert(map['rating'] != null),
        assert(map['name'] != null),
        assert(map['description'] != null),
        assert(map['capacity'] != null),
        assert(map['assistants'] != null),
        id = map['id'],
        images = List<String>.from(map['images']),
        colors = List<Color>.from(map['colors']),
        date = DateTime.parse(map['date']),
        rating = map['rating'],
        isPopular = map['isPopular'],
        name = map['name'],
        description = map['description'],
        capacity = map['capacity'],
        assistants = map['assistants'],
        price = map['price'],
        userId = map['authorId'],
        reference = map['reference'];

  Map<String, Object?> toMap() {
    return {
      'name': name,
      'date': date,
      'capacity': capacity,
      'assistants': assistants,
      'colors': colors.toString(),
      'description': description,
      'images': images.toString(),
      'isPopular': isPopular,
      'rating': rating,
      'authorId': userId
    };
  }
}
