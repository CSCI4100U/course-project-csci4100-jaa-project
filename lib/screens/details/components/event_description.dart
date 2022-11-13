import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:course_project/models/entities/event.dart';

import 'package:course_project/constants.dart';
import 'package:course_project/size_config.dart';

class EventDescription extends StatelessWidget {
  const EventDescription({
    Key? key,
    required this.event,
    this.pressOnSeeMore,
  }) : super(key: key);

  final Event event;
  final GestureTapCallback? pressOnSeeMore;

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
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: EdgeInsets.all(getProportionateScreenWidth(15)),
            width: getProportionateScreenWidth(64),
            decoration: BoxDecoration(
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
          child: Text(
            event.description,
            maxLines: 3,
          ),
        ),
      ],
    );
  }
}
