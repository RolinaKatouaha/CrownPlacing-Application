import 'dart:io';
import 'package:flutter/material.dart';
import '../general_pages/HomeScreen.dart';
import 'package:crown_placing/general_pages/MyHistory.dart';
import 'package:crown_placing/general_pages/Results.dart';
import 'package:crown_placing/general_pages/aiResult.dart';

class DifferentViews extends StatefulWidget {
  final File? Image1;
  final File? Image2;
  final File? Image3;
  final File? Image4;
  final File? Image5;

  const DifferentViews({
    Key? key,
    this.Image1,
    this.Image2,
    this.Image3,
    this.Image4,
    this.Image5,
  }) : super(key: key);

  @override
  State<DifferentViews> createState() => _DifferentViewsState();
}

class _DifferentViewsState extends State<DifferentViews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: AppBar(
          actions: [
            Container(child: Image.asset('images/Logo.jpg')),
          ],
          title: const Column(
            children: [
              Text(
                'Your Images',
                style: TextStyle(
                  color: Color(0xff135679),
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              Text(
                'From Different Views',
                style: TextStyle(
                  color: Color(0xff677b84),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 190)),
                Padding(padding: EdgeInsets.symmetric(horizontal: 25)),
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: widget.Image1 != null
                      ? Image.file(widget.Image1!)
                      : Container(), // Display the image here
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 30)),
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: widget.Image2 != null
                      ? Image.file(widget.Image2!)
                      : Container(), // Display the image here
                ),
              ],
            ),
            Row(
              children: <Widget>[
                const Padding(padding: EdgeInsets.only(top: 100)),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 25)),
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: widget.Image3 != null
                      ? Image.file(widget.Image3!)
                      : Container(), // Display the image here
                ),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 30)),
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: widget.Image4 != null
                      ? Image.file(widget.Image4!)
                      : Container(), // Display the image here
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 30)),
            Padding(padding: EdgeInsets.symmetric(horizontal: 25)),
            Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: widget.Image5 != null
                  ? Image.file(widget.Image5!)
                  : Container(), // Display the image here
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => aiResult(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: 70,
                  vertical: 10,
                ),
                backgroundColor: const Color(0xffb2dedd),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              child: const Text(
                'Save',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Results(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 10,
                ),
                backgroundColor: const Color(0xff2b2f2f),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
