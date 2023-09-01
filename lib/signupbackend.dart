import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


final FirebaseFirestore firestore = FirebaseFirestore.instance;
late User? user;
late String? email;
final _auth= FirebaseAuth.instance;





void addusername(String name){
  firestore.collection("usernames").add({
    "name":name
                          
                                                  });
}

void checkuserduplicate(String newusername){
  List <String> checklist=[];
  CollectionReference messagesCollection = firestore.collection('usernames');
  Stream<QuerySnapshot> messagesStream =  messagesCollection.snapshots();

  messagesStream.listen((datasnapshot)=> {
    for (var data in datasnapshot.docs ){
      if ((data['usernames'] as String).toLowerCase() == newusername.toLowerCase()){
        print(data["usernames"]),
        checklist.add(data['usernames']),
        }}});

}

void addorupdateinterest()async{
  
  user = _auth.currentUser;
  email = user?.email;

  try {
      DocumentReference docRef = FirebaseFirestore.instance.collection("usernames").doc("$email");

      DocumentSnapshot docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        print('Document already exists.');
      } else {
        await docRef.set({
          'field1': email,
          'field2': "interest",
          // Add other fields as needed
        });
        print('Document added successfully.');
      }
    } catch (e) {
      print('Error: $e');
    }

}