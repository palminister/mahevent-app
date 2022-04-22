import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mahevent/database/firestore_service.dart';

class ProfileImage extends StatefulWidget {
  final String imagePath;
  final Function(String) callbackFn;
  const ProfileImage(
      {Key? key, required this.imagePath, required this.callbackFn})
      : super(key: key);

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  XFile? _imageFile;
  String? url;
  final ImagePicker _picker = ImagePicker();
  final DatabaseService _service = DatabaseService();

  Future<void> _pickImage(ImageSource source) async {
    XFile? selected = await _picker.pickImage(source: source);
    print('file path: ${selected!.path}');
    setState(() {
      _imageFile = selected;
    });

    url = await _service.uploadImage(selected);
    print('url from Images widget: ${url}');
    widget.callbackFn(url!);
    print('file path after calling callback: ${selected.path}');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          ClipOval(
              child: Material(
            color: Colors.transparent,
            child: Ink.image(
              image: NetworkImage(widget.imagePath),
              fit: BoxFit.cover,
              width: 130,
              height: 130,
            ),
          )),
          Positioned(
            bottom: 0,
            right: 4,
            child: ClipOval(
              child: Container(
                  color: Colors.pink,
                  child: IconButton(
                      onPressed: () => _pickImage(ImageSource.gallery),
                      icon: const Icon(
                        Icons.add_a_photo,
                        color: Colors.white,
                        size: 28,
                      ))),
            ),
          )
        ],
      ),
    );
  }
}
