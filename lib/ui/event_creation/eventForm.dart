import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mahevent/database/firestore_service.dart';
import 'package:mahevent/model/category.dart';
import 'package:mahevent/model/event.dart';
import 'package:mahevent/styles.dart';
import 'package:mahevent/ui/images/images.dart';
import 'package:provider/provider.dart';

// Passing data around with callback
// https://www.digitalocean.com/community/tutorials/flutter-widget-communication

// Listen to global variable with ValueListenableBuilder
// https://stackoverflow.com/questions/62007967/updating-a-widget-when-a-global-variable-changes-async-in-flutter

final isSetUrl = ValueNotifier<bool>(false);

class EventForm extends StatefulWidget {
  const EventForm({Key? key}) : super(key: key);

  @override
  State<EventForm> createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  final DatabaseService _service = DatabaseService();

  Category? _currentSelectedValue = allCategory;

  var a = categories;
  late String downloadUrl;

  // void _callback(String url) {
  //   print(url);
  //   downloadUrl = url;
  //   isSetUrl.value = true;
  // }

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
              Images(callbackFunction: (url) {
                print('url from eventForm widget ${url}');
                setState(() {
                  downloadUrl = url;
                });
                // downloadUrl = url;
                isSetUrl.value = true;
              }),
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
                            // print("Event object ");
                            // print(event.h1);
                            event.categoryIds = [_currentSelectedValue!.id];

                            event.imagePath = downloadUrl;
                            print("eventID : ${event.categoryIds}");
                            print("event url : ${event.imagePath}");
                            await _service.addEvent(event);
                            formKey.currentState?.reset();
                            event = Event.empty();
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
                  ))
            ],
          ))),
        ));
  }
}

// class Images extends StatefulWidget {
//   const Images({Key? key}) : super(key: key);

//   @override
//   State<Images> createState() => _ImagesState();
// }

// class _ImagesState extends State<Images> {
//   @override
//   Widget build(BuildContext context) {
//     return const ImageCapture();
//   }
// }

// class ImageCapture extends StatefulWidget {
//   const ImageCapture({Key? key}) : super(key: key);

//   @override
//   State<ImageCapture> createState() => _ImageCaptureState();
// }

// class _ImageCaptureState extends State<ImageCapture> {
//   XFile? _imageFile;
//   final DatabaseService _service = DatabaseService();
//   final ImagePicker _picker = ImagePicker();

//   Future<void> _pickImage(ImageSource source) async {
//     XFile? selected = await _picker.pickImage(source: source);

//     setState(() {
//       _imageFile = selected;
//     });

//     url = await _service.uploadImage(selected!);
//     print('local url after service: ${url}');
//   }

//   // Future<String> getUrl(Reference ref) async {
//   //   return await ref.getDownloadURL();
//   // }

//   void _clear() {
//     setState(() {
//       _imageFile = null;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         children: <Widget>[
//           Row(mainAxisAlignment: MainAxisAlignment.start, children: [
//             IconButton(
//                 onPressed: () => _pickImage(ImageSource.camera),
//                 icon: const Icon(Icons.photo_camera)),
//             IconButton(
//                 onPressed: () => _pickImage(ImageSource.gallery),
//                 icon: const Icon(Icons.photo_library)),
//             IconButton(onPressed: _clear, icon: const Icon(Icons.delete))
//           ]),
//           if (_imageFile != null)
//             Card(
//               child: Image.file(File(_imageFile!.path)),
//               elevation: 10,
//             )
//         ],
//       ),
//     );
//   }
// }
