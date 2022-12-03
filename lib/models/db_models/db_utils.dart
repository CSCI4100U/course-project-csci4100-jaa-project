import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DBUtils {
  static Future init() async {
    //Set up the database
    //Set up the categories table
    // Set up the data visualizations table
    var database = openDatabase(
      path.join(await getDatabasesPath(), 'events_project_application_10.db'),
      onCreate: (db, version) {
        db.execute(
            //'CREATE TABLE IF NOT EXISTS visualizations (id INTEGER PRIMARY KEY, name TEXT, description TEXT, icon INTEGER)');
            'CREATE TABLE categories(id INTEGER PRIMARY KEY, name TEXT, description TEXT, imagesPath TEXT, icon INTEGER, eventsIds TEXT, images TEXT)');
      },
      onUpgrade: ((db, oldVersion, newVersion) => {
        if (oldVersion < 2) {
          db.execute('CREATE TABLE visualizations (id INTEGER PRIMARY KEY, name TEXT, description TEXT, icon INTEGER)')
        }
      }),
      version: 2,
    );

    return database;
  }
}
