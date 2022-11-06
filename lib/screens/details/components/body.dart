import 'package:flutter/material.dart';
import 'package:course_project/components/default_button.dart';
import 'package:course_project/models/entities/event.dart';
import 'package:course_project/size_config.dart';

import 'color_dots.dart';
import 'event_description.dart';
import 'top_rounded_container.dart';
import 'event_images.dart';

class Body extends StatelessWidget {
  final Event event;

  const Body({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        EventImages(event: event),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              EventDescription(
                event: event,
                pressOnSeeMore: () {},
              ),
              TopRoundedContainer(
                color: Color(0xFFF6F7F9),
                child: Column(
                  children: [
                    ColorDots(event: event),
                    TopRoundedContainer(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: SizeConfig.screenWidth * 0.15,
                          right: SizeConfig.screenWidth * 0.15,
                          bottom: getProportionateScreenWidth(40),
                          top: getProportionateScreenWidth(15),
                        ),
                        child: DefaultButton(
                          text: "Add To Cart",
                          press: () {},
                        ),
                      ),
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
}
