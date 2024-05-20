import 'package:crown_placing/general_pages/Profile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> updateEmailAndPassword(
      String newEmail, String newPassword) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await user.updateEmail(newEmail);
        await user.updatePassword(newPassword);
        // Refresh the user object to get the updated data
        User refreshedUser = FirebaseAuth.instance.currentUser!;
        // Print the updated email and password
        print('Updated email: ${refreshedUser.email}');
        print(
            'Updated password: ********'); // Passwords are not accessible for security reasons
      } catch (error) {
        print('Failed to update email and password: $error');
      }
    }
  }

  Future<void> getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(user.uid)
          .get();
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      _passwordController.text = data['user_type'];
      _emailController.text = data['email'];
    }
  }

  Future<void> updateUserProfile() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({
        'password': _passwordController.text,
        'email': _emailController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          actions: [Image.asset('images/Logo.jpg')],
          automaticallyImplyLeading: false,
          title: const Text(
            'EditProfile',
            style: TextStyle(
                color: Color(0xff135679),
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'user type',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                backgroundColor: const Color(0xff2b2f2f),
                foregroundColor: const Color(0xffffffff),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              onPressed: () {
                updateUserProfile().then((_) {
                  if (_passwordController.text.isNotEmpty &&
                      _emailController.text.isNotEmpty)
                    updateEmailAndPassword(
                        _passwordController.text, _emailController.text);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Profile updated successfully!'),
                    ),
                  );
                  _emailController.clear();
                  _passwordController.clear();
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Profile(),
                    ),
                  );
                }).catchError((error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to update profile: $error'),
                    ),
                  );
                });
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
