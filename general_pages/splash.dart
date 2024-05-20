// ignore_for_file: prefer_const_constructors

import 'package:crown_placing/general_pages/StartPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => StartPage()));
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffc8dcdb),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 160,
            ),
            Center(
              child: Container(
                width: 280.0,
                height: 280.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffdbeef4),
                  image: DecorationImage(
                    image: AssetImage('images/LogoT.jpg'),
                    //fit: BoxFit.fitHeight,
                    //fit: BoxFit.fitWidth,
                    //fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 60),
            Container(
              height: 2,
              width: 280,
              color: Colors.black,
            ),
            const SizedBox(height: 2),
            Text(
              'CrownPlacing',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 2),
            Container(
              height: 2,
              width: 280,
              color: Colors.black,
            ),
            const SizedBox(height: 190),
            Text(
              'Welcome to CrownPlacing',
              style: TextStyle(fontSize: 17, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
