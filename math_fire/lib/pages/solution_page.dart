import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:math_fire/crud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bubble/bubble.dart';
import 'package:math_fire/pages/home_page.dart';
import 'package:math_fire/crud.dart';
String acik = "";

final _firestore = Firestore.instance;
String username = 'User';
String email = 'user@example.com';
String messageText;
FirebaseUser loggedInUser;
String islem;
var list = [];
var truelist = [];
String son = "";
String sayi1,sayi2;
var s = 0;
var t= 0;
class SolutionPage extends StatefulWidget {
  @override
  _SolutionPageState createState() => _SolutionPageState();
}

class _SolutionPageState extends State<SolutionPage> {
  final chatMsgTextController = TextEditingController();

  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: new StreamBuilder(
        stream: Firestore.instance
            .collection('SolutionLib')
            .document(docid.toString())
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {    
            return new Text("Loading");
          }
          String girdi = "";
          son = "";
          var userDocument = snapshot.data;
          girdi = userDocument['solution'].toString();
          truelist = girdi.split("?");
          list = girdi.split(" ");
          for (var q in list) {
            if(q != "(" && q != ")" && q != "=" && q != "+" && q != "*" && q != "-" && q != "/" && q != "?")
            {
              sayi1 = q;
              s=1;
            }
            if(q != "(" && q != ")" && q != "=" && q != "+" && q != "*" && q != "-" && q != "/" && q != "?" && s ==1)
            {
              sayi2 = q;
            }
            if(q == "+"){
              islem = "Add";
            }
            if(q == "-")
            {
              islem = "Subtract";
            }
            if(q == "/")
            {
              islem = "Divide";
            }
            if(q == "*")
            {
              islem = "Multiply";
            }            
            print(q);
          }
    for (var i = 0; i < 1 ; i++) {
    acik = islem + " " + n1.toString() + " and " + n2.toString() + " to get " + answer;  

        son += (truelist[i] + acik + "\n");
}
son += truelist[1];
          return ListView(
            children: <Widget>[
              Text(son,textAlign: TextAlign.left,style: TextStyle(fontSize: 20),)
            ],
          );
          // return Column(
          //   children: <Widget>[
          //     Bubble(
          //       margin: BubbleEdges.only(top: 10),
          //       nip: BubbleNip.leftTop,
          //       color: Colors.deepPurpleAccent,
          //       child: Text(girdi, textAlign: TextAlign.left, style: TextStyle(fontSize: 40.0),),
          //       stick: true,
          //     ),
          //   ],
          // );
        },
      ),
    );
  }
}