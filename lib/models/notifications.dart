import 'dart:io';
import 'package:course_project/models/entities/notification.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart';

class Notifications {
  final channelId = "Events Application Notifications";
  final channelName = "Events Application Notifications";
  final channelDescription =
      "Channel for notifications of the events application";
  bool isInitialized = false;

  //Configure plugin using platform specific details
  var _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  NotificationDetails? _platformChannelInfo;

  // Request permission to show notifications
  Future init() async {
    if (Platform.isIOS) {
      _requestIOSPermission();
    }

    var initializationSettingsAndroid =
        AndroidInitializationSettings('mipmap/ic_launcher');

    var initializationSettingsIOS = DarwinInitializationSettings(
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) {},
    );

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );

    var androidChannelInfo = AndroidNotificationDetails(channelId, channelName,
        channelDescription: channelDescription);

    var iosChannelInfo = DarwinNotificationDetails();

    _platformChannelInfo = NotificationDetails(
      android: androidChannelInfo,
      iOS: iosChannelInfo,
    );
    isInitialized = true;
  }

  void sendNotificationNow(Notification notification) {
    _flutterLocalNotificationsPlugin.show(
      notification.id!,
      notification.title,
      notification.body,
      _platformChannelInfo,
      payload: notification.payload,
    );
  }

  Future sendNotificationLater(Notification notification) {
    var when = TZDateTime.from(
      notification.scheduledAt!,
      getLocation('Canada/Eastern'),
    );
    return _flutterLocalNotificationsPlugin.zonedSchedule(
      notification.id!,
      notification.title,
      notification.body,
      when,
      _platformChannelInfo!,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      payload: notification.payload,
    );
  }

  Future<List<PendingNotificationRequest>>
      getPendingNotificationRequests() async {
    return _flutterLocalNotificationsPlugin.pendingNotificationRequests();
  }

  Future onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    if (notificationResponse != null) {
      print("NotificationResponse::payload = "
          "${notificationResponse.payload}");
    }
  }

  _requestIOSPermission() {
    _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()!
        .requestPermissions(
          sound: true,
          badge: true,
          alert: true,
        );
  }
}
