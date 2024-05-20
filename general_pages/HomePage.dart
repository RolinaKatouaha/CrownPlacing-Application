// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables

import 'package:crown_placing/general_pages/HomeScreen.dart';
import 'package:crown_placing/general_pages/Profile.dart';
import 'package:crown_placing/general_pages/Results.dart';
import 'package:crown_placing/instructor_pages/History.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});
  static String? historyValue;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedPage = 0;

  final List _pageOptions = [
    const HomeScreen(),
    const Results(),
    History(),
    const Profile(),
  ];
// Variable to hold the value to be passed to History screen
  DateTime? currentBackPressTime;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // عند الضغط على زر الرجوع
          if (currentBackPressTime == null ||
              DateTime.now().difference(currentBackPressTime!) >
                  Duration(seconds: 2)) {
            currentBackPressTime = DateTime.now();
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Confirm Exit'),
                  content: Text('Are you sure you want to exit?'),
                  actions: <Widget>[
                    TextButton(
                      child: Text('No'),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                    ),
                    TextButton(
                      child: Text('Yes'),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                    ),
                  ],
                );
              },
            );
            return false;
          }
          return true;
        },
        child: Scaffold(
            backgroundColor: Colors.white,
            body: _pageOptions[selectedPage],
            bottomNavigationBar: BottomNavigationBar(
              items: [
                //home
                const BottomNavigationBarItem(
                  activeIcon: Icon(
                    Icons.home,
                    color: Color(0xff74b1b1),
                  ),
                  icon: Icon(
                    Icons.home_outlined,
                    color: Colors.grey,
                  ),
                  label: '',
                ),
                //results
                const BottomNavigationBarItem(
                  activeIcon: Icon(
                    Icons.camera_alt,
                    color: Color(0xff74b1b1),
                  ),
                  icon: Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.grey,
                  ),
                  label: '',
                ),
                //history
                const BottomNavigationBarItem(
                  activeIcon: Icon(
                    Icons.bookmark,
                    color: Color(0xff74b1b1),
                  ),
                  icon: Icon(
                    Icons.bookmark_border_outlined,
                    color: Colors.grey,
                  ),
                  label: '',
                ),
                //profile
                const BottomNavigationBarItem(
                  activeIcon: Icon(
                    Icons.person,
                    color: Color(0xff74b1b1),
                  ),
                  icon: Icon(
                    Icons.person_outline,
                    color: Colors.grey,
                  ),
                  label: '',
                ),
              ],
              currentIndex: selectedPage,
              onTap: (index) async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                setState(() {
                  selectedPage = index;
                  if (index == 2) {
                    print(
                        "----------------${prefs.getString("type")}---------------------");
                    // Check if the History screen is selected
                    HomePage.historyValue = prefs.getString(
                        "type"); // Set the desired value to be passed
                  } else {
                    HomePage.historyValue =
                        null; // Reset the value if another screen is selected
                  }
                });
              },
            )));
  }
}
