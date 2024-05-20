import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/instructor_pages/StudentHistory.dart';
import '/general_pages/HomeScreen.dart';
import '/general_pages/Profile.dart';
import '/general_pages/Results.dart';
import '/instructor_pages/History.dart';

class InsertGrades extends StatefulWidget {
  InsertGrades({Key? key, this.name, this.uid}) : super(key: key);
  String? name, uid;

  @override
  _InsertGradesState createState() => _InsertGradesState();
}

class _InsertGradesState extends State<InsertGrades> {
  String studentName = "";
  String grade = "";
  String feedback = "";
  int selectedPage = 0;

  final List<Widget> _pageOptions = [
    const HomeScreen(),
    const Results(),
    History(),
    const Profile(),
  ];

  void onGradeChange(String selectedGrade) {
    setState(() {
      grade = selectedGrade;
    });
  }

  void onFeedbackChange(String text) {
    setState(() {
      feedback = text;
    });
  }

  Future<void> updateStudentGrade(getuid) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('StudentResult')
        .where('StudentID', isEqualTo: getuid)
        .get();

    if (snapshot.docs.isNotEmpty) {
      List<DocumentReference> docRefs = snapshot.docs
          .map((doc) => FirebaseFirestore.instance
              .collection('StudentResult')
              .doc(doc.id))
          .toList();

      for (DocumentReference docRef in docRefs) {
        await docRef.update({
          'InstrGrade': grade,
          'Feedback': feedback,
        });
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StudentHistory(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StudentHistory(),
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
          title: Column(
            children: [
              Text(
                'Insert Grades',
                style: TextStyle(
                  color: const Color(0xff135679),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              )
            ],
          ),
          backgroundColor: const Color(0xffdbf0f5),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              const Icon(Icons.person, size: 50),
              const SizedBox(height: 5),
              Center(
                child: Text(
                  "${widget.name}",
                  style: TextStyle(
                    color: const Color(0xff135679),
                    fontSize: 30,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Grade',
                      hintStyle: TextStyle(
                        color: const Color(0x8A000000),
                        fontSize: 16,
                      ),
                    ),
                    onChanged: onGradeChange,
                  ),
                  const SizedBox(height: 15),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Feedback',
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                          onChanged: onFeedbackChange,
                          maxLines: 5,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: 140,
                    height: 45,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFFB2DFDB)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      onPressed: () {
                        // // Submit the grade
                        // studentName = widget.name ?? '';
                        updateStudentGrade(widget.uid);
                        print("-------------${widget.uid}--------------");
                      },
                      child: const Text(
                        'Submit',
                        style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 120,
                    height: 45,
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFF000000)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      onPressed: () {
                        // Navigate to register page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const StudentHistory(),
                          ),
                        );
                      },
                      child: const Text(
                        'Back',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              color: Colors.grey,
            ),
            activeIcon: Icon(
              Icons.home,
              color: Color(0xff74b1b1),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.camera_alt_outlined,
              color: Colors.grey,
            ),
            activeIcon: Icon(
              Icons.camera_alt,
              color: const Color(0xff74b1b1),
            ),
            label: 'Results',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bookmark_border_outlined,
              color: Colors.grey,
            ),
            activeIcon: Icon(
              Icons.bookmark,
              color: const Color(0xff74b1b1),
            ),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
              color: Colors.grey,
            ),
            activeIcon: Icon(
              Icons.person,
              color: const Color(0xff74b1b1),
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: selectedPage,
        onTap: (index) {
          setState(() {
            selectedPage = index;
          });
        },
      ),
    );
  }
}
