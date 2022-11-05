import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  int? id;
  String? username;
  String? email;
  DocumentReference? reference;

  User.fromMap(var map, {this.reference}) {
    id = int.tryParse(map['id']);
    username = map['username'];
    email = map['email'];
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
    };
  }
}
