import 'package:course_project/constants.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              "Notifications",
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            _generateNotificationsListView([]),
          ],
        ),
      ),
      // child: StreamBuilder(
      //   stream: ,
      //   body:
      // );
    );
  }

  Widget _generateNotificationsListView(List<Notification> notifications) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text("Notification $index"),
        );
      },
    );
  }
}
