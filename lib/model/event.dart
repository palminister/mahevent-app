import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final num eventId;
  final String imagePath,
      title,
      description,
      location,
      duration,
      h1,
      h2,
      host,
      hostImage;
  final List coordinates, categoryIds, eventImages;

  Event(
      {required this.imagePath,
      required this.eventId,
      required this.title,
      required this.description,
      required this.location,
      required this.coordinates,
      required this.duration,
      required this.h1,
      required this.h2,
      required this.host,
      required this.hostImage,
      required this.categoryIds,
      required this.eventImages});

  Map<String, dynamic> toMap() {
    return {
      'imagePath': imagePath,
      'eventId': eventId,
      'title': title,
      'description': description,
      'location': location,
      'coordinates': coordinates,
      'duration': duration,
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
        duration = doc["duration"],
        h1 = doc["h1"],
        h2 = doc["h2"],
        host = doc["host"],
        hostImage = doc["hostImage"],
        categoryIds = doc["categoryIds"],
        eventImages = doc["eventImages"];
}

// final fiveKmRunEvent = Event(
//     imagePath: "assets/event_images/5_km_downtown_run.jpeg",
//     title: "5 Kilometer Downtown Run",
//     description: "",
//     location: "Pleasant Park",
//     duration: "3h",
//     h1: "Marathon!",
//     h2: "The latest fad in foodology, get the inside scoup.",
//     host: "Pattricia Luang",
//     hostImage: "assets/guest_images/guest1.jpg",
//     eventImages: [],
//     categoryIds: [0, 3]);

// final cookingEvent = Event(
//     imagePath: "assets/event_images/granite_cooking_class.jpeg",
//     title: "Granite Cooking Class",
//     description:
//         "Guest list fill up fast so be sure to apply before handto secure a spot.",
//     location: "Food Court Avenue",
//     duration: "4h",
//     h1: "Granite Cooking",
//     h2: "The latest fad in foodology, get the inside scoup.",
//     host: "Kim Leon",
//     hostImage: "assets/guest_images/guest2.jpg",
//     categoryIds: [
//       0
//     ],
//     eventImages: [
//       "assets/event_images/cooking_1.jpeg",
//       "assets/event_images/cooking_2.jpeg",
//       "assets/event_images/cooking_3.jpeg"
//     ]);

// final musicConcert = Event(
//     imagePath: "assets/event_images/music_concert.jpeg",
//     title: "Arijit Music Concert",
//     description: "Listen to Arijit's latest compositions.",
//     location: "D.Y. Patil Stadium, Mumbai",
//     duration: "5h",
//     h1: "Music Lovers!",
//     h2: "The latest fad in foodology, get the inside scoup.",
//     host: "Sarah Vakensky",
//     hostImage: "assets/guest_images/guest3.jpg",
//     eventImages: [
//       "assets/event_images/cooking_1.jpeg",
//       "assets/event_images/cooking_2.jpeg",
//       "assets/event_images/cooking_3.jpeg"
//     ],
//     categoryIds: [
//       0,
//       4
//     ]);

// final golfCompetition = Event(
//     imagePath: "assets/event_images/golf_competition.jpeg",
//     title: "Season 2 Golf Estate",
//     description: "",
//     location: "NSIC Ground, Okhla",
//     duration: "1d",
//     h1: "Golf!",
//     h2: "The latest fad in foodology, get the inside scoup.",
//     host: "Andrew Kramer",
//     hostImage: "assets/guest_images/guest4.jpg",
//     eventImages: [
//       "assets/event_images/cooking_1.jpeg",
//       "assets/event_images/cooking_2.jpeg",
//       "assets/event_images/cooking_3.jpeg"
//     ],
//     categoryIds: [
//       0
//     ]);

// final events = [
//   fiveKmRunEvent,
//   cookingEvent,
//   musicConcert,
//   golfCompetition,
// ];
