import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DBUtils {
  static Future init() async {
    //Set up the database
    //Set up the categories table
    // Set up the data visualizations table
    /// first run with version 1, then restart and run again with version 2
    var database = openDatabase(
      path.join(await getDatabasesPath(), 'events_project_application.db'),
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE categories(id INTEGER PRIMARY KEY, name TEXT, description TEXT, imagesPath TEXT, icon INTEGER, eventsIds TEXT, images TEXT)');
      },
      onUpgrade: ((db, oldVersion, newVersion) => {
            if (oldVersion < 2)
              {
                db.execute(
                    'CREATE TABLE visualizations (id INTEGER PRIMARY KEY, name TEXT, description TEXT, icon INTEGER)')
              },
            if (oldVersion < 3)
              {
                db.execute(
                    'CREATE TABLE IF NOT EXISTS notifications(id INTEGER PRIMARY KEY, title TEXT, body TEXT, payload TEXT, createdAt TEXT, scheduledAt TEXT)')
              }
          }),
      version: 3,
    );

    return database;
  }
}
