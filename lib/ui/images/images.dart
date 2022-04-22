import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mahevent/database/firestore_service.dart';
import 'package:image_picker/image_picker.dart';

class Images extends StatefulWidget {
  final Function(String) callbackFunction;
  const Images({Key? key, required this.callbackFunction}) : super(key: key);
  // const Images({Key? key}) : super(key: key);

  @override
  State<Images> createState() => _ImagesState();
}

class _ImagesState extends State<Images> {
  String? url;
  final DatabaseService _service = DatabaseService();

  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    XFile? selected = await _picker.pickImage(source: source);
    print('file path: ${selected!.path}');
    setState(() {
      _imageFile = selected;
    });

    url = await _service.uploadImage(selected);
    print('url from Images widget: ${url}');
    widget.callbackFunction(url!);
    print('file path after calling callback: ${selected.path}');
  }

  void _clear() {
    setState(() {
      _imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            IconButton(
                onPressed: () => _pickImage(ImageSource.camera),
                icon: const Icon(Icons.photo_camera)),
            IconButton(
                onPressed: () => _pickImage(ImageSource.gallery),
                icon: const Icon(Icons.photo_library)),
            IconButton(onPressed: _clear, icon: const Icon(Icons.delete))
          ]),
          if (_imageFile != null)
            Card(
              child: Image.file(File(_imageFile!.path)),
              elevation: 10,
            )
        ],
      ),
    );
  }
}
