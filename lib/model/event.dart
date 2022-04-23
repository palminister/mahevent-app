import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  late final num eventId;
  late final String imagePath,
      title,
      description,
      location,
      date,
      h1,
      h2,
      host,
      hostImage;
  late final List coordinates, categoryIds, eventImages;

  Event(
      {required this.imagePath,
      required this.eventId,
      required this.title,
      required this.description,
      required this.location,
      required this.coordinates,
      required this.date,
      required this.h1,
      required this.h2,
      required this.host,
      required this.hostImage,
      required this.categoryIds,
      required this.eventImages});

  Event.empty();

  void setEventId(num eventId) {
    this.eventId = eventId;
  }

  Map<String, dynamic> toMap() {
    return {
      'imagePath': imagePath,
      'eventId': eventId,
      'title': title,
      'description': description,
      'location': location,
      'coordinates': coordinates,
      'date': date,
      'h1': h1,
      'h2': h2,
      'host': host,
      'hostImage': hostImage,
      'categoryIds': categoryIds,
      'eventImages': eventImages,
    };
  }

  Event.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : imagePath = doc["imagePath"],
        eventId = doc["eventId"],
        title = doc["title"],
        description = doc["description"],
        location = doc["location"],
        coordinates = doc["coordinates"],
        date = doc["date"],
        h1 = doc["h1"],
        h2 = doc["h2"],
        host = doc["host"],
        hostImage = doc["hostImage"],
        categoryIds = doc["categoryIds"],
        eventImages = doc["eventImages"];
}
