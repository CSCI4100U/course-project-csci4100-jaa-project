import 'package:course_project/models/entities/event.dart';
import 'package:flutter/material.dart';
import 'package:course_project/models/db_models/event_model.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

/// Calendar View Screen
class CalendarView extends StatefulWidget {
  const CalendarView({Key? key}) : super(key: key);
  static String routeName = "/calendarView";

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  late CalendarController _controller;
  final EventModel _eventModel = EventModel();

  List<dynamic> selectedEvents = [];
  // Map of DateTime keys, and values of Lists of events
  final eventDateTimes = Map<DateTime, List<dynamic>>();

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    selectedEvents = [];

    getAllEventsDateTimes();
  }


  /// from the cloud database, get all the events for each DateTime
  void getAllEventsDateTimes () async {
    var events = await _eventModel.getAllEvents();
    for (var event in events) {
      var eventDateTime = event.date!.toLocal();
      var eventDate = DateTime(
          eventDateTime.year, eventDateTime.month, eventDateTime.day
      );

      if (eventDateTimes.containsKey(eventDate)) {
        eventDateTimes[eventDate]!.add(event);
      }
      else {
        eventDateTimes[eventDate] = [event];
      }
    }
    // just using a set state so that the calendar has the events added to
    // it right away
    setState(() {
      print("Calendar started");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('', style: TextStyle(color: Colors.indigo),),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TableCalendar(
              rowHeight: 70,
              events: eventDateTimes,
              initialCalendarFormat: CalendarFormat.month,

              /// set weekendDays to none because I don't want these days to
              /// have a different colour unless they have events on them
              weekendDays: [],

              calendarStyle: CalendarStyle(
                  markersMaxAmount: 3,
                  canEventMarkersOverflow: true,

                  /// text style for days with event(s) on them
                  eventDayStyle: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                  ),
                  todayColor: Colors.blue,
                  selectedColor: Theme.of(context).primaryColor,

                  /// text style for a selected day
                  todayStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                      color: Colors.white)
              ),

              /// header style (where it says "month", "2 weeks", or "week")
              headerStyle: HeaderStyle(
                centerHeaderTitle: true,
                formatButtonDecoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                formatButtonTextStyle: const TextStyle(color: Colors.white),
                formatButtonShowsNext: false,
              ),
              startingDayOfWeek: StartingDayOfWeek.sunday,

              /// get the current selectedEvents and store into the list
              onDaySelected: 
                  (date, events, _) {
                  setState(() {
                    selectedEvents = events;
                  });
              },
              builders: CalendarBuilders(
                selectedDayBuilder: (context, date, events) => Container(
                  margin: const EdgeInsets.all(5.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(8.0)
                  ),
                  child: Text(
                    date.day.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),

                /// blue box for selected day
                todayDayBuilder: (context, date, events) => Container(
                  margin: const EdgeInsets.all(5.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8.0)
                  ),
                  child: Text(
                    date.day.toString(),
                    style: const TextStyle(color: Colors.white),
                  )
                ),
              ),
              calendarController: _controller,
            ),

            /// show all the events (if any) at the bottom, for the selected day
            ...selectedEvents.map((event) => ListTile(
                title: Text(convertDateTimeToDate(event.date)),
                subtitle: Text(event.name),
                trailing: Text(convertDateTimeToTime(event.date)),
              )
            ),
          ],
        ),
      ),
    );
  }

  String convertDateTimeToDate (DateTime date) {
    final dateFormat = DateFormat('EEEE MMMM dd');
    return dateFormat.format(date);
  }

  String convertDateTimeToTime (DateTime date) {
    final dateFormat = DateFormat('Hm');
    return dateFormat.format(date);
  }
}
