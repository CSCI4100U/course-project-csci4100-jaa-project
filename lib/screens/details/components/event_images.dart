import 'package:flutter/material.dart';
import 'package:course_project/models/entities/event.dart';

import 'package:course_project/constants.dart';
import 'package:course_project/size_config.dart';

class EventImages extends StatefulWidget {
  const EventImages({
    Key? key,
    required this.event,
  }) : super(key: key);

  final Event event;

  @override
  _EventImagesState createState() => _EventImagesState();
}

class _EventImagesState extends State<EventImages> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: getProportionateScreenWidth(238),
          child: AspectRatio(
            aspectRatio: 1,
            child: Hero(
              tag: widget.event.id.toString(),
              child: widget.event.images == null || widget.event.images!.isEmpty
                  ? Image.asset(NO_AVAILABLE_IMAGE_PATH)
                  : Image.asset(widget.event.images![selectedImage]),
            ),
          ),
        ),
        // SizedBox(height: getProportionateScreenWidth(20)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(widget.event.images?.length ?? 0,
                (index) => buildEventPreview(index)),
          ],
        )
      ],
    );
  }

  GestureDetector buildEventPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: AnimatedContainer(
        duration: defaultDuration,
        margin: const EdgeInsets.only(right: 15),
        padding: const EdgeInsets.all(8),
        height: getProportionateScreenWidth(48),
        width: getProportionateScreenWidth(48),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: kPrimaryColor.withOpacity(selectedImage == index ? 1 : 0)),
        ),
        child: Image.asset(widget.event.images![index]),
      ),
    );
  }
}
