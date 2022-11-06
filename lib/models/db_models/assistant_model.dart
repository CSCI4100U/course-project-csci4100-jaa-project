import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_project/models/entities/assistant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:course_project/db/firebase_cloud_utils.dart';

class EventModel {
  Future insertAssistance(Assistant assistant) async {
    final data = assistant.toMap();
    await FirebaseFirestore.instance.collection('assistants').doc().set(data);
  }

  Future<List<Assistant>> getAllAssistants() async {
    var snapshot =
        await FirebaseFirestore.instance.collection('assistants').get();
    var assistants = snapshot.docs
        .map<Assistant>((doc) =>
            Assistant.fromMap(FireBaseCloudUtil.generateDocumentMap((doc))))
        .toList();
    return assistants;
  }

  Future<List<Assistant>> getUserAssistants(User user) async {
    var snapshot = await FirebaseFirestore.instance
        .collection('assistants')
        .where('userId', isEqualTo: user.uid)
        .get();
    var assistants = snapshot.docs
        .map<Assistant>((doc) =>
            Assistant.fromMap(FireBaseCloudUtil.generateDocumentMap((doc))))
        .toList();
    return assistants;
  }

  Future updateAssistant(Assistant assistant) async {
    final data = assistant.toMap();
    await assistant.reference!.update(data);
  }

  Future deleteAssistant(Assistant assistant) async {
    await assistant.reference!.delete();
  }
}
