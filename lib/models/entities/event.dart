import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_project/db/firebase_cloud_utils.dart';
import 'package:flutter/material.dart';

class Event {
  static List<Color> defaultColors = [
    Color(0xFFF6625E),
    Color(0xFF836DB8),
    Color(0xFFDECB9C),
    Colors.white,
  ];

  int? capacity;
  int assistants;
  double? price;
  String? id;
  String name, description, userId;
  DateTime? date, createdAt;
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
  }) {
    colors ??= defaultColors;
    images ??= [];
    createdAt = DateTime.now();
  }

  Event.fromMap(Map<String, dynamic> map)
      : assert(map['date'] != null),
        assert(map['rating'] != null),
        assert(map['name'] != null),
        assert(map['capacity'] != null),
        assert(map['assistants'] != null),
        id = map['id'],
        images = map['images'].map<String>((img) => img.toString()).toList(),
        colors = map['colors'].map<Color>((color) => Color(color)).toList(),
        rating = map['rating'],
        isPopular = map['isPopular'],
        name = map['name'],
        description = map['description'] ?? "",
        capacity = map['capacity'],
        assistants = map['assistants'],
        price = map['price'],
        userId = map['userId'],
        date = FireBaseCloudUtil.parseTimeStamp(map['date']),
        createdAt = FireBaseCloudUtil.parseTimeStamp(map['createdAt']),
        reference = map['reference'];

  Map<String, Object?> toMap() {
    return {
      'name': name,
      'date': date,
      'capacity': capacity,
      'assistants': assistants,
      'price': price ?? 0,
      'colors': colors?.map((color) => color.value).toList() ?? [],
      'description': description,
      'images': images,
      'isPopular': isPopular,
      'rating': rating,
      'createdAt': createdAt,
      'userId': userId
    };
  }
}
