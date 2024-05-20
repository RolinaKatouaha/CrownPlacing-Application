import 'package:crown_placing/instructor_pages/History.dart';
import 'package:flutter/material.dart';

class MyHistory extends StatefulWidget {
  MyHistory({super.key, this.uid});
  String? uid;
  @override
  State<MyHistory> createState() => _MyHistoryState();
}

class _MyHistoryState extends State<MyHistory> {
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
            'My History',
            style: TextStyle(
                color: Color(0xff135679),
                fontWeight: FontWeight.bold,
                fontSize: 23),
          ),
          backgroundColor: const Color(0xffdbf0f5),
        ),
      ),
      body: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(padding: EdgeInsets.symmetric(horizontal: 300)),
            const Padding(padding: EdgeInsets.only(top: 35)),
            Expanded(
              child: Container(
                width: 350,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 4,
                      offset: Offset(0, 4), // Shadow position
                    ),
                  ],
                  border: Border.all(
                    color: const Color(0xffc9dad8),
                    width: 1,
                  ),
                ),
                child: const Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                      child: Row(
                        children: [
                          Text('good result',
                              style: TextStyle(
                                color: Color(0xff135679),
                                fontSize: 15,
                              )),
                          Spacer(
                            flex: 1,
                          ),
                          Text('Application: 80%',
                              style: TextStyle(
                                color: Color(0xff135679),
                                fontSize: 15,
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                      child: Row(
                        children: [
                          Text('has been corrected',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              )),
                          Spacer(
                            flex: 1,
                          ),
                          Text('Instructor: ',
                              style: TextStyle(
                                color: Color(0xff135679),
                                fontSize: 15,
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
    );
  }
}
