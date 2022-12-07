import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_project/constants.dart';
import 'package:course_project/models/db_models/category_model.dart';
import 'package:course_project/models/entities/category.dart';
import 'package:course_project/models/entities/event.dart';
import 'package:course_project/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'decimal_formatter.dart';
import 'package:latlong2/latlong.dart';

import 'location_map.dart';

class EventForm extends StatefulWidget {
  static String routeName = "/event_form";
  const EventForm({super.key});

  @override
  State<EventForm> createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  bool firstRender = true;
  Event event = Event();
  DateTime rightNow = DateTime.now();
  DateTime eventTime = DateTime.now();
  DateTime eventDate = DateTime.now();

  Widget spacerBox = const SizedBox(
    height: 20,
  );
  Widget spacerBox2 = const SizedBox(
    height: 15,
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
    final eventToEdit = ModalRoute.of(context)!.settings.arguments as Event?;
    if (eventToEdit != null) {
      event = eventToEdit;
      if (firstRender) {
        eventTime = event.date!;
        eventDate = event.date!;
        firstRender = false;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Event Form"),
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: Stream.fromFuture(CategoryModel().getAllCategories()),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            List<Category> categories = snapshot.data;
            return Container(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // create a new event title
                  Text(
                    FlutterI18n.translate(context, "event_form.title"),
                    style: const TextStyle(
                      fontSize: mainFontSize,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor,
                    ),
                  ),
                  spacerBox,
                  eventNameTextField(),
                  spacerBox,
                  descriptionWidget(),
                  dateWidget(),
                  timeWidget(),
                  spacerBox2,
                  priceFieldWidget(),
                  spacerBox,
                  capacityTextField(),
                  spacerBox,
                  mapScreenButton(),
                  categoriesDropdown(categories),
                  ratingField(),
                  saveButton()
                ],
              ),
            );
          },
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

  /// used to display the date and time
  Widget displayTextContainer(String displayString) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        displayString,
        style: const TextStyle(fontSize: mainFontSize, color: Colors.grey),
      ),
    );
  }

  /// description widget
  Widget descriptionWidget() {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      constraints: const BoxConstraints(maxHeight: 90),
      child: SingleChildScrollView(
        child: TextFormField(
          initialValue: event.description,
          style: const TextStyle(fontSize: mainFontSize),
          decoration: InputDecoration(
            hintText: FlutterI18n.translate(context, "event_form.description"),
            icon: const Padding(
              padding: EdgeInsets.symmetric(horizontal: mainIconPaddingAmount),
              child: Icon(
                Icons.description,
                color: Colors.amber,
                size: mainIconSize,
              ),
            ),
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

  /// select location button
  Widget mapScreenButton() {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      child: FutureBuilder(
        future: Geolocator.getCurrentPosition(),
        builder: (context, snapshot) {
          if (!snapshot.hasData && event.location == null) {
            return const CircularProgressIndicator();
          }
          return ElevatedButton(
            onPressed: () async {
              event.location ??=
                  GeoPoint(snapshot.data!.latitude, snapshot.data!.longitude);
              var locationSelected = await Navigator.pushNamed(
                context,
                LocationMap.routeName,
                arguments: event.location,
              );
              if (locationSelected != null) {
                var location = locationSelected as LatLng;
                setState(() {
                  event.location =
                      GeoPoint(location.latitude, location.longitude);
                });
              }
            },
            child: Text(
                FlutterI18n.translate(context, "event_form.select_location")),
          );
        },
      ),
    );
  }

  /// save button widget
  Widget saveButton() {
    return ElevatedButton(
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
    );
  }

  /// date button and date picker widget
  Widget dateWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () async {
            var date = await showDatePicker(
              context: context,
              initialDate: event.date ?? rightNow,
              firstDate: rightNow.isBefore(eventDate) ? rightNow : eventDate,
              lastDate: lastDateTimeDate,
              currentDate: rightNow,
            );
            if (date != null) {
              setState(() {
                eventDate = date;
              });
            }
          },
          child: Text(
            FlutterI18n.translate(context, "event_form.date"),
            style: const TextStyle(fontSize: mainFontSize),
          ),
        ),
        displayTextContainer(toDateString(eventDate))
      ],
    );
  }

  /// time button and time picker widget
  Widget timeWidget() {
    return Row(
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
                      eventTime = DateTime(eventDate.day, eventDate.month,
                          eventDate.day, value.hour, value.minute);
                    },
                  );
                }
              },
            );
          },
          child: Text(
            FlutterI18n.translate(context, "event_form.time"),
            style: const TextStyle(fontSize: mainFontSize),
          ),
        ),
        displayTextContainer(toTimeString(eventTime))
      ],
    );
  }

  /// event name price widget
  Widget priceFieldWidget() {
    return TextFormField(
        initialValue: event.price.toString(),
        style: const TextStyle(fontSize: 20),
        decoration: InputDecoration(
            hintText: FlutterI18n.translate(context, "event_form.price"),
            icon: const Padding(
              padding: EdgeInsets.symmetric(horizontal: mainIconPaddingAmount),
              child: Icon(
                Icons.attach_money_sharp,
                size: mainIconSize,
                color: Colors.green,
              ),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 50, vertical: 10)),
        onChanged: (value) {
          double? price = double.tryParse(value);
          if (price != null) {
            setState(() {
              event.price = price;
            });
          }
        },

        /// set keyboard type to number with options
        keyboardType:
            const TextInputType.numberWithOptions(decimal: true, signed: false),
        inputFormatters: [
          // only allowing numbers with a max of 2 decimals
          DecimalTextInputFormatter(decimalRange: 2),

          // not allowing the user to use the invalid characters on the keyboard
          FilteringTextInputFormatter.deny(","),
          FilteringTextInputFormatter.deny("_"),
          FilteringTextInputFormatter.deny("-")
        ]);
  }

  /// event name textfield widget
  Widget eventNameTextField() {
    return TextFormField(
      initialValue: event.name,
      style: const TextStyle(fontSize: mainFontSize),
      decoration: InputDecoration(
        hintText: FlutterI18n.translate(context, "event_form.name"),
        border: const OutlineInputBorder(),
        icon: const Padding(
          padding: EdgeInsets.symmetric(horizontal: mainIconPaddingAmount),
          child: Icon(
            Icons.drive_file_rename_outline,
            color: Colors.brown,
            size: mainIconSize,
          ),
        ),
      ),
      onChanged: (value) {
        setState(() {
          event.name = value;
        });
      },
    );
  }

  /// capacity text field
  Widget capacityTextField() {
    return TextFormField(
        initialValue: event.capacity.toString(),
        style: const TextStyle(fontSize: 20),
        decoration: InputDecoration(
            hintText: FlutterI18n.translate(context, "event_form.capacity"),
            icon: const Padding(
              padding: EdgeInsets.symmetric(horizontal: mainIconPaddingAmount),
              child: Icon(Icons.reduce_capacity,
                  size: mainIconSize, color: Color.fromRGBO(153, 0, 0, 100.0)),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 50, vertical: 10)),
        onChanged: (value) {
          int? capacity = int.tryParse(value);
          if (capacity != null) {
            setState(() {
              event.capacity = capacity;
            });
          }
        },
        // keyboard type to number keyboard
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly
        ] // only allowing the user to enter digits
        );
  }

  /// star rating field (0.5 to 5.0 rating)
  Widget ratingField() {
    return RatingBar.builder(
      unratedColor: Colors.grey,
      initialRating: event.rating,
      minRating: 0.5,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 10.0),
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
    );
  }

  /// Generate the category dropdown
  Widget categoriesDropdown(List<Category> categories) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          FlutterI18n.translate(context, "event_form.category"),
          style: const TextStyle(fontSize: mainFontSize),
        ),
        const SizedBox(
          width: 35,
        ),
        DropdownButton<int?>(
          hint: Text(
            FlutterI18n.translate(
              context,
              "event_form.select_category",
            ),
            style: const TextStyle(color: Colors.grey),
          ),
          value: categories
              .firstWhere((element) => element.id == event.categoryId,
                  orElse: () => Category(id: null, name: ""))
              .id,
          items: categories.map((category) {
            return DropdownMenuItem(
              value: category.id,
              child: Text(
                  FlutterI18n.translate(context, "categories.${category.name}"),
                  style: const TextStyle(fontSize: mainFontSize)),
            );
          }).toList(),
          onChanged: (int? value) {
            if (value != null) {
              setState(() {
                event.categoryId = value;
              });
            }
          },
        ),
      ],
    );
  }
}
