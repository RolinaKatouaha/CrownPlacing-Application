import 'package:crown_placing/general_pages/MyHistory.dart';
import 'package:crown_placing/instructor_pages/History.dart';
import 'package:crown_placing/instructor_pages/InsertGrade.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'showImages.dart';

class StudentHistory extends StatefulWidget {
  const StudentHistory({Key? key});

  @override
  State<StudentHistory> createState() => _StudentHistoryState();
}

class _StudentHistoryState extends State<StudentHistory> {
  List<Map<String, dynamic>> studentNames = [];
  List<String> timestamps = [
    'Today at 9:20 am',
    'Yesterday at 3:45 pm',
    '2 days ago at 11:10 am',
    '3 days ago at 6:30 pm',
    '4 days ago at 2:15 pm'
  ];

  @override
  void initState() {
    super.initState();
    fetchStudentNamesAndUid();
  }

  Future<void> fetchStudentNamesAndUid() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('user_type', isEqualTo: 'student')
        .get();

    setState(() {
      studentNames = snapshot.docs
          .map((doc) => {'name': doc['name'], 'uid': doc.id})
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => History(),
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
          title: const Text(
            'Students History',
            style: TextStyle(
                color: Color(0xff135679),
                fontWeight: FontWeight.bold,
                fontSize: 23),
          ),
          backgroundColor: const Color(0xffdbf0f5),
        ),
      ),
      body: ListView.builder(
        itemCount: studentNames.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
            child: Column(
              children: [
                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color(0xFFF3F9F9),
                      border: Border.all(
                        color: Color(0xff135679),
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          studentNames[index]['name'],
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          timestamps[index % timestamps.length],
                          style: TextStyle(
                            color: Color(0xff135679),
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MyHistory(),
                                  ),
                                );
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Color(0xffc5d9d7),
                                ),
                              ),
                              child: Text(
                                'View',
                                style: TextStyle(
                                  color: Color(0xff135679),
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => InsertGrades(
                                      name: studentNames[index]['name'],
                                      uid: studentNames[index]['uid'],
                                    ),
                                  ),
                                );
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Color(0xffc5d9d7),
                                ),
                              ),
                              child: Text(
                                'Insert Grade',
                                style: TextStyle(
                                  color: Color(0xff135679),
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ShowMyImages(
                                        uid: studentNames[index]['uid'],
                                      ),
                                    ),
                                  );
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Color(0xffc5d9d7),
                                  ),
                                ),
                                child: Text(
                                  'images',
                                  style: TextStyle(
                                    color: Color(0xff135679),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
