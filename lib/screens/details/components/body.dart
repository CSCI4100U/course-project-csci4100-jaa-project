import 'package:course_project/models/db_models/event_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:course_project/components/default_button.dart';
import 'package:course_project/models/entities/event.dart';
import 'package:course_project/size_config.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'event_description.dart';
import 'top_rounded_container.dart';
import 'event_images.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
    required this.event,
    required this.currentUser,
  }) : super(key: key);

  final Event event;
  final User currentUser;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool userAssists = false;

  @override
  void initState() {
    super.initState();
    userAssists = EventModel.userAssists(widget.event, widget.currentUser);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        EventImages(event: widget.event),
        TopRoundedContainer(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            children: [
              EventDescription(
                event: widget.event,
              ),
              TopRoundedContainer(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Column(
                  children: [
                    TopRoundedContainer(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: Padding(
                          padding: EdgeInsets.only(
                            left: SizeConfig.screenWidth * 0.15,
                            right: SizeConfig.screenWidth * 0.15,
                            bottom: getProportionateScreenWidth(40),
                            top: getProportionateScreenWidth(15),
                          ),
                          child: widget.event.isFull() && !userAssists
                              ? DefaultButton(
                                  text: FlutterI18n.translate(
                                      context, "details_screen.event_is_full"),
                                )
                              : DefaultButton(
                                  text: userAssists
                                      ? FlutterI18n.translate(context,
                                          "details_screen.quit_from_event")
                                      : FlutterI18n.translate(context,
                                          "details_screen.assist_to_event"),
                                  press: userAssists
                                      ? quitFromEvent
                                      : assistToEvent,
                                )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future assistToEvent() async {
    await EventModel.addAssistant(widget.event, widget.currentUser);
    setState(() {
      userAssists = true;
    });
  }

  Future quitFromEvent() async {
    await EventModel.removeAssistant(widget.event, widget.currentUser);
    setState(() {
      userAssists = false;
    });
  }
}
