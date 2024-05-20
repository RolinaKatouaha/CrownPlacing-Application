// ignore_for_file: prefer_const_constructors

import 'package:crown_placing/general_pages/HomePage.dart';
import 'package:crown_placing/general_pages/Login.dart';
import 'package:crown_placing/general_pages/Register.dart';
import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 150),
      color: Colors.white,
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image(image: AssetImage('images/Logo.jpg')),
          Padding(padding: EdgeInsets.symmetric(vertical: 15)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 90, vertical: 15),
              backgroundColor: Color(0xffa7d4d1),
              foregroundColor: Color(0xff458784),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            onPressed: () {
              //Navigate to register page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RegisterPage(),
                ),
              );
            },
            child: Text('REGISTER',
                style: TextStyle(
                    color: Color(0xff0f4a64),
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 13)),
          ElevatedButton(
            // ignore: sort_child_properties_last
            child: Text('  LOGIN  ',
                style: TextStyle(
                    color: Color(0xff0f4a64),
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 98.5, vertical: 15),
              backgroundColor: Color(0xffa7d4d1),
              foregroundColor: Color(0xff458784),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            onPressed: () {
              //Navigate to login page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
          ),
          SizedBox(
            height: 50,
            child: TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.grey,
                  shape: ContinuousRectangleBorder()),
              onPressed: () {
                //Navigate to home page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text(
                'Skip for now?',
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



//temp

// body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //       padding: EdgeInsets.symmetric(horizontal: 90, vertical: 15),
            //       backgroundColor: Color(0xffa7d4d1),
            //       foregroundColor: Color(0xff458784),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(5.0),
            //       ),
            //     ),
            //     onPressed: () {
            //       //Navigate to register page
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => const Register(),
            //         ),
            //       );
            //     },
            //     child: Text('REGISTER',
            //         style: TextStyle(
            //             color: Color(0xff0f4a64),
            //             fontSize: 20,
            //             fontWeight: FontWeight.bold)),
            //   ),
            // ),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
//               child: Center(
              //   child: ElevatedButton(
              //     // ignore: sort_child_properties_last
              //     child: Text('  LOGIN  ',
              //         style: TextStyle(
              //             color: Color(0xff0f4a64),
              //             fontSize: 20,
              //             fontWeight: FontWeight.bold)),
              //     style: ElevatedButton.styleFrom(
              //       padding:
              //           EdgeInsets.symmetric(horizontal: 98.5, vertical: 15),
              //       backgroundColor: Color(0xffa7d4d1),
              //       foregroundColor: Color(0xff458784),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(5.0),
              //       ),
              //     ),
              //     onPressed: () {
              //       //Navigate to login page
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => const Login(),
              //         ),
              //       );
              //     },
              //   ),
              // ),
//             ),
            // SizedBox(
            //   height: 40,
            //   child: TextButton(
            //     style: TextButton.styleFrom(
            //         foregroundColor: Colors.grey,
            //         shape: ContinuousRectangleBorder()),
            //     onPressed: () {
            //       //Navigate to home page
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(builder: (context) => HomePage()),
            //       );
            //     },
            //     child: Text(
            //       'Skip for now?',
            //       style: TextStyle(color: Colors.grey, fontSize: 15),
            //     ),
            //   ),
            // ),
//           ]),