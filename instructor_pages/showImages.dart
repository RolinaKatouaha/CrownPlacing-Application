import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShowMyImages extends StatefulWidget {
  ShowMyImages({Key? key, required this.uid});

  final String uid;

  @override
  _ShowMyImagesState createState() => _ShowMyImagesState();
}

class _ShowMyImagesState extends State<ShowMyImages> {
  List<String> imageUrls = [];

  @override
  void initState() {
    super.initState();
    fetchImageUrls();
  }

  Future<void> fetchImageUrls() async {
    CollectionReference imagesRef =
        FirebaseFirestore.instance.collection('images');

    QuerySnapshot querySnapshot = await imagesRef
        .where('studentID', isEqualTo: widget.uid)
        // .orderBy('timestamp', descending: true)
        .get();

    List<String> urls = [];
    for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
      String url = data['url'];
      urls.add(url);
    }

    setState(() {
      imageUrls = urls;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Images'),
      ),
      body: ListView.builder(
        itemCount: imageUrls.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 200,
            child: Image.network(
              width: 200,
              height: 1500,
              "https://firebasestorage.googleapis.com/v0/b/crownplacing-eebcb.appspot.com/o/images%2Fi0rqvO5VL6gonxkY7M56aLjjvs03%2Fimage3.jpg",
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
