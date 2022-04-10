import 'package:flutter/material.dart';
import 'package:mahevent/styles.dart';
import 'package:mahevent/ui/profile/editProfile.dart';
import 'package:mahevent/ui/profile/profileWidget.dart';

import '../../model/user.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final user = mainUser;
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: user.imagePath,
            onClicked: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const EditProfile()),
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
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
          //   child: Column(
          //     children: [
          //       Align(
          //         alignment: Alignment.centerLeft,
          //         child: Text(
          //           'Hosted Events',
          //           style: h2TextStyle,
          //         ),
          //       ),
          //       const SizedBox(
          //         height: 4,
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
