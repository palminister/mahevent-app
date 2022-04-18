import 'package:flutter/material.dart';
import 'package:mahevent/database/firestore_service.dart';
import 'package:mahevent/model/category.dart';
import 'package:mahevent/model/event.dart';
import 'package:mahevent/styles.dart';
import 'package:mahevent/ui/images/images.dart';
import 'package:provider/provider.dart';

class EventForm extends StatefulWidget {
  const EventForm({Key? key}) : super(key: key);

  @override
  State<EventForm> createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  final DatabaseService _service = DatabaseService();

  String? _currentSelectedValue = "All";

  var a = categories;

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
              // Title
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
              // Description
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
              // Duration
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
              // Location
              const Text(
                "Location name",
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

              // Category dropdown
              const Text(
                "Category",
                style: TextStyle(fontSize: 20),
              ),
              FormField<String>(
                builder: (FormFieldState<String> state) {
                  return InputDecorator(
                      decoration: InputDecoration(
                          errorStyle: const TextStyle(
                              color: Colors.redAccent, fontSize: 16.0),
                          hintText: "Please select expense",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                      isEmpty: _currentSelectedValue == '',
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _currentSelectedValue,
                          isDense: true,
                          onChanged: (newValue) {
                            setState(() {
                              _currentSelectedValue = newValue;
                            });
                          },
                          items: categories.map((Category _cat) {
                            return DropdownMenuItem(
                                value: _cat.name, child: Text(_cat.name));
                          }).toList(),
                        ),
                      ));
                },
              ),
              const SizedBox(
                height: 15,
              ),
              // Header of event info
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
              // Sub header of event info
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
              // Image of event
              const Text(
                "Event Image",
                style: TextStyle(fontSize: 20),
              ),
              const Images(),
              // TextFormField(
              //     // onSaved: (String? eventImages) {
              //     //   // Will implement event imageslater
              //     //   // event.eventImages = eventImages!;
              //     // },
              //     ),
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
