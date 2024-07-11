import 'package:cloud_firestore/cloud_firestore.dart';  
import 'package:math_fire/pages/home_page.dart';
String docid;
String number1 = "0";
String number2 = "1";
String number3 = "2";
String number4 = "3";
String number5 = "4";
String number6 = "5";
String number7 = "6";
String number8 = "7";
String number9 = "8";
String number10 = "9";
  String n1,n2,n3,n4,n5,n6,n7;
Future<void> addQuestion() async{
  var s=1;
  var list = [];
  final db = Firestore.instance;
  int sayimiktar = 1;
  var sayi1 = "";
  var durum = 0;
  print("yes");
    for (var i = 0; i < question.length; i++) {
    if((question[i] == number1) || (question[i] == number2) || (question[i] == number3) || (question[i] == number4) || (question[i] == number5) || (question[i] == number6) || (question[i] == number7) || (question[i]== number8) || (question[i] == number9))
    {
    sayi1 = (sayi1 + question[i].toString()) ;
    durum = 2;
    }
    else if((durum == 2) && (question[i] != number1) && (question[i] != number2) && (question[i] != number3) && (question[i] != number4) && (question[i] != number5) && (question[i] != number6) && (question[i] != number7) && (question[i] != number8) && (question[i] != number9))
    {
      durum = 1;
      if(sayimiktar == 1)
      n1 = sayi1;
      else if (sayimiktar == 2)
      n2 = sayi1;
      else if (sayimiktar == 3)
      n3 = sayi1;
      else if (sayimiktar == 4)
      n4 = sayi1;
      else if (sayimiktar == 5)
      n5 = sayi1;
      else if (sayimiktar == 6)
      n6 = sayi1;
      else if (sayimiktar == 7)
      n7 = sayi1;
      sayimiktar+=1;
      sayi1 = "";
    }
  }
  if (durum == 2){
    if(sayimiktar == 1)
      n1 = sayi1;
      else if (sayimiktar == 2)
      n2 = sayi1;
      else if (sayimiktar == 3)
      n3 = sayi1;
      else if (sayimiktar == 4)
      n4 = sayi1;
      else if (sayimiktar == 5)
      n5 = sayi1;
      else if (sayimiktar == 6)
      n6 = sayi1;
      else if (sayimiktar == 7)
      n7 = sayi1;
        

        
  }
print(sayi1);
  await db.collection("Questions").add({
  'question':question.toString(),
  'number1': n1.toString(),
  'number2': n2.toString(),
  'number3': n3.toString(),
  'number4': n4.toString(),
  'number5': n5.toString(),
  'number6': n6.toString(),
  'number7': n7.toString(),
  'numbers': sayimiktar.toString(),
  'answer': answer.toString(),
  'stats': durum,
  }).then((documentReference){
    print(documentReference.documentID);
    docid=documentReference.documentID;
  }).catchError((e){
    print(e);
  });
  editQuestion();
}
Future < void> readQuestion() async{
final String _collection = 'Answer';
final Firestore _fireStore = Firestore.instance;

getData() async {
  return await _fireStore.collection(_collection).getDocuments();
}

getData().then((val){
    if(val.documents.length > 0){
        islem = val.documents[0].data["islem"];
    }
    else{
        print("Not Found");
    }
});
}

Future < void > editQuestion() async {  
    final db = Firestore.instance;
    await db.collection("Questions").document(docid).updateData({
        'id': docid.toString(),
    }).then((documentReference) {  
    }).catchError((e) {  
        print(e);  
    });   
}

Future<void> deleteQuestion() async {
    final db = Firestore.instance;
   db.collection("SolutionLib").document(docid).delete();  
}  
