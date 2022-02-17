import 'package:flutter/material.dart';
import 'package:mahevent/model/event.dart';
import 'package:mahevent/ui/event_details/eventDetailsBackground.dart';
import 'package:mahevent/ui/event_details/eventDetailsContent.dart';
import 'package:provider/provider.dart';

class EventDetails extends StatelessWidget {
  final Event event;
  const EventDetails({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Provider<Event>.value(
        value: event,
        child: Stack(
          fit: StackFit.expand,
          children: const <Widget>[
            EventDetailsBackground(),
            EventDetailsContent(),
          ],
        ),
      ),
    );
  }
}
