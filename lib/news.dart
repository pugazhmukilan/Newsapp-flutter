import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import "package:flutter_swiper_view/flutter_swiper_view.dart";
import "package:news_app/constants.dart";
import "package:news_app/interest.dart";
import "package:news_app/welcomepage.dart";

FirebaseAuth auth =FirebaseAuth.instance;
class Newspage extends StatefulWidget{

  @override
  _NewspageState createState()=> _NewspageState();
}

class _NewspageState extends State<Newspage>{
  
  List<String> subtitles=[];
  Future<List<String>> fetchInterests(String userEmail) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  try {
    DocumentSnapshot documentSnapshot = await firestore
        .collection('users') // Your collection name
        .doc(userEmail) // Document ID is the user's email in this case
        .get();

    if (documentSnapshot.exists) {
      List<dynamic> interest = documentSnapshot.get('interest');

      return interest is List && interest.every((item) => item is String)
          ? List<String>.from(interest)
          : [];
    } else {
      print('Document does not exist');
      return [];
    }
  } catch (error) {
    print('Failed to retrieve interests: $error');
    return [];
  }
}

 void call()async{
  subtitles=  await fetchInterests("mukilan@gmail.com");
  
  print(subtitles);
  
 }
  

  @override
  void initState(){
    super.initState();
   
    call();
    
    

  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar (title : Text("News",style: TextStyle(color:Colors.white,fontFamily: "Pacifico",fontSize: 35),),
      
      backgroundColor: Colors.black,
      //add a button in the appbar
      actions:[IconButton(onPressed: (){
          Navigator.pop(context);
          
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Interest()));
      }, icon: Icon(Icons.abc_outlined,color: Colors.white,)),
      
      IconButton(onPressed: (){
        //logout from firebase
        FirebaseAuth auth = FirebaseAuth.instance;
        auth.signOut().then((value) async {
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Welcomepage()));

        });
        
      }, icon: Icon(Icons.logout_outlined,color: Colors.white,))]
      ),
      

      backgroundColor: kBackgroundcolor,
      body:Column(
        children: [
          ButtonRow(listname: subtitles,defaultbutton: "Currency", height: 50, whenselected: const Color.fromARGB(255, 83, 83, 83), whennotselected: const Color.fromARGB(255, 43, 43, 43), textselected: Colors.white, textnotselected: Color.fromARGB(255, 136, 136, 136)),
          Expanded(
            child: Swiper(itemCount: subtitles.length,
              itemBuilder: (context, index) {
                
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: Container(
                      
                     
                      child: CustomScrollView(
                        physics: BouncingScrollPhysics(),
                        slivers: [
                          SliverList.builder(
                            itemCount: 10,
                            
                            itemBuilder:(context, index) {
                            
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Container(
                                height:400,
                                decoration: BoxDecoration(
                                   color: const Color.fromARGB(255, 3, 30, 53),
                                   borderRadius: BorderRadius.circular(30)
                                ),
                               
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    
                                   
                                    children: [
                                    ClipRRect(
                                    borderRadius: BorderRadius.circular(20), // Adjust the border radius as needed
                                    child: Image.network(
                                      "https://static.toiimg.com/thumb/imgsize-46090,msid-103973373,width-400,resizemode-4/103973373.jpg",
                                      height: 190,
                                    ),
                                  ),
                                    Text("this is the sample news for checking\n heheheheh",style: TextStyle(color: Colors.white,)),
                                  ],),
                                ),
                              ),
                            );
                          },)
                        ],
                      ),
                    ),
                  );
              },
            
            ),
          ),
        
        ],
      )
    );
  }
}


class ButtonRow extends StatefulWidget {

  late List<String> listname;
  late  double height;
  late Color whenselected;
  late Color whennotselected;
  late Color textselected;
  late Color textnotselected;
  late String defaultbutton;
  
  ButtonRow({required this.listname,
  required this.height,
  required this.whenselected,
  required this.whennotselected,
  required this.textselected,
  required this.textnotselected,
  required this.defaultbutton,
  });
  @override
  _ButtonRowState createState() => _ButtonRowState();
}

class _ButtonRowState extends State<ButtonRow> {
  
  late String selectedButton=widget.defaultbutton; // Default selected button

 

  void _handleButtonPress(String buttonName) {
    setState(() {
      selectedButton = buttonName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: widget.listname.map((buttonName) {
          bool isSelected = buttonName == selectedButton;
          return GestureDetector(
            onTap: () => _handleButtonPress(buttonName),
            child: Container(
              height:widget.height,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.transparent,
                  width: 1, // Border width
                ),
                color: isSelected ? widget.whenselected : widget.whennotselected,
              ),
              child: Center(
                child: Text(
                  buttonName,
                  style: TextStyle(
                    fontSize:15,
                    fontFamily: "Raleway",
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.none,
                    color: isSelected? widget.textselected:widget.textnotselected,
                    
              
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

