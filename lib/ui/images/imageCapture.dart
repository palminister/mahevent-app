import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ImageCapture extends StatefulWidget {
  const ImageCapture({Key? key}) : super(key: key);

  @override
  State<ImageCapture> createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    XFile? selected = await _picker.pickImage(source: source);

    setState(() {
      _imageFile = selected;
    });
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
