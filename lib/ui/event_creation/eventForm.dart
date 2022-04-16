import 'package:flutter/material.dart';
import 'package:mahevent/database/firestore_service.dart';
import 'package:mahevent/model/event.dart';
import 'package:mahevent/styles.dart';
import 'package:provider/provider.dart';

class EventForm extends StatefulWidget {
  const EventForm({Key? key}) : super(key: key);

  @override
  State<EventForm> createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  final DatabaseService _service = DatabaseService();

  @override
  Widget build(BuildContext context) {
    // var event = Provider.of<Event>(context);
    var event = Event.empty();
    final formKey = GlobalKey<FormState>();

    return Container(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: (SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Title",
                style: TextStyle(fontSize: 20),
              ),
              TextFormField(
                onSaved: (String? title) {
                  event.title = title!;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Description",
                style: TextStyle(fontSize: 20),
              ),
              TextFormField(
                onSaved: (String? description) {
                  event.description = description!;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Duration",
                style: TextStyle(fontSize: 20),
              ),
              TextFormField(
                onSaved: (String? duration) {
                  event.duration = duration!;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Location",
                style: TextStyle(fontSize: 20),
              ),
              TextFormField(
                onSaved: (String? location) {
                  event.location = location!;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Coordinates",
                style: TextStyle(fontSize: 20),
              ),
              TextFormField(
                  // onSaved: (coordinates) {
                  //   // Will do coordinates later
                  //   // event.coordinates = coordinates! as List;
                  // },
                  ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Host",
                style: TextStyle(fontSize: 20),
              ),
              TextFormField(
                onSaved: (String? host) {
                  event.host = host!;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Host Image",
                style: TextStyle(fontSize: 20),
              ),
              TextFormField(
                onSaved: (String? hostImage) {
                  event.hostImage = hostImage!;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "categoryIds",
                style: TextStyle(fontSize: 20),
              ),
              TextFormField(
                  // onSaved: (categoryIds) {
                  //   // Will implement categories later
                  //   // event.categoryIds = categoryIds! as List;
                  // },
                  ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Header",
                style: TextStyle(fontSize: 20),
              ),
              TextFormField(
                onSaved: (String? header) {
                  event.h1 = header!;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Sub-Header",
                style: TextStyle(fontSize: 20),
              ),
              TextFormField(
                onSaved: (String? subHeader) {
                  event.h2 = subHeader!;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Event Images",
                style: TextStyle(fontSize: 20),
              ),
              TextFormField(
                  // onSaved: (String? eventImages) {
                  //   // Will implement event imageslater
                  //   // event.eventImages = eventImages!;
                  // },
                  ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text(
                    'Save',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () async {
                    formKey.currentState?.save();
                    // print("Event object ");
                    // print(event.h1);
                    _service.addEvent(event);
                    formKey.currentState?.reset();
                    event = Event.empty();
                  },
                ),
              )
            ],
          ))),
        ));
  }
}
