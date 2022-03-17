import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mahevent/model/event.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Event>> retrieveEvents() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection('events').get();
    return snapshot.docs
        .map((docSnapshot) => Event.fromDocumentSnapshot(docSnapshot))
        .toList();
    // return snapshot;
  }
}
