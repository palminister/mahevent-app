import 'package:flutter/material.dart';

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
    return const Scaffold(
        // body: ListView(
        //   physics: BouncingScrollPhysics(),
        //   children: [
        //     ProfileWidget(
        //       imagePath: user.imagePath,
        //     )
        //   ],
        // ),
        );
  }
}
