import 'package:course_project/db/firebase_cloud_utils.dart';

class Notification {
  int? id;
  String title, body, payload = "";
  DateTime? createdAt, scheduledAt;

  Notification({
    this.id,
    this.title = "",
    this.body = "",
    this.payload = "",
    this.createdAt,
    this.scheduledAt,
  });

  Notification.fromMap(Map<String, dynamic> map)
      : assert(map['title'] != null),
        assert(map['body'] != null),
        assert(map['payload'] != null),
        id = map['id'],
        title = map['title'],
        body = map['body'],
        payload = map['payload'],
        createdAt = DateTime.parse(map['createdAt']),
        scheduledAt = DateTime.parse(map['scheduledAt']);

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'payload': payload,
      'createdAt': (createdAt ?? DateTime.now()).toIso8601String(),
      'scheduledAt': (scheduledAt ?? DateTime.now()).toIso8601String(),
    };
  }
}
