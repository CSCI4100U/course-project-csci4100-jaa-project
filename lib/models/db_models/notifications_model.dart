import 'db_utils.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:course_project/models/entities/notification.dart';
import 'package:course_project/constants.dart';

class NotificationModel {
  //Inserts a notification into the local database
  Future<int> insertNotification(Notification notification,
      {bool now = false, bool scheduled = false}) async {
    final db = await DBUtils.init();
    var id = await db.insert(
      'notifications',
      notification.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    notification.id = id;
    print('id: $id');
    if (now) {
      NotificationsConst.sendNotificationNow(notification);
    }
    if (scheduled) {
      NotificationsConst.sendNotificationLater(notification);
    }
    return id;
  }

  //Gets all notifications from the local database
  Future<List<Notification>> getAllNotifications() async {
    try {
      final db = await DBUtils.init();
      final List maps = await db.query('notifications');
      return maps.map((map) => Notification.fromMap(map)).toList();
    } catch (e) {
      print(e);
    }
    return [];
  }

  //Updates a notification in the local database
  Future<int> updateNotification(Notification notification) async {
    final db = await DBUtils.init();
    return db.update(
      'notifications',
      notification.toMap(),
      where: 'id = ?',
      whereArgs: [notification.id],
    );
  }

  //Deletes a notification from the local database
  Future<int> deleteNotificationWithId(int id) async {
    final db = await DBUtils.init();
    return db.delete(
      'notifications',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  //Gets a notification from the local database by id
  Future getNotificationWithId(int id) async {
    final db = await DBUtils.init();
    final List maps =
        await db.query('notifications', where: 'id = ?', whereArgs: [id]);
    return Notification.fromMap(maps[0]);
  }

  Future<int> getNotificationsCount() async {
    final db = await DBUtils.init();
    return (await db.query('notifications')).length;
  }
}
