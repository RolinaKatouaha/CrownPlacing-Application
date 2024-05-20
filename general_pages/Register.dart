import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Login.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String? user = 'student';
  bool _isRegistering = false;
  bool isInstructor = false;
  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isRegistering = true;
      });

      try {
        final String name = _nameController.text.trim();
        final String email = _emailController.text.trim();
        final String password = _passwordController.text.trim();

        // Check if email already exists
        bool emailExists = await _checkEmailExists(email);
        if (emailExists) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Error'),
              content:
                  Text('Email already exists. Please try a different email.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );
          setState(() {
            _isRegistering = false;
          });
          return;
        }

        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        await userCredential.user!.sendEmailVerification();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'name': name,
          'email': email,
          'user_type': user,
          'password': password,
          'uid': FirebaseAuth.instance.currentUser!.uid
        });

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => VerifyEmailPage()));
      } catch (e) {
        print(e);
        setState(() {
          _isRegistering = false;
        });
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Registration failed. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  Future<bool> _checkEmailExists(String email) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: AppBar(
            actions: [
              Container(
                child: Image.asset(
                  'images/Logo.jpg',
                  fit: BoxFit.contain,
                ),
              )
            ],
            automaticallyImplyLeading: false,
          ),
        ),
        body: SingleChildScrollView(
            child: Center(
                child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //Register message
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Create your Account",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff135679),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                          const SizedBox(height: 15), //leave space

                          // Sign Message
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "We are happy to see you here!",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.start,
                                textDirection: TextDirection.ltr,
                              ),
                            ],
                          ),

                          const SizedBox(height: 70), //leave space
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 243, 241, 241),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: TextFormField(
                                          controller: _nameController,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "  Name",
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter your name';
                                            }
                                            return null;
                                          },
                                        ))),
                                SizedBox(height: 16.0),
                                Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 243, 241, 241),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: TextFormField(
                                          controller: _emailController,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "  Email"),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter an email';
                                            }
                                            return null;
                                          },
                                        ))),
                                SizedBox(height: 16.0),
                                Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 243, 241, 241),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: TextFormField(
                                          controller: _passwordController,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "  Password",
                                          ),
                                          obscureText: true,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter a password';
                                            }
                                            return null;
                                          },
                                        ))),
                                SizedBox(height: 16.0),
                                Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 243, 241, 241),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: TextFormField(
                                          controller:
                                              _confirmPasswordController,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "  Conform Password",
                                          ),
                                          obscureText: true,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please confirm your password';
                                            }
                                            if (value !=
                                                _passwordController.text) {
                                              return 'Passwords do not match';
                                            }
                                            return null;
                                          },
                                        ))),
                                // Instructor or Student Radio
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Radio<String>(
                                      value: "instructor",
                                      groupValue: user,
                                      onChanged: (val) {
                                        setState(() {
                                          user = val;
                                        });
                                      },
                                    ),
                                    Text('Instructor'),
                                    Radio<String>(
                                      value: "student",
                                      groupValue: user,
                                      onChanged: (val) {
                                        setState(() {
                                          user = val;
                                        });
                                      },
                                    ),
                                    Text('Student'),
                                    /*ElevatedButton(
                    onPressed: () {
                      if (user != null) {
                        // Handle the selected option
                        if (user == "instructor") {
                          // Instructor selected
                          //print('Instructor selected');
                        } else if (user == "student") {
                          // Student selected
                          //print('Student selected');
                        }
                      }
                    },
                    child: Text('Submit'),
                  ),*/
                                  ],
                                ),

                                const SizedBox(height: 40),

                                // Already have an account?
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Already have an account?"),
                                    SizedBox(
                                      height: 40,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.grey,
                                            shape: ContinuousRectangleBorder(),
                                          ),
                                          onPressed: () {
                                            //signUp();
                                            //Navigate to the registration page
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoginPage()),
                                            );
                                          },
                                          child: Text(
                                            'LOGIN',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Color(0xff458784)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                // Register button
                                ElevatedButton(
                                  // ignore: sort_child_properties_last
                                  child: _isRegistering
                                      ? CircularProgressIndicator()
                                      : Text('Register',
                                          style: TextStyle(
                                              color: Color(0xff0f4a64),
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 98.5, vertical: 15),
                                    backgroundColor: Color(0xffa7d4d1),
                                    foregroundColor: Color(0xff458784),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                  onPressed: _isRegistering ? null : _signUp,
                                ),

                                // Skip for now?
                                SizedBox(
                                  height: 50,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                        foregroundColor: Colors.grey,
                                        shape: ContinuousRectangleBorder()),
                                    onPressed: () {
                                      //Navigate to home page
                                      /* Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                ); */
                                    },
                                    child: Text(
                                      'Skip for now?',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 15),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ])))));
  }
}

class VerifyEmailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify Email'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'A verification email has been sent to your email address.',
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => LoginPage()));
              },
              child: Text('Go to Login'),
            ),
          ],
        ),
      ),
    );
  }
}
