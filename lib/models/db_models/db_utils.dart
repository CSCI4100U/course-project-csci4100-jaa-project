import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DBUtils {
  static Future init() async {
    //Set up the database
    //Set up the categories table
    var database = openDatabase(
      path.join(await getDatabasesPath(), 'events_project_application.db'),
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE categories(id INTEGER PRIMARY KEY, name TEXT, description TEXT, imagesPath TEXT, icon INTEGER, eventsIds TEXT, images TEXT)');
      },
      version: 1,
    );

    return database;
  }
}
