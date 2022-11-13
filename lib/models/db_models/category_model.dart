import 'db_utils.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:course_project/models/entities/category.dart';

class CategoryModel {
  //Inserts a category into the local database
  Future<int> insertCategory(Category category) async {
    final db = await DBUtils.init();
    category.toMap();
    return await db.insert(
      'categories',
      category.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //Gets all categories from the local database
  Future getAllCategories() async {
    try {
      final db = await DBUtils.init();
      final List maps = await db.query('categories');
      print(maps.length);
      return maps.map((map) => Category.fromMap(map)).toList();
    } catch (e) {
      print(e);
    }
  }

  //Updates a category in the local database
  Future<int> updateCategory(Category category) async {
    final db = await DBUtils.init();
    return db.update(
      'categories',
      category.toMap(),
      where: 'id = ?',
      whereArgs: [category.id],
    );
  }

  //Deletes a category from the local database
  Future<int> deleteCategoryWithId(int id) async {
    final db = await DBUtils.init();
    return db.delete(
      'categories',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  //Gets a category from the local database by id
  Future getCategoryWithId(int id) async {
    final db = await DBUtils.init();
    final List maps =
        await db.query('categories', where: 'id = ?', whereArgs: [id]);
    return Category.fromMap(maps[0]);
  }
}
