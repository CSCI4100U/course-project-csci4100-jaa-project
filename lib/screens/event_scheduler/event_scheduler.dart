import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class ScheduledEvent{
  String? name;
  String? date;
  String? time;


  ScheduledEvent({this.date, this.name, this.time});

  @override
  String toString(){
    return "Event: $name at ($date, $time)";
  }
}

class ScheduleEventPage extends StatefulWidget {
  static String routeName = "/event_scheduler";
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
        padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
        color: Colors.white,
        child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text("Create a new event", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 30),
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
              onPressed: () {
                ScheduledEvent event = ScheduledEvent(name: "Check Name", date: toDateString(eventTime!), time: toTimeString(eventTime!));
                _addToDb(event);
              },
              child: const Text("Save", style: TextStyle(fontSize: 25),)
          ),
        ],
        ),
      ),
    );
  }

Future _addToDb(ScheduledEvent newEvent) async{
    final data = <String,Object?>{
      "name": "Check Name",
      "date": newEvent.date,
      "time": newEvent.time,
    };
    await FirebaseFirestore.instance.collection('events').doc().set(data);
    setState(() {
      print("Added data: $data");
    });

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
