import 'package:flutter/material.dart';
import 'package:mahevent/ui/event_creation/eventCreation.dart';
import 'package:mahevent/ui/event_creation/eventForm.dart';
import 'package:mahevent/ui/homepage/homepage.dart';
import 'package:mahevent/ui/profile/profile.dart';
import 'package:mahevent/ui/event_creation/eventCreation.dart';
import 'package:mahevent/styles.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentTab = 0;
  final List<Widget> screens = [
    const HomePage(),
    const Profile(),
    const EventForm()
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currrentScreen = const HomePage();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: ClipPath(
          clipper: AppbarShape(),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromARGB(255, 255, 28, 100),
                  Color.fromARGB(255, 26, 134, 249),
                ],
              ),
            ),
            width: screenWidth,
            child: Center(
                child: Text(
              currentTab == 0 ? 'Mah Event Explorer' : 'Profile',
              style: appTextStyle,
            )),
          ),
        ),
      ),
      body: PageStorage(
        child: currrentScreen,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add_rounded,
          size: 35,
        ),
        backgroundColor: const Color.fromARGB(255, 232, 6, 104),
        onPressed: () {
          setState(() {
            currrentScreen = const EventForm();
            currentTab = 2;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currrentScreen = const HomePage();
                          currentTab = 0;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.pin_drop_rounded,
                              size: 35,
                              color: currentTab == 0
                                  ? const Color.fromARGB(255, 232, 6, 104)
                                  : Colors.grey),
                          Text(
                            'Explore',
                            style: currentTab == 0
                                ? selectedCategoryTextStyle
                                : categoryTextStyle.copyWith(
                                    color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currrentScreen = const Profile();
                          currentTab = 1;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.person,
                              size: 35,
                              color: currentTab == 1
                                  ? const Color.fromARGB(255, 232, 6, 104)
                                  : Colors.grey),
                          Text(
                            'Profile',
                            style: currentTab == 1
                                ? selectedCategoryTextStyle
                                : categoryTextStyle.copyWith(
                                    color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
