import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  static Future<List<Map<String, dynamic>>> fetchCollection(String collectionName) async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection(collectionName).get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print("Error fetching $collectionName: $e");
      return [];
    }
  }
}
