import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mahevent/styles.dart';
import 'package:mahevent/ui/profile/editProfile.dart';
import 'package:mahevent/ui/profile/profileWidget.dart';
import 'package:mahevent/database/firestore_service.dart';

import '../../model/user.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final DatabaseService _service = DatabaseService();

  @override
  Widget build(BuildContext context) {
    // final user = mainUser;
    return Scaffold(
        body: FutureBuilder(
      future: _service.getUser(),
      builder: (context, AsyncSnapshot<User> snapshot) {
        if (snapshot.hasData) {
          User user = snapshot.data!;
          return ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              ProfileWidget(
                imagePath: user.imagePath,
                onClicked: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const EditProfile()),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Text(
                    user.name,
                    style: h1TextStyle,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    '@' + user.username,
                    style: hostTextStyle,
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'About',
                        style: h2TextStyle,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      user.about,
                      style: appTextStyle.copyWith(
                          color: Colors.black, fontWeight: FontWeight.w200),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Interest',
                        style: h2TextStyle,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      user.interest,
                      style: appTextStyle.copyWith(
                          color: Colors.black, fontWeight: FontWeight.w200),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ));
  }
}
