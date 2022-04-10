import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final bool isEdit;
  final VoidCallback onClicked;

  const ProfileWidget(
      {Key? key,
      required this.imagePath,
      this.isEdit = false,
      required this.onClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          ClipOval(
            child: Material(
              color: Colors.transparent,
              child: Ink.image(
                image: NetworkImage(imagePath),
                fit: BoxFit.cover,
                width: 130,
                height: 130,
                child: InkWell(
                  onTap: onClicked,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 4,
            child: ClipOval(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                color: Colors.pink,
                child: Icon(
                  isEdit ? Icons.add_a_photo : Icons.edit,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
