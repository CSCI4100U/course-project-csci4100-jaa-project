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
  Widget spacerBox = const SizedBox(height: 20,);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final eventToEdit = ModalRoute
        .of(context)!
        .settings
        .arguments as Event?;
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
            // create a new event title
            const Text(
                "Create a new event",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
            ),
            const SizedBox(height: 30), // spacer
            eventNameTextField(),
            spacerBox,
            descriptionWidget(),
            dateWidget(),
            timeWidget(),
            priceFieldWidget(),
            spacerBox,
            saveButton()
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
  Widget displayTextContainer(String displayString) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        displayString,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }

  // description widget
  Widget descriptionWidget() {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      constraints: BoxConstraints(maxHeight: 90),
      child: SingleChildScrollView(
        child: TextField(
          style: const TextStyle(fontSize: 20),
          decoration: InputDecoration(
              hintText: "Description"
          ),
          maxLines: null,
          onChanged: (value) {
            setState(() {
              event.description = value;
            });
          },
        ),
      ),
    );
  }

  // save button widget
  Widget saveButton() {
    return Flexible(
      child: ElevatedButton(
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
    );
  }

  // date button and date picker widget
  Widget dateWidget() {
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
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
    );
  }

  // time button and time picker widget
  Widget timeWidget() {
    return Flexible(
      child: Row(
        children: [
          ElevatedButton(
            onPressed: () {
              showTimePicker(
                context: context,
                initialTime: TimeOfDay(
                  hour: eventTime.hour,
                  minute: eventTime.minute,
                ),
              ).then((value) {
                if (value != null) {
                  setState(() {
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
            child: const Text("Time",
              style: TextStyle(fontSize: 20),
            ),
          ),
          displayTextContainer(toTimeString(eventTime!))
        ],
      ),
    );
  }

  // event name price widget
  Widget priceFieldWidget() {
    return TextField(
      style: const TextStyle(fontSize: 20),
      decoration: const InputDecoration(
        hintText: "Price",
        icon: Icon(Icons.attach_money_sharp, size: 35, color: Colors.green,),
        contentPadding: EdgeInsets.symmetric(horizontal: 50, vertical: 10)
      ),
      onChanged: (value) {
        setState(() {
          event.price = int.tryParse(value);
          if (event.price == null) {
            print("Invalid value for price");
          }
        });
      },
    );
  }

  // event name textfield widget
  Widget eventNameTextField() {
    return TextField(
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
    );
  }
}