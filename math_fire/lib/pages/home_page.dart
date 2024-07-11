import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:math_fire/pages/chatterScreen.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:math_fire/crud.dart';
import 'package:math_fire/ocr/ocr.dart';
import 'package:math_fire/pages/solution_page.dart';
import 'package:math_fire/services/voice.dart';

// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_ml_vision/firebase_ml_vision.dart';
  File pickedImage;
  bool isImageLoaded = false;
  String ocr="Şuan boş";
  String answer = "Şuan boş";
  String question = "Şuan boş";
    final chatMsgTextController = TextEditingController();

  
final _firestore = Firestore.instance;
String username = 'User';
String email = 'user@example.com';
String messageText;
FirebaseUser loggedInUser;
  final _auth = FirebaseAuth.instance;
int count = 0;
String islem;
var list = [1, 2, 3];
String resim = "assets/logo.png";

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final answerkey = new GlobalKey<FormState>();
  // Future pickImage() async{
  //   var tempStore = await ImagePicker.pickImage(source: ImageSource.gallery);

  //   setState(() {
  //     pickedImage = tempStore;
  //   });
  // }
  // Future readText() async{
  //   FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(pickedImage);
  //   TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
  //   VisionText readText = await recognizeText.processImage(ourImage);

  //   for (TextBlock block in readText.blocks){
  //     for (TextLine line in block.lines) {
  //       for (TextElement word in line.elements) {
  //         print(word.text);
  //       }
  //     }
  //   }
  // }
  
// widgets
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.deepPurple),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size(25, 10),
          child: Container(
            child: LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              backgroundColor: Colors.blue[100],
            ),
            decoration: BoxDecoration(
                // color: Colors.blue,

                // borderRadius: BorderRadius.circular(20)
                ),
            constraints: BoxConstraints.expand(height: 1),
          ),
        ),
        backgroundColor: Colors.white10,
        // leading: Padding(
        //   padding: const EdgeInsets.all(12.0),
        //   child: CircleAvatar(backgroundImage: NetworkImage('https://cdn.clipart.email/93ce84c4f719bd9a234fb92ab331bec4_frisco-specialty-clinic-vail-health_480-480.png'),),
        // ),
        title: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Math Key',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      color: Colors.deepPurple),
                ),
                Text('By Furkan BERK',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 8,  
                        color: Colors.deepPurple))
              ],
            ),
          ],
        ),
        actions: <Widget>[
          GestureDetector(
            child: Icon(Icons.more_vert),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[ 
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurple[900],
              ),
              accountName: Text(username),
              accountEmail: Text(email),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://cdn.clipart.email/93ce84c4f719bd9a234fb92ab331bec4_frisco-specialty-clinic-vail-health_480-480.png"),
              ),
              onDetailsPressed: () {},
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Logout"),
              subtitle: Text("Sign out of this account"),
              onTap: () async {
                await _auth.signOut();
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          _showScreen(),
          Padding(
            child: SpeedDial(
              backgroundColor: Colors.deepPurpleAccent,
              animatedIcon: AnimatedIcons.pause_play,
              overlayOpacity: 0.0,
              children: [
                // SpeedDialChild(
                //   child: Icon(Icons.add_circle_outline),
                //   onTap: () => addQuestion(),
                //   backgroundColor: Colors.deepPurpleAccent,
                // ),
                // SpeedDialChild(
                //   child: Icon(Icons.done),
                //   onTap: () {
                //     navigateToSubPage(context);
                //     acik="";
                //   },
                //   backgroundColor: Colors.deepPurpleAccent,
                // ),
                SpeedDialChild(
                  child: Icon(Icons.camera_alt),
                  onTap: (){
                    pickCamera();
                    readText();
                  },//pickImage,
                  backgroundColor: Colors.deepPurpleAccent,
                ),
                SpeedDialChild(
                  child: Icon(Icons.photo_library),
                  onTap: (){
                    pickImage();
                    readText();
                  },//pickImage,
                  backgroundColor: Colors.deepPurpleAccent,
                ),
                // SpeedDialChild(
                //   child: Icon(Icons.keyboard_voice),
                //   onTap: (){navigateToVoicePage(context);},//readText,
                //   backgroundColor: Colors.deepPurpleAccent,
                // ),
              ],
            ),
            padding: EdgeInsets.only(bottom: 25.0, right: 25.0),
          ),
        ],
      ),
    );
  }

  void navigateToSubPage(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SolutionPage()));
  }
  void navigateToVoicePage(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyApp()));
  }
  void navigateToOcrPage(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => OcrApp()));
  }
  Future pickImage() async {
    var tempStore = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      pickedImage = tempStore;
      isImageLoaded = true;
    });
  }
    Future pickCamera() async {
    var tempStore = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      pickedImage = tempStore;
      isImageLoaded = true;
    });
  }
    Future readText() async {
    FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(pickedImage);
    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
    VisionText readText = await recognizeText.processImage(ourImage);
    ocr = readText.text;
    question = ocr;
    return readText.text;
  }
}

Widget _showScreen() {
    return new Container(
        child: new Form(
      child: new ListView(
        shrinkWrap: true,
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  clipBehavior: Clip.hardEdge,
                  child: QuestionInputSf(),
                ),
                padding: EdgeInsets.only(top: 15.0, left: 5.0, right: 5.0),
              ),
              Padding(padding: EdgeInsets.only(top: 10.0)),
              Padding(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  clipBehavior: Clip.hardEdge,
                  child: AnswerInputSf(),
                ),
                padding: EdgeInsets.only(top: 15.0, left: 5.0, right: 5.0),
              ),
            Padding(
            padding: const EdgeInsets.all(20.0),
            child: RaisedButton(onPressed: (){
              addQuestion();
            },
            color: Colors.deepPurpleAccent,
            child: Text("Let's Solve"),
            ),
          )
          ],
        ),
      ],
    ),
  ));
}

class QuestionInputSf extends StatefulWidget {
  @override
  _QuestionInputSfState createState() => _QuestionInputSfState();
}

class _QuestionInputSfState extends State<QuestionInputSf> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.deepPurpleAccent,
        child: new TextField(
          onChanged: (String nametoChange) {
            setState(() {
              question = nametoChange;
            });
          },
          maxLines: 8,
          keyboardType: TextInputType.text,
          autofocus: false,
          style: TextStyle(color: Colors.white),
          decoration: new InputDecoration(
            hintText: 'Enter the Question',
            border: new OutlineInputBorder(
              borderSide: new BorderSide(
                color: Colors.blue,
              ),
            ),
            fillColor: Colors.white,
            hintStyle: TextStyle(color: Colors.white),
            prefixIcon: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          ),
        ));
  }
}

class AnswerInputSf extends StatefulWidget {
  @override
  _AnswerInputSfState createState() => _AnswerInputSfState();
}

class _AnswerInputSfState extends State<AnswerInputSf> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.deepPurpleAccent,
        child: new TextField(
          onChanged: (String nametoChange) {
            setState(() {
              answer = nametoChange;
            });
          },
          maxLines: 1,
          keyboardType: TextInputType.number,
          autofocus: false,
          style: TextStyle(color: Colors.white),
          decoration: new InputDecoration(
            hintText: 'Enter the Answer',
            border: new OutlineInputBorder(
              borderSide: new BorderSide(
                color: Colors.blue,
              ),
            ),
            fillColor: Colors.white,
            hintStyle: TextStyle(color: Colors.white),
            prefixIcon: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          ),
        ));
  }
  
}
