import 'package:flutter/material.dart';
import 'package:mahevent/styles.dart';
import 'package:mahevent/ui/profile/TextFieldWidget.dart';
import 'package:mahevent/ui/profile/profileWidget.dart';
import 'package:mahevent/database/firestore_service.dart';

import '../../model/user.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final DatabaseService _service = DatabaseService();

  @override
  Widget build(BuildContext context) {
    User user = mainUser;
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: (SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Name",
                        style: TextStyle(fontSize: 20),
                      ),
                      TextFormField(
                        initialValue: user.name,
                        onSaved: (name) {
                          user.name = name!;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Username",
                        style: TextStyle(fontSize: 20),
                      ),
                      TextFormField(
                        initialValue: user.username,
                        onSaved: (username) {
                          user.username = username!;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "About",
                        style: TextStyle(fontSize: 20),
                      ),
                      TextFormField(
                        initialValue: user.about,
                        maxLines: 3,
                        onSaved: (about) {
                          user.about = about!;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Interest",
                        style: TextStyle(fontSize: 20),
                      ),
                      TextFormField(
                        initialValue: user.interest,
                        maxLines: 2,
                        onSaved: (interest) {
                          user.interest = interest!;
                        },
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
                            onPressed: () async {
                              formKey.currentState?.save();
                              print(user.name);
                              print(user.interest);
                              print(user.username);
                              print(user.about);
                              await _service.editUser(user);
                              formKey.currentState?.reset();
                            },
                            child: Text('Save',
                                style:
                                    h2TextStyle.copyWith(color: Colors.white)),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
