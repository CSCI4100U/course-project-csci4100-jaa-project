import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  String? name;
  String? date;
  String? time;
  DocumentReference? reference;

  Event.fromMap(var map, {this.reference}){
    this.name = map['name'];
    this.date = map['date'];
    this.time = map['time']; 
  }

    Map<String,String?> toMap(){
    return {
      'name': this.name,
      'date': this.date,
      'time': this.time,
    };
  }

}