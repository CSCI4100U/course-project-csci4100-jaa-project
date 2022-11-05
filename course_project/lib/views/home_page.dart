import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/auth.dart';

import 'schedule_event_page.dart';

class HomeScreen extends StatelessWidget {
  final User user;
  const HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  
  Future<void> _showEventScheduler() async{
    var event = await Navigator.pushNamed(context, '/scheduleEvent');
    print("New Event Created: $event");
  }

    return MaterialApp(
      home: Scaffold(
      appBar: AppBar(
        title: const Text("FlutterFire UI Authentication"),
      ),
      body: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Text(user.email!),
              const Center(child: Text("This is Home Screen")),
              const SignOutButton(),
              const Spacer(),
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: _showEventScheduler,
        tooltip: 'Schedule Event',
        child: const Icon(Icons.add),
      ),
    ),
    routes: {
        '/scheduleEvent' : (context){
          return const ScheduleEventPage();
        }
      },
    );
    
  }
}