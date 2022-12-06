import 'package:course_project/screens/home/components/assisted_events_display.dart';
import 'package:flutter/material.dart';
import 'package:course_project/size_config.dart';

import 'events_display.dart';

class AssistedEventsBanner extends StatelessWidget {
  const AssistedEventsBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async =>
          await Navigator.pushNamed(context, AssistedEventsDisplay.routeName),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.all(getProportionateScreenWidth(20)),
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
          vertical: getProportionateScreenWidth(15),
        ),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 178, 90, 17),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text.rich(
          TextSpan(
            style: const TextStyle(color: Colors.white),
            children: [
              const TextSpan(text: "Events you assisted\n"),
              TextSpan(
                text: "View assisted events",
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