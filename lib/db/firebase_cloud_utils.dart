import 'package:cloud_firestore/cloud_firestore.dart';

class FireBaseCloudUtil {
  static Map<String, dynamic> generateDocumentMap(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return {
      ...doc.data(),
      'reference': doc.reference,
      'id': doc.id,
    };
  }
}
