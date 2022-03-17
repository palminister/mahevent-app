import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseService _service = DatabaseService();
  Future<List<Event>>? _eventList;
  List<Event>? _retrievedEventList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initRetrieval();
  }

  Future<void> _initRetrieval() async {
    _eventList = _service.retrieveEvents();
    _retrievedEventList = await _service.retrieveEvents();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    // final _events = DatabaseService().retrieveEvents();

    return Scaffold(
      // appBar: AppBar(
      //   toolbarHeight: 80,
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   flexibleSpace: ClipPath(
      //     clipper: AppbarShape(),
      //     child: Container(
      //       decoration: const BoxDecoration(
      //         gradient: LinearGradient(
      //           begin: Alignment.topCenter,
      //           end: Alignment.bottomLeft,
      //           colors: [
      //             Color.fromARGB(255, 255, 28, 100),
      //             Color.fromARGB(255, 26, 134, 249),
      //           ],
      //         ),
      //       ),
      //       width: screenWidth,
      //       child: const Center(
      //           child: Text(
      //         'MAH EVENT',
      //         style: appTextStyle,
      //       )),
      //     ),
      //   ),
      // ),
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
                              future: _eventList,
                              builder: (context,
                                  AsyncSnapshot<List<Event>> snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                    child: Text('No data'),
                                  );
                                }

                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                }

                                return Column(
                                  children: <Widget>[
                                    for (final event
                                        in _retrievedEventList!.where(
                                      (element) => element.categoryIds
                                          .contains(states.selectedCategory),
                                    ))
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EventDetails(
                                                          event: event)));
                                        },
                                        child: EventWidget(event: event),
                                      )
                                  ],
                                );
                              })

                          // builder: (context, states, _) => Column(
                          //   children: <Widget>[
                          //     for (final event in events.where(
                          //       (element) => element.categoryIds
                          //           .contains(states.selectedCategory),
                          //     ))
                          //       GestureDetector(
                          //         onTap: () {
                          //           Navigator.of(context).push(MaterialPageRoute(
                          //             builder: (context) =>
                          //                 EventDetails(event: event),
                          //           ));
                          //         },
                          //         child: EventWidget(event: event),
                          //       )
                          //   ],
                          // ),

                          )
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
