import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:course_project/models/entities/event.dart';
import 'package:course_project/screens/details/details_screen.dart';

import '../constants.dart';
import '../size_config.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    Key? key,
    this.width = 140,
    this.aspectRatio = 1.02,
    required this.event,
    required this.whenReturn,
  }) : super(key: key);

  final double width, aspectRatio;
  final Event event;
  final void Function() whenReturn;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: SizedBox(
        width: getProportionateScreenWidth(width),
        child: GestureDetector(
          onTap: () async {
            await Navigator.pushNamed(
              context,
              DetailsScreen.routeName,
              arguments: EventDetailsArguments(event: event),
            );
            whenReturn();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: aspectRatio,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Hero(
                    tag: event.id.toString(),
                    child: event.images != null && event.images!.isNotEmpty
                        ? Image.asset(event.images![0])
                        : Container(),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                event.name,
                style: TextStyle(color: Colors.grey),
                maxLines: 2,
              ),
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
