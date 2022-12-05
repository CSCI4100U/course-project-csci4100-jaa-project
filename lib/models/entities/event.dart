import 'dart:convert';
import 'dart:math';
import 'dart:io' as io;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_project/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'package:course_project/db/firebase_cloud_utils.dart';
import 'package:course_project/models/db_models/category_model.dart';
import 'package:course_project/models/entities/assistant.dart';

class Event {
  int? capacity, _categoryId;
  double? price;
  String? id;
  String name, description, userId;
  DateTime? date, createdAt;
  List<String>? images;
  List<String> assistantsIds = [];
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
        id = map['id'],
        images = map['images'].map<String>((img) => img.toString()).toList(),
        rating = map['rating'],
        isPopular = map['isPopular'],
        name = map['name'],
        description = map['description'] ?? "",
        capacity = map['capacity'],
        price = map['price'].toDouble(),
        userId = map['userId'],
        date = FireBaseCloudUtil.parseTimeStamp(map['date']),
        createdAt = FireBaseCloudUtil.parseTimeStamp(map['createdAt']),
        _categoryId = map['categoryId'],
        reference = map['reference'],
        location = map['location'],
        assistantsIds = map['assistantsIds']
                ?.map<String>((assistant) => assistant.toString())
                ?.toList() ??
            [];

  Map<String, Object?> toMap() {
    return {
      'name': name,
      'date': date,
      'capacity': capacity,
      'price': price ?? 0.0,
      'description': description,
      'images': images,
      'isPopular': isPopular,
      'rating': rating,
      'createdAt': createdAt,
      'categoryId': categoryId,
      'userId': userId,
      'location': location,
      'assistantsIds': assistantsIds ?? [],
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
