import 'dart:async';
import 'dart:io';
import 'package:crown_placing/general_pages/DifferentViews.dart';
import 'package:crown_placing/general_pages/Login.dart';
import 'package:crown_placing/general_pages/HomePage.dart';
import 'package:crown_placing/general_pages/camView/CameraThirdView.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import '/general_pages/Results.dart';

class CameraSecondView extends StatefulWidget {
  final File? Image1;

  const CameraSecondView({
    Key? key,
    this.Image1,
  }) : super(key: key);

  @override
  State<CameraSecondView> createState() => _CameraSecondViewState();
}

class _CameraSecondViewState extends State<CameraSecondView> {
  File? _image2;
  String? _imageURL;
  bool check = true;

  Future<void> getImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage == null) return;
    //final imageTemporary = File(pickedImage.path);
    final imageName = 'image2.png';
    final imagePermanent = await saveFile(pickedImage.path, imageName);
    setState(() {
      _image2 = imagePermanent;
    });
  }

  Future<void> getImageGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;
    //final imageTemporary = File(pickedImage.path);
    final imageName = 'image2.png';
    final imagePermanent = await saveFile(pickedImage.path, imageName);
    setState(() {
      _image2 = imagePermanent;
    });
  }

  Future<File> saveFile(String imagePath, String filename) async {
    final directory = await getApplicationDocumentsDirectory();
    final image = File('${directory.path}/$filename');

    return File(imagePath).copy(image.path);
  }

  Future<void> uploadImagesToFirebase() async {
    final studentID = FirebaseAuth.instance.currentUser!.uid;
    setState(() {
      check = !check;
    });
    final imagePermanent = await saveFile(_image2!.path, 'image1.png');
    final extension = path.extension(imagePermanent.path);
    final firebaseStorageRef = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('images/$studentID/image$extension');
    await firebaseStorageRef.putFile(imagePermanent);

    final downloadURL = await firebaseStorageRef.getDownloadURL();

    FirebaseFirestore.instance.collection('images').add({
      'studentID': studentID,
      'url': downloadURL,
      'timestamp': DateTime.now(),
    });
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Upload Successful'),
        content: Text('The image has been uploaded successfully.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
          actions: [Container(child: Image.asset('images/LogoT2.jpg'))],
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
                'Assessment',
                style: TextStyle(
                    color: Color(0xff677b84),
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: 300,
                  height: 250,
                  margin: EdgeInsets.fromLTRB(30, 50, 30, 20),
                  child: _image2 != null
                      ? Image.file(
                          _image2!,
                          fit: BoxFit.fill,
                        )
                      : Icon(
                          Icons.camera_alt,
                          size: 180,
                          color: Color(0xFFECEFF1),
                        ),
                ),
                Container(
                  width: 300,
                  height: 250,
                  margin: EdgeInsets.fromLTRB(30, 50, 30, 20),
                  child: Icon(
                    Icons.camera_alt,
                    size: 180,
                    color: Color(0xFFECEFF1), // Customize the color of the icon
                  ),
                ),
                Container(
                  width: 300,
                  height: 250,
                  margin: EdgeInsets.fromLTRB(30, 50, 30, 20),
                  decoration: BoxDecoration(
                      //border: Border.all(color: Colors.blueAccent),
                      ),
                ),
                Positioned(
                  top: 50,
                  left: 30,
                  child: Container(
                    width: 50,
                    height: 52,
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(color: Colors.black, width: 5),
                        top: BorderSide(color: Colors.black, width: 5),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  right: 30,
                  child: Container(
                    width: 50,
                    height: 52,
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(color: Colors.black, width: 5),
                        top: BorderSide(color: Colors.black, width: 5),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 30,
                  child: Container(
                    width: 50,
                    height: 52,
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(color: Colors.black, width: 5),
                        bottom: BorderSide(color: Colors.black, width: 5),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 30,
                  child: Container(
                    width: 50,
                    height: 52,
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(color: Colors.black, width: 5),
                        bottom: BorderSide(color: Colors.black, width: 5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Results(),
                          ),
                        ); // Update the current view to 1
                      });
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.withOpacity(
                            0.2), // Set the background color of the circle
                      ),
                      child: Icon(
                        Icons.chevron_left_sharp,
                        size: 20,
                        color: Color(
                            0xFF212121), // Customize the color of the icon
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Text(
                      'Second View',
                      style: TextStyle(
                          color: Color(0xFF424242),
                          //fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        uploadImagesToFirebase();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CameraThirdView()),
                        ); // Update the current view to 1
                      });
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.withOpacity(0.2),
                      ),
                      child: Icon(
                        Icons.chevron_right_sharp,
                        size: 20,
                        color: Color(0xFF212121),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(2, 30, 2, 0),
                      child: Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 94, vertical: 15),
                            backgroundColor: const Color(0xffb2dedd),
                            foregroundColor: const Color(0xff458784),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          onPressed: () {
                            getImage();
                          },
                          child: const Text('Take Photo',
                              style: TextStyle(
                                  color: Color(0xff135679),
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(2, 10, 2, 0),
                      child: Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 63, vertical: 15),
                            backgroundColor: const Color(0xDD000000),
                            foregroundColor: const Color(0xDD000000),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          onPressed: () {
                            getImageGallery();
                          },
                          child: const Text('Add From Gallery',
                              style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _image2 != null
                        ? Image.file(_image2!)
                        : const Text("Please select an image"),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
