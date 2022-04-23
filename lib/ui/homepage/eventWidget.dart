import 'package:flutter/material.dart';
import 'package:mahevent/model/event.dart';
import 'package:mahevent/styles.dart';

class EventWidget extends StatelessWidget {
  final Event event;
  final double distance;
  const EventWidget({Key? key, required this.event, required this.distance})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      color: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(40),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(30),
              ),
              child: Image(
                image: NetworkImage(event.imagePath),
                height: 150,
                fit: BoxFit.fitWidth,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            event.title,
                            style: eventTitleTextStyle,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: <Widget>[
                              Text(
                                event.date.toUpperCase() + ' ',
                                style: appTextStyle.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w200),
                              ),
                              const Icon(
                                Icons.location_on,
                                color: Color.fromARGB(255, 232, 6, 104),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(event.location,
                                  style: appTextStyle.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w200)),
                              Text(
                                  ' (' +
                                      distance.toStringAsPrecision(2) +
                                      ' KM)',
                                  style: appTextStyle.copyWith(
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.w200))
                            ],
                          )
                        ]),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
