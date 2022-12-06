import 'package:course_project/constants.dart';
import 'package:course_project/models/db_models/notifications_model.dart';
import 'package:course_project/models/entities/notification.dart'
    as notification;
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final i18nKey = "notifications_screen.body";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              FlutterI18n.translate(context, "$i18nKey.title"),
              style: const TextStyle(
                color: kPrimaryColor,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            StreamBuilder(
              stream:
                  Stream.fromFuture(NotificationModel().getAllNotifications()),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<notification.Notification> notifications =
                      snapshot.data as List<notification.Notification>;
                  return _notificationsListView(notifications);
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _notificationsListView(List<notification.Notification> notifications) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        var notification = notifications[index];
        return ListTile(
          title: Text(
            notification.title,
            style: TextStyle(color: Colors.blueGrey),
          ),
          subtitle: Text(
            notification.body,
            style: TextStyle(color: Colors.grey),
          ),
          trailing:
              Text(DateFormatDisplayShort.format(notification.createdAt!)),
        );
      },
    );
  }
}
