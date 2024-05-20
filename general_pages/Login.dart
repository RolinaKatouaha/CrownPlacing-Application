import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crown_placing/general_pages/ForgetPassPage.dart';
import 'package:crown_placing/general_pages/Register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HomePage.dart';
import 'preference.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoggingIn = false;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoggingIn = true;
      });

      try {
        final String email = _emailController.text.trim();
        final String password = _passwordController.text.trim();

        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        if (!userCredential.user!.emailVerified) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Error'),
              content: Text('Please verify your email before logging in.'),
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
            _isLoggingIn = false;
          });
          return;
        } else {
          DocumentSnapshot snapshot = await FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .get();

          String userType = snapshot.get('user_type');
          prefs.setString("id", FirebaseAuth.instance.currentUser!.uid);
          prefs.setString("type", userType);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => HomePage()),
          );
        }
      } catch (e) {
        print(e);
        setState(() {
          _isLoggingIn = false;
        });
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Login failed. Please check your credentials.'),
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
                  height: 150,
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
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              //Sign In
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Sign In",
                    style: TextStyle(
                      fontSize: 40,
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
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "ُ  Email",
                            prefixIcon: Icon(Icons.email, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 243, 241, 241),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "  Password",
                                prefixIcon:
                                    Icon(Icons.lock, color: Colors.grey),
                              ),
                            ))),
                    SizedBox(height: 16.0),
                    const SizedBox(height: 10),
                    // Forget Password?

                    SizedBox(
                      height: 40,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.grey,
                            shape: ContinuousRectangleBorder(),
                          ),
                          onPressed: () {
                            //Navigate to forget pass page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgetPassPage()),
                            );
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 50),
                    // Don't have an account Register
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?"),
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
                                //Navigate to the registration page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterPage()),
                                );
                              },
                              child: Text(
                                'Register',
                                style: TextStyle(
                                    fontSize: 15, color: Color(0xff458784)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Login button
                    ElevatedButton(
                      onPressed: _isLoggingIn ? null : _login,
                      child: _isLoggingIn
                          ? CircularProgressIndicator()
                          : Text('  LOGIN  ',
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
                    ),
                  ],
                ),
              ),
            ]),
          ),
        )));
  }
}
