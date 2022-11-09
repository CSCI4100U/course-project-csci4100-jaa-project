import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_project/constants.dart';
import 'package:course_project/models/entities/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'decimal_formatter.dart';

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

  Widget spacerBox = const Flexible(
    child: SizedBox(height: 20,),
  );
  Widget spacerBox2 = const Flexible(
    child: SizedBox(height: 15,),
  );

  static const mainIconSize = 55.0;
  static const mainFontSize = 20.0;
  static const mainIconPaddingAmount = 10.0;

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
                style: TextStyle(fontSize: mainFontSize, fontWeight: FontWeight.bold)
            ),
            const SizedBox(height: 30), // spacer
            eventNameTextField(),
            spacerBox,
            descriptionWidget(),
            dateWidget(),
            timeWidget(),
            spacerBox2,
            priceFieldWidget(),
            spacerBox,
            capacityTextField(),
            ratingField(),
            spacerBox,
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
        style: const TextStyle(fontSize: mainFontSize),
      ),
    );
  }

  // description widget
  Widget descriptionWidget() {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      constraints: const BoxConstraints(maxHeight: 90),
      child: SingleChildScrollView(
        child: TextField(
          style: const TextStyle(fontSize: mainFontSize),
          decoration: const InputDecoration(
            hintText: "Description",
            icon: Padding(
              padding: EdgeInsets.symmetric(horizontal: mainIconPaddingAmount),
              child: Icon(Icons.description, color: Colors.amber, size: mainIconSize,),
            )
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
              style: TextStyle(fontSize: mainFontSize),
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
              style: TextStyle(fontSize: mainFontSize),
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
        icon: Padding(
          padding: EdgeInsets.symmetric(horizontal: mainIconPaddingAmount),
          child: Icon(Icons.attach_money_sharp, size: mainIconSize, color: Colors.green,),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 50, vertical: 10)
      ),
      onChanged: (value) {
        setState(() {
          event.price = double.tryParse(value);
          if (event.price == null) {
            print("Invalid value for price");
          }
        });
      },
        // keyboard type to number with options
      keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: false),
      inputFormatters: [
        // only allowing numbers with a max of 2 decimals
        DecimalTextInputFormatter(decimalRange: 2),

        // not allowing the user to use the invalid characters on the keyboard
        FilteringTextInputFormatter.deny(","),
        FilteringTextInputFormatter.deny("_"),
        FilteringTextInputFormatter.deny("-")]
    );
  }

  // event name textfield widget
  Widget eventNameTextField() {
    return TextField(
      style: const TextStyle(fontSize: mainFontSize),
      decoration: const InputDecoration(
        hintText: "Event Name",
        border: OutlineInputBorder(),
        icon: Padding(
          padding: EdgeInsets.symmetric(horizontal: mainIconPaddingAmount),
          child: Icon(Icons.drive_file_rename_outline, color: Colors.brown, size: mainIconSize,)
        )
      ),
      onChanged: (value) {
        setState(() {
          event.name = value;
        });
      },
    );
  }

  Widget capacityTextField(){
    return TextField(
        style: const TextStyle(fontSize: 20),
        decoration: const InputDecoration(
            hintText: "Capacity",
            icon: Padding(
              padding: EdgeInsets.symmetric(horizontal: mainIconPaddingAmount),
              child: Icon(Icons.reduce_capacity, size: mainIconSize, color: Color.fromRGBO(153, 0, 0, 100.0)),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 50, vertical: 10)
        ),
        onChanged: (value) {
          setState(() {
            event.capacity = int.tryParse(value);
          });
        },
        // keyboard type to number keyboard
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly] // only allowing the user to enter digits
    );
  }

  // star rating field (0.5 to 5.0 rating)
  Widget ratingField(){
    return Flexible(
      child: RatingBar.builder(
        initialRating: event.rating,
        minRating: 0.5,
        allowHalfRating: true,
        itemCount: 5,
        itemPadding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
        itemBuilder: (context, _) => const Icon(
          Icons.star,
          color: Colors.amber,
          size: mainIconSize,
        ),
        onRatingUpdate: (rating) {
          setState(() {
            event.rating = rating;
          });
        },
      ),
    );
  }
}


