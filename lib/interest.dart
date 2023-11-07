import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import  "package:flutter/material.dart";
import "package:news_app/constants.dart";

import 'news_loader.dart';
final _auth = FirebaseAuth.instance;
List <String> interest =[];//empty string

class Interest extends StatefulWidget{

  @override
  _InterestState createState() => _InterestState();
}
 
class _InterestState extends State<Interest>{
 @override
 void initState(){
  super.initState();
  interest = []; // Initialize the interest list to be empty
  print("Printing inside the initState");
 
 }

  @override
  Widget build(BuildContext context){
  
      return Scaffold(
        backgroundColor: kBackgroundcolor,
        
        body:Column(
          children:[
            Expanded(
              flex:1,
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[ Center(child: Text("Interest",style:TextStyle(fontFamily: "Pacifico",
                  fontSize: 60,
                  color: Colors.white),)),

                  Text("choose your intrested topics for the news feed",style:TextStyle(fontFamily:"Commissioner",
                  fontSize: 12,
                  color: Color.fromARGB(255, 137, 137, 137) )),
          ] ),
                height: 80,
              ),
            ),
            
            Expanded(
              flex: 4,
              child:SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child:Column(
                  children: [
                    Row(
                      children: [
                        Selectionbutton( topic: 'Sports'),
                        Selectionbutton( topic: 'general'),
                      ],
                    ),
                    Row(
                      children: [
                        Selectionbutton( topic: 'Nation'),
                        Selectionbutton( topic: 'World'),
                      ],
                    ),
                    Row(
                      children: [
                        Selectionbutton( topic: 'Technology'),
                        Selectionbutton(topic: 'Entertainment')
                        
                      ],
                    ),
                    Row(
                      children: [
                        Selectionbutton(topic: 'Science and health'),
                      ],
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ElevatedButton(onPressed: ()async{
                         // Replace with the actual interest value
                        await insertOrUpdateArrayData();
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Newsloader()));
                      
                    
                      }, child: Text("Add interest")),
                    )

                  ],
                )
              ),
        ),
          ]
        ),
        );
      
  }
}




late String? email;
  late User? user;

  void getCurrentUser() async{
    user = _auth.currentUser;
    email = user?.email;
    
    if (user != null) {
      //print("================================this is the user ${user?.email}");
    } else {
      print('The user is not logged in');
    
    }
  }

Future<void> insertOrUpdateArrayData() async {
  getCurrentUser();
  print("inserting in the ${email}");

  try {
    final userRef = FirebaseFirestore.instance.collection('users').doc(email);

    // Check if the user document exists
    final userDoc = await userRef.get();

    if (userDoc.exists) {
      // If the user document exists, update the array field
      await userRef.set({
        'interest': interest,
      }, SetOptions(merge: false));
      
    } else {
      // If the user document doesn't exist, create it with the array field
      await userRef.set({
        'interest': interest,
      });
    }
  } catch (e) {
    print('Error inserting/updating array data: $e');
  }
}




//BUTTON FOR EACH INTEREST




  class Selectionbutton extends StatefulWidget {
  @override
  
  late String topic;
  Selectionbutton({required this.topic});
  _SelectionbuttonState createState() => _SelectionbuttonState();
}

class _SelectionbuttonState extends State<Selectionbutton> {
  bool ispressed = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          height: 110,
          width: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            shape: BoxShape.rectangle,
          ),
          child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
                ),
              ),
              backgroundColor: (ispressed) ? pressedcolor : unpressedcolor
              ),
            
            onPressed: () {
              setState(() {
                ispressed = !ispressed;
                ispressed ? interest.add(widget.topic):interest.remove(widget.topic);
              
                print(interest);
                // Toggle the button state
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              
                Text(widget.topic),
              ],
            ),
          ),
        ),
      ),
    );
    
  }
}


