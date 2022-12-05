import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_project/constants.dart';
import 'package:course_project/db/firebase_cloud_utils.dart';
import 'package:course_project/models/db_models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class Event {
  int? capacity, _categoryId;
  int assistants;
  double? price;
  String? id;
  String name, description, userId;
  DateTime? date, createdAt;
  List<String>? images;
  double rating;
  bool isPopular;
  DocumentReference? reference;
  GeoPoint? location;

  Event({
    this.id,
    this.images,
    this.date,
    this.rating = 0.0,
    this.isPopular = false,
    this.name = "",
    this.description = "",
    this.capacity = 0,
    this.assistants = 0,
    this.userId = "",
    this.price = 0,
    this.location,
  }) {
    if (images == null) {
      _getImagesFromCategory().then((value) => images = value);
    }
    createdAt = DateTime.now();
  }

  int? get categoryId => _categoryId;
  set categoryId(int? categoryId) {
    _categoryId = categoryId;
    _getImagesFromCategory().then((value) => images = value);
  }

  Event.fromMap(Map<String, dynamic> map)
      : assert(map['date'] != null),
        assert(map['rating'] != null),
        assert(map['name'] != null),
        assert(map['capacity'] != null),
        assert(map['assistants'] != null),
        id = map['id'],
        images = map['images'].map<String>((img) => img.toString()).toList(),
        rating = map['rating'],
        isPopular = map['isPopular'],
        name = map['name'],
        description = map['description'] ?? "",
        capacity = map['capacity'],
        assistants = map['assistants'],
        price = map['price'].toDouble(),
        userId = map['userId'],
        date = FireBaseCloudUtil.parseTimeStamp(map['date']),
        createdAt = FireBaseCloudUtil.parseTimeStamp(map['createdAt']),
        _categoryId = map['categoryId'],
        reference = map['reference'],
        location = map['location'];

  Map<String, Object?> toMap() {
    return {
      'name': name,
      'date': date,
      'capacity': capacity,
      'assistants': assistants,
      'price': price ?? 0.0,
      'description': description,
      'images': images,
      'isPopular': isPopular,
      'rating': rating,
      'createdAt': createdAt,
      'categoryId': categoryId,
      'userId': userId,
      'location': location,
    };
  }

  String stringDate() {
    return DateFormatDisplay.format(date!);
  }

  Future<List<String>> _getImagesFromCategory({int? totalImages}) async {
    String imagesDirectoryPath = "assets/images/categories/no_category";
    if (categoryId != null) {
      var category = await CategoryModel().getCategoryWithId(categoryId!);
      imagesDirectoryPath = category.imagesPath;
    }
    List<String> imagesPath = await _listOfPaths(imagesDirectoryPath);
    imagesPath.shuffle();
    totalImages ??= Random().nextInt(5);
    return imagesPath.take(totalImages).toList();
  }

  Future<List<String>> _listOfPaths(String directory) async {
    var manifestContent = await rootBundle.loadString('AssetManifest.json');
    Map<String, dynamic> manifestMap = json.decode(manifestContent);
    return manifestMap.keys
        .where((String key) => key.contains(directory))
        .toList();
  }
}
