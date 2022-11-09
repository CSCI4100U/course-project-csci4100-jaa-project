import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_project/constants.dart';
import 'package:course_project/models/entities/event.dart';
import 'package:flutter/material.dart';

class EventForm extends StatefulWidget {
  static String routeName = "/event_form";
  const EventForm({super.key});

  @override
  State<EventForm> createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  final _formKey = GlobalKey<FormState>();

  Event event = Event();
  DateTime rightNow = DateTime.now();
  DateTime eventTime = DateTime.now();
  DateTime eventDate = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final eventToEdit = ModalRoute.of(context)!.settings.arguments as Event?;
    if (eventToEdit != null) {
      event = eventToEdit;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Event Form"),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // create a new event
            const Text("Create a new event",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            TextField(
              style: const TextStyle(fontSize: 20),
              decoration: const InputDecoration(
                hintText: "Event Name",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  event.name = value;
                });
              },
            ),
            // spacer
            const SizedBox(
               height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // date picker
                ElevatedButton(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: rightNow,
                      firstDate:
                          rightNow.isBefore(eventDate) ? rightNow : eventDate,
                      lastDate: lastDateTimeDate,
                    ).then((value) {
                      if (value != null) {
                        setState(() {
                          eventDate = value;
                        });
                      }
                    });
                  },
                  child: const Text(
                    "Date",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                displayTextContainer(toDateString(eventDate))
              ],
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(
                        hour: eventTime.hour,
                        minute: eventTime.minute,
                      ),
                    ).then(
                      (value) {
                        if (value != null) {
                          setState(
                            () {
                              eventTime = DateTime(
                                  eventDate.day,
                                  eventDate.month,
                                  eventDate.day,
                                  value.hour,
                                  value.minute);
                            },
                          );
                        }
                      },
                    );
                  },
                  child: const Text(
                    "Time",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                displayTextContainer(toTimeString(eventTime!))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                event.date = DateTime(
                  eventDate.year,
                  eventDate.month,
                  eventDate.day,
                  eventTime.hour,
                  eventTime.minute,
                );
                Navigator.pop(context, event);
              },
              child: const Text(
                "Save",
                style: TextStyle(fontSize: 25),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String twoDigits(int value) {
    if (value > 9) {
      return "$value";
    }
    return "0$value";
  }

  String toDateString(DateTime date) {
    return "${date.year}-${twoDigits(date.month)}-${twoDigits(date.day)}";
  }

  String toTimeString(DateTime date) {
    return "${twoDigits(date.hour)}:${twoDigits(date.minute)}";
  }

  // used to display the date and time
  Widget displayTextContainer(String displayString){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        displayString,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
