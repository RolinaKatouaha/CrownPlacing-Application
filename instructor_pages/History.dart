// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:crown_placing/general_pages/HomePage.dart';
import 'package:crown_placing/general_pages/MyHistory.dart';
import 'package:crown_placing/instructor_pages/StudentHistory.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class History extends StatefulWidget {
  const History({super.key, this.type});
  final String? type;
  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    final historyValue = HomePage.historyValue;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.grey,
            ),
          ),
          actions: [Container(child: Image.asset('images/LogoT.jpg'))],
          automaticallyImplyLeading: false,
          title: Column(
            children: [
              Text(
                'Crown Preparation',
                style: TextStyle(
                    color: Color(0xff135679),
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              Text(
                'History',
                style: TextStyle(
                    color: Color(0xff677b84),
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              )
            ],
          ),
          backgroundColor: const Color(0xffdbf0f5),
        ),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 90, vertical: 15),
                  backgroundColor: const Color(0xffb2dedd),
                  foregroundColor: const Color(0xff458784),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onPressed: () {
                  //Navigate to register page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyHistory(
                          uid: FirebaseAuth.instance.currentUser!.uid),
                    ),
                  );
                },
                child: const Text('My History',
                    style: TextStyle(
                        color: Color(0xff135679),
                        fontSize: 22,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            (historyValue == "instructor")
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Center(
                      child: ElevatedButton(
                        // ignore: sort_child_properties_last
                        child: const Text('Students History',
                            style: TextStyle(
                                color: Color(0xff135679),
                                fontSize: 22,
                                fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 63, vertical: 15),
                          backgroundColor: const Color(0xffb2dedd),
                          foregroundColor: const Color(0xff458784),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        onPressed: () {
                          //Navigate to login page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StudentHistory(),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                : Container()
          ]),
    );
  }
}
