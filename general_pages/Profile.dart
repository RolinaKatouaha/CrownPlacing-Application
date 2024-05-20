import 'package:flutter/material.dart';
import '../general_pages/EditProfile.dart';
import '../general_pages/StartPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(user.uid)
          .get();
      return snapshot;
    } else {
      throw Exception("User not found");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: AppBar(
            actions: [Container(child: Image.asset('images/Logo.jpg'))],
            automaticallyImplyLeading: false,
            title: const Text(
              'Profile',
              style: TextStyle(
                  color: Color(0xff135679),
                  fontWeight: FontWeight.bold,
                  fontSize: 23),
            ),
          ),
        ),
        body: FutureBuilder<DocumentSnapshot>(
          future: getUserData(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.hasData && snapshot.data!.exists) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;

              return Scaffold(
                  // ... rest of the widget tree
                  body: SingleChildScrollView(
                      child: Column(children: [
                const Padding(padding: EdgeInsets.only(top: 25)),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 160),
                  child: Icon(
                    Icons.account_circle_outlined,
                    size: 90,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 55)),
                Container(
                    width: 300,
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xffe5edf1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(data["name"]),
                        Icon(Icons.account_circle_outlined),
                      ],
                    )),
                const Padding(padding: EdgeInsets.only(top: 25)),
                Container(
                    width: 300,
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xffe5edf1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(data["email"]),
                        Icon(Icons.mail_rounded),
                      ],
                    )),
                const Padding(padding: EdgeInsets.only(top: 25)),
                Container(
                    width: 300,
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xffe5edf1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(data["user_type"]),
                        Icon(Icons.person),
                      ],
                    )),
                const Padding(padding: EdgeInsets.only(top: 20)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                    backgroundColor: const Color(0xffb2dedd),
                    foregroundColor: const Color(0xff458784),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditProfile(),
                      ),
                    );
                  },
                  child: const Text('Edit profile',
                      style: TextStyle(
                          color: Color(0xff135679),
                          fontSize: 22,
                          fontWeight: FontWeight.bold)),
                ),
                const Padding(padding: EdgeInsets.only(top: 18)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                    backgroundColor: const Color(0xffb2dedd),
                    foregroundColor: const Color(0xff458784),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onPressed: () {
                    //Navigate to MyHistory page
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const StartPage(),
                      ),
                    );
                  },
                  child: const Text('Log Out',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 19,
                          fontWeight: FontWeight.bold)),
                ),
              ])));
            }

            return Text('No user data found');
          },
        ));
  }
}
