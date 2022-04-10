import 'package:flutter/material.dart';
import 'package:mahevent/styles.dart';
import 'package:mahevent/ui/profile/TextFieldWidget.dart';
import 'package:mahevent/ui/profile/profileWidget.dart';

import '../../model/user.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    final user = mainUser;
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          ProfileWidget(
            imagePath: user.imagePath,
            isEdit: true,
            onClicked: () async {},
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                TextFieldWidget(
                  label: 'Name',
                  text: user.name,
                  onChanged: (name) {},
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFieldWidget(
                  label: 'Username',
                  text: user.username,
                  onChanged: (username) {},
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFieldWidget(
                  label: 'About',
                  text: user.about,
                  maxLines: 3,
                  onChanged: (about) {},
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFieldWidget(
                  label: 'Interest',
                  text: user.interest,
                  maxLines: 2,
                  onChanged: (interest) {},
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                    width: 400,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.pink,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {},
                      child: Text('Save',
                          style: h2TextStyle.copyWith(color: Colors.white)),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
