import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mahevent/database/firestore_service.dart';
import 'package:mahevent/model/category.dart';
import 'package:mahevent/model/event.dart';
import 'package:mahevent/styles.dart';
import 'package:mahevent/ui/images/images.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';

// Passing data around with callback
// https://www.digitalocean.com/community/tutorials/flutter-widget-communication

// Listen to global variable with ValueListenableBuilder
// https://stackoverflow.com/questions/62007967/updating-a-widget-when-a-global-variable-changes-async-in-flutter

// Persist form data to controller during rerendering
// from Arm Flutter God
// https://api.flutter.dev/flutter/widgets/TextEditingController-class.html
final isSetUrl = ValueNotifier<bool>(false);

class EventForm extends StatefulWidget {
  const EventForm({Key? key}) : super(key: key);

  @override
  State<EventForm> createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  final DatabaseService _service = DatabaseService();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _datetimeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _headerController = TextEditingController();
  final TextEditingController _subHeaderController = TextEditingController();
  Category? _currentSelectedValue = allCategory;

  var a = categories;
  String? downloadUrl;

  void clearForm() {
    _titleController.clear();
    _descriptionController.clear();
    _datetimeController.clear();
    _locationController.clear();
    _headerController.clear();
    _subHeaderController.clear();
    setState(() {
      downloadUrl = null;
    });
  }

  Future<List<double>> getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print('Position:');
    print('latitude: ${position.latitude}');
    print('longtitude: ${position.longitude}');
    return [position.latitude, position.longitude];
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _datetimeController.dispose();
    _locationController.dispose();
    _headerController.dispose();
    _subHeaderController.dispose();
    super.dispose();
  }

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
                controller: _titleController,
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
                controller: _descriptionController,
                onSaved: (String? description) {
                  event.description = description!;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              // Date
              const Text(
                "Date",
                style: TextStyle(fontSize: 20),
              ),
              TextFormField(
                controller: _datetimeController,
                onSaved: (String? datetime) {
                  event.datetime = datetime!;
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
                controller: _locationController,
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
              FormField<Category>(
                builder: (FormFieldState<Category> state) {
                  return InputDecorator(
                      decoration: InputDecoration(
                          errorStyle: const TextStyle(
                              color: Colors.redAccent, fontSize: 16.0),
                          hintText: "Please select expense",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                      isEmpty: _currentSelectedValue == null,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<Category>(
                          value: _currentSelectedValue,
                          isDense: true,
                          onChanged: (newValue) {
                            setState(() {
                              _currentSelectedValue = newValue;
                            });
                          },
                          items: categories.map((Category _cat) {
                            return DropdownMenuItem(
                                value: _cat, child: Text(_cat.name));
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
                controller: _headerController,
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
                controller: _subHeaderController,
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
              Images(callbackFunction: (url) {
                setState(() {
                  downloadUrl = url;
                });
                isSetUrl.value = true;
              }),
              if (downloadUrl != null)
                Image(
                  image: NetworkImage(downloadUrl!),
                ),
              SizedBox(
                  width: double.infinity,
                  child: ValueListenableBuilder(
                    valueListenable: isSetUrl,
                    builder: (context, value, widget) {
                      if (value == true) {
                        return ElevatedButton(
                          child: const Text(
                            'Save',
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () async {
                            formKey.currentState?.save();

                            var coordinates = await getCurrentLocation();
                            event.coordinates = coordinates;
                            event.categoryIds = [0, _currentSelectedValue!.id];
                            event.imagePath = downloadUrl!;

                            await _service.addEvent(event);
                            formKey.currentState?.reset();
                            event = Event.empty();
                            clearForm();
                          },
                        );
                      } else {
                        return ElevatedButton(
                            onPressed: () => null,
                            child: const Text('Hold on...'),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.black54));
                      }
                    },
                  )),
              const SizedBox(height: 70)
            ],
          ))),
        ));
  }
}
