import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mahevent/model/event.dart';
import 'package:mahevent/model/user.dart';
import 'dart:io';

// import 'package:image_picker/image_picker.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Event>> retrieveEvents() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection('events').get();

    final List<Event> events = snapshot.docs
        .map((docSnapshot) => Event.fromDocumentSnapshot(docSnapshot))
        .toList();
    return events;
    // return snapshot;
  }

  Future<Future<DocumentReference<Object?>>> addEvent(Event event) async {
    CollectionReference _events = _db.collection('events');
    const imageTemp =
        'https://firebasestorage.googleapis.com/v0/b/flutter-mahevent.appspot.com/o/event_images%2Fmusic_concert.jpeg?alt=media&token=98f2aeea-8c19-4bf2-af89-f70b6a9aa60e';
    const hostImageTemp = 'assets/guest_images/pete1.jpg';
    return _events.add({
      'imagePath': event.imagePath,
      'eventId': 5,
      'title': event.title,
      'description': event.description,
      'location': event.location,
      'coordinates': event.coordinates,
      'duration': event.duration,
      'h1': event.h1,
      'h2': event.h2,
      'host': 'mock_host',
      'hostImage': hostImageTemp,
      'categoryIds': event.categoryIds,
      'eventImages': [imageTemp]
    });
  }

  Future<String> uploadImage(XFile source) async {
    // Reference ref =
    //     FirebaseStorage.instance.ref().child('event-images').child('');

    // UploadTask _uploadTask;
    // _uploadTask = ref.putData(await _imageFile!.readAsBytes());

    TaskSnapshot _snapshot = await FirebaseStorage.instance
        .ref()
        .child('event-images')
        .child('${DateTime.now()}-${source.name}')
        .putFile(File(source.path));
    return _snapshot.ref.getDownloadURL();
  }

  Future<User> getUser() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _db.collection('users').doc('user-mock').get();
    final User _user = User.fromDocumentSnapshot(snapshot);
    // final List<Event> events = snapshot.docs
    //     .map((docSnapshot) => Event.fromDocumentSnapshot(docSnapshot))
    //     .toList();
    return _user;
    // return snapshot;
  }

  Future<void> editUser(User user) async {
    DocumentReference _user = _db.collection('users').doc('user-mock');
    const imageTemp =
        'https://firebasestorage.googleapis.com/v0/b/flutter-mahevent.appspot.com/o/event_images%2Fmusic_concert.jpeg?alt=media&token=98f2aeea-8c19-4bf2-af89-f70b6a9aa60e';
    const hostImageTemp = 'assets/guest_images/pete1.jpg';
    return _user.set({
      'id': user.id,
      'name': user.name,
      'username': user.username,
      'imagePath': user.imagePath,
      'about': user.about,
      'interest': user.interest,
    });
  }
}
