import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:course_project/models/entities/event.dart';
import 'package:course_project/screens/details/details_screen.dart';

import '../constants.dart';
import '../size_config.dart';

// for the Events screen (screen displaying all the events the person has added)
// takes in the width, aspectRatio, and the event

class EventCard extends StatelessWidget {
  const EventCard({
    Key? key,
    this.width = 140,
    this.aspectRatio = 1.02,
    required this.event,
  }) : super(key: key);

  final double width, aspectRatio;
  final Event event;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: SizedBox(
        width: getProportionateScreenWidth(width),
        child: GestureDetector(

          // when a event is tapped on, bring user to the screen displaying
          // that specific event, and more pictures of it, and its description
          onTap: () => Navigator.pushNamed(
            context,
            DetailsScreen.routeName,
            arguments: EventDetailsArguments(event: event),
          ),

          // column with all the events showing on the screen.
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: aspectRatio,
                child: Container(

                  // container background shown when there is no event picture
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),

                  // Hero widget displaying the event picture.  (If there is no
                  // picture available, a blank square/container is shown).
                  child: Hero(
                    tag: event.id.toString(),
                    child: event.images != null && event.images!.isNotEmpty
                        ? Image.asset(event.images![0])
                        : Container(),
                  ),
                ),
              ),

              const SizedBox(height: 15), // for spacing

              // for displaying the event names/titles
              Text(
                event.name,
                style: TextStyle(color: Colors.black),
                maxLines: 2,
              ),

              // for displaying the event prices
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$${event.price}",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(18),
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
