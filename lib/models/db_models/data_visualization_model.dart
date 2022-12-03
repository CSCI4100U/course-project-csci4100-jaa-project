import '../entities/data_visualization.dart';
import 'db_utils.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';

class DataVisualizationModel {
  final String tableName = 'visualizations';

  // Inserts a data visualization into the local database
  Future<int> insertDataVisualization(DataVisualization dataVisualization) async {
    final db = await DBUtils.init();
    dataVisualization.toMap();
    return await db.insert(
      tableName,
      dataVisualization.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Gets all data visualizations from the local database
  Future getAllDataVisualizations() async {
    try {
      final db = await DBUtils.init();
      final List maps = await db.query(tableName);
      print(maps.length);
      return maps.map((map) => DataVisualization.fromMap(map)).toList();
    } catch (e) {
      print(e);
    }
  }

  // Updates a data visualization in the local database
  Future<int> updateDataVisualization(DataVisualization dataVisualization) async {
    final db = await DBUtils.init();
    return db.update(
      tableName,
      dataVisualization.toMap(),
      where: 'id = ?',
      whereArgs: [dataVisualization.id],
    );
  }

  // Deletes a data visualization from the local database
  Future<int> deleteDataVisualizationWithId(int id) async {
    final db = await DBUtils.init();
    return db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Gets a data visualization from the local database by id
  Future getDataVisualizationWithId(int id) async {
    final db = await DBUtils.init();
    final List maps = await db.query(
        tableName,
        where: 'id = ?',
        whereArgs: [id]
    );
    return DataVisualization.fromMap(maps[0]);
  }
}
