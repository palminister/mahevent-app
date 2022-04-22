import 'event.dart';

class User {
  late int id;
  late String name, username, imagePath, about, interest;

  User(
      {required this.id,
      required this.name,
      required this.username,
      required this.imagePath,
      required this.about,
      required this.interest});

  User.empty();
}

final mainUser = User(
  id: 0,
  name: 'Prayut',
  username: 'realprayut',
  imagePath:
      'https://firebasestorage.googleapis.com/v0/b/flutter-mahevent.appspot.com/o/guest_images%2Fguest2.jpg?alt=media&token=5c770c29-2dbf-469e-9831-8720b4a96905',
  about:
      'Prototype and test end-to-end with the Local Emulator Suite, now with Firebase Authentication',
  interest:
      'Comedy Movies Only, any sports but basketball, Sleeping, Politics and Sloths',
);

// final createdEvent = Event(
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
