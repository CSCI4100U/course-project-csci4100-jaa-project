import 'package:course_project/auth/fire_auth.dart';
import 'package:course_project/models/db_models/event_model.dart';
import 'package:course_project/screens/event_form/event_form.dart';
import 'package:flutter/material.dart';

import '../../models/entities/event.dart';
import 'components/body.dart';
import 'components/custom_app_bar.dart';

class DetailsScreen extends StatefulWidget {
  static String routeName = "/details";

  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final EventDetailsArguments args =
        ModalRoute.of(context)!.settings.arguments as EventDetailsArguments;
    final bool isOwner = args.event.userId == FireAuth.getCurrentUser().uid;

    return StreamBuilder(
      stream: Stream.fromFuture(EventModel.getEventById(args.event.id!)),
      builder: (context, snapshot) {
        Event event = snapshot.data as Event;
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        return Scaffold(
          backgroundColor: const Color(0xFFF5F6F9),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(AppBar().preferredSize.height),
            child: CustomAppBar(
              event: event,
              onDelete: onDelete,
              onEdit: onEdit,
              isOwner: isOwner,
            ),
          ),
          body: Body(
            event: event,
            currentUser: FireAuth.getCurrentUser(),
          ),
        );
      },
    );
  }

  void onDelete(BuildContext context, bool canDelete, Event event) {
    if (canDelete) {
      EventModel().deleteEvent(event).then((value) => Navigator.pop(context));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Column(
            children: const [
              Text("You can't delete this event"),
              Text("You are not the owner"),
            ],
          ),
        ),
      );
    }
  }

  Future onEdit(BuildContext context, bool canEdit, Event event) async {
    if (canEdit) {
      Event? editedEvent = await Navigator.pushNamed(
        context,
        EventForm.routeName,
        arguments: event,
      ) as Event?;
      if (editedEvent != null) {
        await EventModel().updateEvent(editedEvent);
        setState(() {
          event = editedEvent;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Column(
            children: const [
              Text("You can't edit this event"),
              Text("You are not the owner"),
            ],
          ),
        ),
      );
    }
  }
}

class EventDetailsArguments {
  final Event event;

  EventDetailsArguments({required this.event});
}
