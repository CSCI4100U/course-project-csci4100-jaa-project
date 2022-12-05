import 'package:course_project/models/entities/event.dart';
import 'package:flutter/material.dart';
import 'package:course_project/models/db_models/event_model.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';


class CalendarView extends StatefulWidget {
  const CalendarView({Key? key}) : super(key: key);
  static String routeName = "/calendarView";

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  late CalendarController _controller;
  EventModel _eventModel = EventModel();
  List<dynamic> selectedEvents = [];
  List<dynamic> allEvents = [];
  final eventDateTimes = Map<DateTime, List<dynamic>>();

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    selectedEvents = [];

    getAllEventsDateTimes();
  }

  void getAllEventsDateTimes () async {
    var events = await _eventModel.getAllEvents();

    setState(() {
      for (int i=0; i < events.length; i++) {
        bool? dateAlreadyThere = false;
        List<Event> listOfEvents = List.empty(growable: true);
        listOfEvents.add(events[i]);
        int j = 0;

        while (dateAlreadyThere == false || j >= eventDateTimes.length)
        {
          dateAlreadyThere = eventDateTimes[j]?.contains(simplifyDateTime(events[i].date!));
          //dateAlreadyThere = eventDateTimes.keys.toList().contains(simplifyDateTime(events.asMap()[i]!.date!));
          j++;
        }
        if (dateAlreadyThere == true) {
          print("YOOOO");
          //eventDateTimes[j]?.add(events[i]);
          // print(events[i].date);
          // print(eventDateTimes.values.elementAt(j));
          // eventDateTimes.values.elementAt(j).add(events[i]);
          // print(eventDateTimes.values.elementAt(j));
          List currentVals = eventDateTimes.values.elementAt(j);
          currentVals.add(events[i]);
          eventDateTimes.update(simplifyDateTime(events[i].date!), (value) => currentVals);
          //print(eventDateTimes.update(simplifyDateTime(events.asMap()[i]!.date!), (value) => eventDateTimes.values.elementAt(j).length));
        }
        else {
          eventDateTimes.addEntries([
            MapEntry(simplifyDateTime(events.asMap()[i]!.date!), listOfEvents)
          ]);
        }
      }
    });
    allEvents = events;
    //print(eventDateTimes);
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
          children: <Widget>[
            TableCalendar(
              rowHeight: 70,
              events: eventDateTimes,
              initialCalendarFormat: CalendarFormat.month,
              weekendDays: [],
              calendarStyle: CalendarStyle(
                  canEventMarkersOverflow: true,
                  eventDayStyle: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                  ),
                  todayColor: Colors.green,
                  selectedColor: Theme.of(context).primaryColor,
                  todayStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                      color: Colors.white)
              ),
              headerStyle: HeaderStyle(
                centerHeaderTitle: true,
                formatButtonDecoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                formatButtonTextStyle: TextStyle(color: Colors.white),
                formatButtonShowsNext: false,
              ),
              startingDayOfWeek: StartingDayOfWeek.sunday,
              onDaySelected: (date,events ,something) {
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

  DateTime simplifyDateTime (DateTime date) {
    final dateFormat = DateFormat('y-M-d');
    return DateTime.parse(dateFormat.format(date));
  }
}
