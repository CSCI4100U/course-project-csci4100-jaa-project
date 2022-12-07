import 'package:flutter/material.dart';
import 'package:course_project/size_config.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'events_display.dart';

class MyEventBanner extends StatelessWidget {
  const MyEventBanner({
    Key? key,
  }) : super(key: key);

  final i18nKey = "home_screen.your_events_banner";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async =>
          await Navigator.pushNamed(context, EventsDisplay.routeName),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.all(getProportionateScreenWidth(20)),
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
          vertical: getProportionateScreenWidth(15),
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF4A3298),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text.rich(
          TextSpan(
            style: const TextStyle(color: Colors.white),
            children: [
              TextSpan(text: FlutterI18n.translate(context, "$i18nKey.title")),
              TextSpan(
                text: FlutterI18n.translate(context, "$i18nKey.subtitle"),
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(24),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
