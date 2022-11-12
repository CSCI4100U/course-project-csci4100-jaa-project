import 'package:course_project/auth/fire_auth.dart';
import 'package:course_project/models/db_models/event_model.dart';
import 'package:course_project/models/entities/event.dart';
import 'package:flutter/material.dart';
import 'package:course_project/size_config.dart';
import '../../event_form/event_form.dart';
import 'icon_btn_with_counter.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconBtnWithCounter(
            icon: const Icon(Icons.add),
            press: () async => await _showEventForm(context),
          ),
          const SizedBox(width: 10),
          IconBtnWithCounter(
            svgSrc: "assets/icons/Bell.svg",
            numOfitem: 3,
            press: () {},
          ),
        ],
      ),
    );
  }

  Future _showEventForm(BuildContext context) async {
    Event? event =
        await Navigator.pushNamed(context, EventForm.routeName) as Event?;
    if (event != null) {
      bool addEvent = await _showAddQuestionDialog(context) as bool;
      if (addEvent) {
        await EventModel().insertEvent(event, FireAuth.getCurrentUser());
        _showSnackBar(context, 'Event ${event.name} added');
      } else {
        _showSnackBar(context, 'Event ${event.name} not added');
      }
    }
  }

  Future _showAddQuestionDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Would you like to create this event?'),
          children: [
            SimpleDialogOption(
              child: const Text("Yes, create event"),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
            SimpleDialogOption(
              child: const Text("No, cancel"),
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
