// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mahevent/database/firestore_service.dart';
import 'package:mahevent/model/category.dart';
import 'package:mahevent/model/event.dart';
import 'package:mahevent/states.dart';
import 'package:mahevent/styles.dart';
import 'package:mahevent/ui/event_details/eventDetails.dart';
import 'package:mahevent/ui/homepage/categoryWidget.dart';
import 'package:mahevent/ui/homepage/eventWidget.dart';
import 'package:mahevent/ui/homepage/homepageBackground.dart';
import 'package:provider/provider.dart';
import 'dart:math' show cos, sqrt, asin;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseService _service = DatabaseService();
  Future<List<Event>>? _eventList;
  List<Event>? _retrievedEventList;
  Position? _position;

  @override
  void initState() {
    super.initState();
    _initRetrieval();
  }

  // Future<void> _initCoordination() async {
  //   _position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  //   print('call init coordinates');
  //   print(_position);
  // }

  // var b = await Geolocator.getCurrentPosition(
  //     desiredAccuracy: LocationAccuracy.high);

  Future<void> _initRetrieval() async {
    _eventList = _service.retrieveEvents();
  }

  // final double lat = 13.794498305148874;
  // final double lng = 100.32558404809016;

  static const double limitDistance = 5; // KM
  // static const double limitDistance =
  //     5000; // KM // I am Shinkanzen, I will go wherever I please

  // https://en.wikipedia.org/wiki/Haversine_formula
  // https://stackoverflow.com/questions/27928/calculate-distance-between-two-latitude-longitude-points-haversine-formula
  double calculateDistanceKm(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ChangeNotifierProvider<States>(
        create: (_) => States(),
        child: Stack(
          children: <Widget>[
            HomePageBackground(screenHeight: screenHeight),
            SafeArea(
              bottom: false,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 100.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // mainAxisAlignment: MainAxisAlignment.center,
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 60.0, 0.0, 0.0),
                        child: Text(
                          "Let's explore!",
                          style: whiteHeadingTextStyle,
                        ),
                      ),
                      Padding(
                          padding:
                              const EdgeInsets.fromLTRB(10.0, 30.0, 0.0, 30.0),
                          child: Consumer<States>(
                            builder: (context, states, _) =>
                                SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: <Widget>[
                                  for (final category in categories)
                                    CategoryWidget(category: category)
                                ],
                              ),
                            ),
                          )),
                      Consumer<States>(
                          builder: (context, states, _) => FutureBuilder(
                              future: Geolocator.getCurrentPosition(
                                  desiredAccuracy: LocationAccuracy.high),
                              builder:
                                  (context, AsyncSnapshot<Position> snapshot) {
                                if (snapshot.hasData) {
                                  // Another Future
                                  var _position = snapshot.data;
                                  return FutureBuilder(
                                    future: _eventList,
                                    builder: (context,
                                        AsyncSnapshot<List<Event>> snapshot) {
                                      if (!snapshot.hasData) {
                                        return const Text('Loading...');
                                      } else if (snapshot.hasError) {
                                        return const Text('has error...');
                                      } else if (snapshot.connectionState ==
                                          ConnectionState.active) {
                                        return const Text('is querying...');
                                      } else if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Text('is waiting...');
                                      } else if (snapshot.hasData) {
                                        return Column(
                                          children: <Widget>[
                                            for (final event
                                                in snapshot.data!.where(
                                              (element) =>
                                                  element.categoryIds.contains(
                                                      states
                                                          .selectedCategory) &&
                                                  calculateDistanceKm(
                                                          _position!.latitude,
                                                          _position.longitude,
                                                          element
                                                              .coordinates[0],
                                                          element.coordinates[
                                                              1]) <=
                                                      limitDistance,
                                            ))
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              EventDetails(
                                                                  event:
                                                                      event)));
                                                },
                                                child: EventWidget(
                                                  event: event,
                                                  distance: calculateDistanceKm(
                                                      _position!.latitude,
                                                      _position.longitude,
                                                      event.coordinates[0],
                                                      event.coordinates[1]),
                                                ),
                                              )
                                          ],
                                        );
                                      } else {
                                        return const Text('something wrong...');
                                      }
                                    },
                                  );
                                } else if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else if (snapshot.connectionState ==
                                    ConnectionState.active) {
                                  return const Text('is doing...');
                                } else {
                                  return const Text(
                                      'is waiting to do... (somethings off)');
                                }
                              }))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppbarShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;
    var path = Path();
    path.lineTo(0, height - 10);
    path.quadraticBezierTo(width / 2, height, width, height - 50);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
