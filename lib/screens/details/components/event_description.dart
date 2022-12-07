import 'package:course_project/models/db_models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:course_project/models/entities/event.dart';

import 'package:course_project/constants.dart';
import 'package:course_project/size_config.dart';

class EventDescription extends StatelessWidget {
  const EventDescription({
    Key? key,
    required this.event,
  }) : super(key: key);

  final Event event;
  final String i18nKey = "details_screen.description";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Text(
            event.name,
            style: const TextStyle(color: Colors.grey, fontSize: 26),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: EdgeInsets.all(getProportionateScreenWidth(15)),
            width: getProportionateScreenWidth(64),
            decoration: const BoxDecoration(
              color: true ? Color(0xFFFFE6E6) : Color(0xFFF5F6F9),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(64),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                event.description,
                maxLines: 3,
              ),
              Text(
                FlutterI18n.translate(
                  context,
                  "$i18nKey.price",
                  translationParams: {"price": event.price.toString()},
                ),
              ),
              Text(
                FlutterI18n.translate(
                  context,
                  "$i18nKey.date",
                  translationParams: {
                    "date": DateFormatDisplay.format(event.date!)
                  },
                ),
              ),
              Text(
                FlutterI18n.translate(
                  context,
                  "$i18nKey.assistants",
                  translationParams: {
                    "totalAssistants": event.assistantsIds.length.toString(),
                    "capacity": event.capacity.toString(),
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
