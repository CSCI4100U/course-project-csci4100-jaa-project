import 'package:flutter/material.dart';

class ScheduledEvent{
  String? name;
  DateTime? dateTime;

  ScheduledEvent({this.dateTime, this.name});

  @override
  String toString(){
    return "Event: $name at ($dateTime)";
  }
}

class ScheduleEventPage extends StatefulWidget {
  const ScheduleEventPage({super.key});

  @override
  State<ScheduleEventPage> createState() => _ScheduleEventPageState();
}

class _ScheduleEventPageState extends State<ScheduleEventPage> {
  
  String? eventName = "";
  DateTime rightNow = DateTime.now();
  DateTime? eventTime = DateTime.now();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Schedule Event"),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
        color: Colors.white,
        child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextField(
            style: const TextStyle(fontSize: 20),
            decoration: const InputDecoration(
              hintText: "Event Name",
              border: OutlineInputBorder(),
            ),
            onChanged: (value){
              setState(() {
                eventName = value;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                  onPressed: (){
                    showDatePicker(
                        context: context,
                        initialDate: rightNow,
                        firstDate: rightNow,
                        lastDate: DateTime(2100),
                    ).then( (value) {
                      setState(() {
                        eventTime = DateTime(
                          value!.year,
                          value.month,
                          value.day,
                          eventTime!.hour,
                          eventTime!.minute,
                          eventTime!.second);
                      }
                      );
                    }
                    );
                  },
                  child: const Text("Date", style: TextStyle(fontSize: 20),)
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(toDateString(eventTime!), style: const TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
          Row(
            children: [
              ElevatedButton(
                  onPressed: (){
                    showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(
                          hour: rightNow.hour,
                          minute: rightNow.minute
                      ),
                    ).then( (value) {
                      setState(() {
                        eventTime = DateTime(
                            eventTime!.year,
                            eventTime!.month,
                            eventTime!.day,
                            value!.hour,
                            value.minute);
                      }
                      );
                    }
                    );
                  },
                  child: const Text("Time", style: TextStyle(fontSize: 20),)
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(toTimeString(eventTime!), style: const TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
          ElevatedButton(
              onPressed: (){
                Navigator.of(context).pop(
                  ScheduledEvent(name: eventName,
                    dateTime: eventTime
                  )
                );
              },
              child: const Text("Save", style: TextStyle(fontSize: 25),)
          ),
        ],
        ),
      ),
    );
  }

String twoDigits(int value){
  if (value > 9){
    return "$value";
  }
  return "0$value";
}

String toDateString(DateTime date){
  return "${date.year}-${twoDigits(date.month)}-${twoDigits(date.day)}";
}

String toTimeString(DateTime date){
  return "${twoDigits(date.hour)}:${twoDigits(date.minute)}";
}
}
