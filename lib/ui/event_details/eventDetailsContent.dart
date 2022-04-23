import 'package:flutter/material.dart';
import 'package:mahevent/styles.dart';
import 'package:provider/provider.dart';

import '../../model/event.dart';

class EventDetailsContent extends StatelessWidget {
  const EventDetailsContent({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final event = Provider.of<Event>(context);

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(
                screenWidth * 0.2, 40.0, screenWidth * 0.2, 0.0),
            child: SizedBox(
              height: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    event.title,
                    style: eventWhiteTitleTextStyle,
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.date_range,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              event.datetime.toUpperCase() + ' ',
                              style: appTextStyle.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w200),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(event.location,
                                style: appTextStyle.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w200))
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              top: 10,
            ),
            child: ClipOval(
                child: Image(
              image: NetworkImage(event.hostImage),
              width: 130,
              height: 130,
              fit: BoxFit.cover,
            )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 10),
            child: Text("Hosted by: " + event.host, style: hostTextStyle),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    event.h1 + '! ',
                    style: h1TextStyle,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    event.h2,
                    style: h2TextStyle,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 16),
            child: Text(
              event.description,
              style: appTextStyle.copyWith(
                  color: Colors.black, fontWeight: FontWeight.w200),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
