import 'package:course_project/auth/fire_auth.dart';
import 'package:course_project/models/db_models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:course_project/components/event_card.dart';
import 'package:course_project/size_config.dart';
import 'section_title.dart';

class FavoriteEvents extends StatefulWidget {
  @override
  State<FavoriteEvents> createState() => _FavoriteEventsState();
}

class _FavoriteEventsState extends State<FavoriteEvents> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(title: "Favorite Events", press: () {}),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: FutureBuilder(
            future: EventModel().getFavoriteEvents(FireAuth.getCurrentUser()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: [
                    ...List.generate(
                      snapshot.data?.length ?? 0,
                      (index) {
                        if (snapshot.data![index].isPopular) {
                          return EventCard(event: snapshot.data![index]);
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    SizedBox(width: getProportionateScreenWidth(20)),
                  ],
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        )
      ],
    );
  }
}
