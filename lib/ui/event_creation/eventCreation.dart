import 'package:flutter/material.dart';
import 'package:mahevent/model/event.dart';
import 'package:provider/provider.dart';
import 'package:mahevent/ui/event_creation/eventForm.dart';

class EventCreation extends StatefulWidget {
  const EventCreation({Key? key}) : super(key: key);

  @override
  State<EventCreation> createState() => _EventCreationState();
}

class _EventCreationState extends State<EventCreation> {
  // final formKey = GlobalKey<FormState>();
  final event = Event.empty();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Provider<Event>.value(
        value: event,
        child: Stack(fit: StackFit.expand, children: const <Widget>[
          EventForm(),
        ]),
      ),
    );
  }
}
