import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isFirst = false;
  bool isSecond = false;
  bool isThird = false;
  bool isFourth = false;
  bool isFifth = false;
  bool isSixth = false;
  bool isSeventh = false;
  bool isEighth = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: AppBar(
          actions: [Container(child: Image.asset('images/LogoT.jpg'))],
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
          backgroundColor: const Color(0xffdbf0f5),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              ////////////////////////////////////////////////
              ////////////Crown preparation Definition ///////
              ////////////////////////////////////////////////
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Crown Preparation: ',
                    style: TextStyle(
                        color: Color(0xff135679),
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '   Crown preparation is the dental procedure in which a tooth is carefully shaped and prepared to receive a dental crown, also known as a dental cap. The process involves removing a portion of the tooth\'s natural structure to create space for the crown to be placed securely. Crown preparation aims to ensure proper fit, function, and aesthetics of the crown, which is a prosthetic restoration that covers and protects the prepared tooth. Crown preparation may involve shaping the tooth, taking impressions for the fabrication of the crown, and ultimately cementing or bonding the crown onto the prepared tooth for long-term durability and improved dental health.',
                    style: TextStyle(
                      color: Color(0xff677b84),
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
              Center(
                child: Container(
                    alignment: Alignment.center,
                    width: 300,
                    height: 300,
                    child: Image.asset('images/crown2.jpg')),
              ),
              ////////////////////////////////////////////////
              //////////////// Feature points ////////////////
              ////////////////////////////////////////////////
              SizedBox(
                height: 30,
              ),
              Text(
                'Features Of A Perfect Tooth Preparation: ',
                style: TextStyle(
                    color: Color(0xff135679),
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // on tap 1.Finish Line position
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isFirst = !isFirst;
                          isSecond = false;
                          isThird = false;
                          isFourth = false;
                          isFifth = false;
                          isSixth = false;
                          isSeventh = false;
                          isEighth = false;
                        });
                      },
                      child: Text(
                        '- Finish Line position',
                        style: TextStyle(
                          color: isFirst ? Colors.blue : Color(0xff677b84),
                          fontSize: 18,
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xff677b84),
                          decorationThickness: 1.5,
                        ),
                      ),
                    ),
                    /////////////////////////////////////////
                    SizedBox(
                      height: 3,
                    ),

                    // on tap 2.Finish Line countinuity
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isFirst = false;
                          isSecond = !isSecond;
                          isThird = false;
                          isFourth = false;
                          isFifth = false;
                          isSixth = false;
                          isSeventh = false;
                          isEighth = false;
                        });
                      },
                      child: Text(
                        '- Finish Line countinuity',
                        style: TextStyle(
                          color: isSecond ? Colors.blue : Color(0xff677b84),
                          fontSize: 18,
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xff677b84),
                          decorationThickness: 1.5,
                        ),
                      ),
                    ),
                    /////////////////////////////////////////
                    SizedBox(
                      height: 3,
                    ),

                    // on tap 3.Finish Line irregularity
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isFirst = false;
                          isSecond = false;
                          isThird = !isThird;
                          isFourth = false;
                          isFifth = false;
                          isSixth = false;
                          isSeventh = false;
                          isEighth = false;
                        });
                      },
                      child: Text(
                        '- Finish Line irregularity',
                        style: TextStyle(
                          color: isThird ? Colors.blue : Color(0xff677b84),
                          fontSize: 18,
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xff677b84),
                          decorationThickness: 1.5,
                        ),
                      ),
                    ),
                    /////////////////////////////////////////
                    SizedBox(
                      height: 3,
                    ),

                    // on tap 4.Taper
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isFirst = false;
                          isSecond = false;
                          isThird = false;
                          isFourth = !isFourth;
                          isFifth = false;
                          isSixth = false;
                          isSeventh = false;
                          isEighth = false;
                        });
                      },
                      child: Text(
                        '- Taper',
                        style: TextStyle(
                          color: isFourth ? Colors.blue : Color(0xff677b84),
                          fontSize: 18,
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xff677b84),
                          decorationThickness: 1.5,
                        ),
                      ),
                    ),
                    /////////////////////////////////////////
                    SizedBox(
                      height: 3,
                    ),

                    // on tap 5.Line angle roundness
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isFirst = false;
                          isSecond = false;
                          isThird = false;
                          isFourth = false;
                          isFifth = !isFifth;
                          isSixth = false;
                          isSeventh = false;
                          isEighth = false;
                        });
                      },
                      child: Text(
                        '- Line angle roundness',
                        style: TextStyle(
                          color: isFifth ? Colors.blue : Color(0xff677b84),
                          fontSize: 18,
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xff677b84),
                          decorationThickness: 1.5,
                        ),
                      ),
                    ),
                    /////////////////////////////////////////
                    SizedBox(
                      height: 3,
                    ),

                    // on tap 6.Axial wall undercut
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isFirst = false;
                          isSecond = false;
                          isThird = false;
                          isFourth = false;
                          isFifth = false;
                          isSixth = !isSixth;
                          isSeventh = false;
                          isEighth = false;
                        });
                      },
                      child: Text(
                        '- Axial wall undercut',
                        style: TextStyle(
                          color: isSixth ? Colors.blue : Color(0xff677b84),
                          fontSize: 18,
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xff677b84),
                          decorationThickness: 1.5,
                        ),
                      ),
                    ),
                    /////////////////////////////////////////
                    SizedBox(
                      height: 3,
                    ),

                    // on tap 7.Amount of occlusal reduction
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isFirst = false;
                          isSecond = false;
                          isThird = false;
                          isFourth = false;
                          isFifth = false;
                          isSixth = false;
                          isSeventh = !isSeventh;
                          isEighth = false;
                        });
                      },
                      child: Text(
                        '- Amount of occlusal reduction',
                        style: TextStyle(
                          color: isSeventh ? Colors.blue : Color(0xff677b84),
                          fontSize: 18,
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xff677b84),
                          decorationThickness: 1.5,
                        ),
                      ),
                    ),
                    /////////////////////////////////////////
                    SizedBox(
                      height: 3,
                    ),

                    // on tap 8.Over reduction
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isFirst = false;
                          isSecond = false;
                          isThird = false;
                          isFourth = false;
                          isFifth = false;
                          isSixth = false;
                          isSeventh = false;
                          isEighth = !isEighth;
                        });
                      },
                      child: Text(
                        '- Over reduction ',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: isEighth ? Colors.blue : Color(0xff677b84),
                          fontSize: 18,
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xff677b84),
                          decorationThickness: 1.5,
                        ),
                      ),
                    ),
                    /////////////////////////////////////////
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),

              ////////////////////////////////////////////////////////
              //////////////// Feature points details ////////////////
              ////////////////////////////////////////////////////////

              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /////// 1.Finish Line position: ///////
                    Visibility(
                      visible: isFirst,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Finish Line position:',
                              style: TextStyle(
                                color: Color(0xff135679),
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              '   The dental finish line position refers to the location where the edge of a dental restoration meets the natural tooth structure. It plays a vital role in determining the fit, retention, and aesthetics of the restoration. The position can vary, such as supragingival (above the gumline), equigingival (at the gumline), or subgingival (below the gumline), depending on various factors including aesthetics, tooth condition, and the type of restoration. Achieving the correct finish line position is crucial for the success and longevity of dental treatments.',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color(0xff677b84), fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),

                    /////// 2.Finish line continuity: ///////
                    Visibility(
                      visible: isSecond,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Finish line continuity:',
                              style: TextStyle(
                                color: Color(0xff135679),
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              '   refers to the uninterrupted, and precisely defined line created along the prepared surface of a tooth. It is essential for ensuring the longevity and effectiveness of dental restorations. A defined finish line helps prevent issues like decay and gum inflammation, promoting overall oral health.',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color(0xff677b84), fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),

                    /////// 3.Finish line irregularity:  ///////
                    Visibility(
                      visible: isThird,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Finish line irregularity:',
                              style: TextStyle(
                                color: Color(0xff135679),
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              '   refers to inconsistencies or unevenness along the edge where a dental restoration meets the natural tooth structure. These irregularities can lead to issues such as poor fit, compromised aesthetics, and difficulty in achieving a proper seal. Ensuring smooth and uniform finish line contours is crucial for the success and longevity of dental treatments.',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color(0xff677b84), fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),

                    /////// 4.Taper:   ///////
                    Visibility(
                      visible: isFourth,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Taper:',
                              style: TextStyle(
                                color: Color(0xff135679),
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              '   refers to how much the walls of a prepared tooth slope inward or outward. It\'s like the angle of a pyramid\'s sides. This slope affects how well a dental crown or bridge fits onto the tooth. Too much or too little taper can cause problems with fitting the restoration properly. ',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color(0xff677b84), fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),

                    /////// 5.line angle roundness:    ///////
                    Visibility(
                      visible: isFifth,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Line angle roundness:',
                              style: TextStyle(
                                color: Color(0xff135679),
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              '   refers to the curvature or smoothness of the angles created during the shaping of a tooth. It\'s crucial for ensuring the longevity and integrity of the restoration. Rounded line angles reduce stress concentration and improve the distribution of forces, which helps prevent fractures and enhances the durability of the restoration.',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color(0xff677b84), fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),

                    /////// 6.axial wall undercut:    ///////
                    Visibility(
                      visible: isSixth,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Axial wall undercut: ',
                              style: TextStyle(
                                color: Color(0xff135679),
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              '   refers to a concavity or inward curve along the prepared wall of a tooth. These undercuts can complicate the accurate fitting and retention of dental restorations by impeding their proper seating onto the tooth.',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color(0xff677b84), fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),

                    /////// 7.Amount of occlusal reduction:    ///////
                    Visibility(
                      visible: isSeventh,
                      child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Amount of occlusal reduction:',
                                style: TextStyle(
                                  color: Color(0xff135679),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                '   refers to the degree to which the chewing surface of a tooth is trimmed down or removed during. This reduction is necessary to ensure that the restoration fits properly within the patient\'s bite and doesn\'t interfere with their ability to chew comfortably. Dentists carefully measure and plan the amount of occlusal reduction needed, balancing the preservation of healthy tooth structure with the requirements of the restoration.',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Color(0xff677b84), fontSize: 18),
                              ),
                            ],
                          )),
                    ),

                    /////// 8.Over reduction:   ///////
                    Visibility(
                      visible: isEighth,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Over reduction:',
                              style: TextStyle(
                                color: Color(0xff135679),
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              '   refers to the excessive removal of tooth structure during preparation. Over-reduction may result in weakened teeth, increased risk of fracture, and challenges in achieving proper retention and stability of the restoration.',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color(0xff677b84), fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
