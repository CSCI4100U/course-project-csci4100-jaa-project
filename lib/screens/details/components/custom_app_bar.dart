import 'package:course_project/screens/event_form/event_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:course_project/models/entities/event.dart';
import 'package:course_project/constants.dart';
import 'package:course_project/size_config.dart';

import 'app_bar_icon.dart';

class CustomAppBar extends StatelessWidget {
  final Event event;
  final Future Function(
    BuildContext context,
    bool canEdit,
    Event event,
  ) onEdit;
  final void Function(
    BuildContext context,
    bool canDelete,
    Event event,
  ) onDelete;
  final bool isOwner;

  const CustomAppBar(
      {super.key,
      required this.event,
      required this.onDelete,
      required this.onEdit,
      this.isOwner = false});

  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: getProportionateScreenWidth(40),
              width: getProportionateScreenWidth(40),
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60),
                  ),
                  primary: kPrimaryColor,
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.zero,
                ),
                onPressed: () => Navigator.pop(context),
                child: SvgPicture.asset(
                  "assets/icons/Back ICon.svg",
                  height: 15,
                ),
              ),
            ),
            const Spacer(),
            if (isOwner)
              AppBarIcon(
                containerWidth: 1,
                children: [
                  IconButton(
                    onPressed: () async =>
                        await onEdit(context, isOwner, event),
                    icon: const Icon(Icons.edit),
                  ),
                ],
              ),
            const SizedBox(
              width: 14,
            ),
            if (isOwner)
              AppBarIcon(
                containerWidth: 1,
                children: [
                  IconButton(
                    onPressed: () => onDelete(context, isOwner, event),
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
            const SizedBox(
              width: 14,
            ),
            AppBarIcon(
              children: [
                Text(
                  "${event.rating}",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 5),
                SvgPicture.asset("assets/icons/Star Icon.svg"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
