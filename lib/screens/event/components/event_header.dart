import 'package:flutter/material.dart';
import 'package:course_project/size_config.dart';
import 'search_field.dart';

class EventHeader extends StatelessWidget {
  const EventHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          SearchField(),
        ],
      ),
    );
  }
}