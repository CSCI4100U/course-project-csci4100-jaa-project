// ignore_for_file: use_build_context_synchronously

import 'package:course_project/auth/fire_auth.dart';
import 'package:course_project/constants.dart';
import 'package:course_project/models/db_models/event_model.dart';
import 'package:course_project/models/db_models/notifications_model.dart';
import 'package:course_project/models/notifications.dart';
import 'package:course_project/models/entities/event.dart';
import 'package:course_project/theme.dart';
import 'package:flutter/material.dart';
import 'package:course_project/size_config.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import '../../event_form/event_form.dart';
import 'icon_btn_with_counter.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  final i18nKey = "home_screen.home_header";

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.fromFuture(NotificationModel().getNotificationsCount()),
      builder: (context, snapshot) {
        int? notificationsTotal =
            snapshot.hasData ? snapshot.data as int : null;

        return Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconBtnWithCounter(
                icon: Icon(
                  color: kPrimaryColor,
                  semanticLabel: FlutterI18n.translate(
                    context,
                    "$i18nKey.add_event",
                  ),
                  Icons.add,
                ),
                press: () async => await _showEventForm(context),
              ),
              const SizedBox(width: 10),
              notificationsTotal != null
                  ? IconBtnWithCounter(
                      icon: Icon(
                        color: kPrimaryColor,
                        semanticLabel: FlutterI18n.translate(
                          context,
                          "$i18nKey.view_notifications",
                        ),
                        Icons.notifications,
                      ),
                      numOfitem: notificationsTotal,
                      press: () async =>
                          await Navigator.pushNamed(context, "/notifications"),
                    )
                  : IconButton(
                      icon: Icon(
                        semanticLabel: FlutterI18n.translate(
                          context,
                          "$i18nKey.view_notifications",
                        ),
                        Icons.notifications,
                      ),
                      onPressed: () async =>
                          await Navigator.pushNamed(context, "/notifications"),
                    )
            ],
          ),
        );
      },
    );
  }

  Future _showEventForm(BuildContext context) async {
    Event? event =
        await Navigator.pushNamed(context, EventForm.routeName) as Event?;
    if (event != null) {
      bool addEvent = await _showAddQuestionDialog(context) as bool;
      if (addEvent) {
        await EventModel().insertEvent(event, FireAuth.getCurrentUser());
        _showSnackBar(
          context,
          FlutterI18n.translate(
            context,
            "$i18nKey.event_added",
            translationParams: {"name": event.name},
          ),
        );
      } else {
        _showSnackBar(
          context,
          FlutterI18n.translate(
            context,
            "$i18nKey.event_added",
            translationParams: {"name": event.name},
          ),
        );
      }
    }
  }

  Future _showAddQuestionDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(
            FlutterI18n.translate(
              context,
              "$i18nKey.add_event_confirmation.title",
            ),
          ),
          children: [
            SimpleDialogOption(
              child: Text(
                FlutterI18n.translate(
                  context,
                  "$i18nKey.add_event_confirmation.yes_option",
                ),
                style: const TextStyle(color: kPrimaryColor),
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
            SimpleDialogOption(
              child: Text(
                FlutterI18n.translate(
                  context,
                  "$i18nKey.add_event_confirmation.no_option",
                ),
                style: const TextStyle(color: kPrimaryColor),
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
