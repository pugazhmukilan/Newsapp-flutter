import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import "package:flutter/material.dart";
import "package:flutter_swiper_view/flutter_swiper_view.dart";
import "package:news_app/constants.dart";
import "package:news_app/interest.dart";



class Newspage extends StatefulWidget{

  @override
  _NewspageState createState()=> _NewspageState();
}

class _NewspageState extends State<Newspage>{
  List<dynamic> subtitles=[];
  
    final DatabaseReference databaseReference = FirebaseDatabase.instance.reference();

    Future<void> fetchInterests() async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  try {
    DocumentSnapshot documentSnapshot = await firestore
        .collection('users') // Your collection name
        .doc('mukilan@gmail.com') // Your document ID
        .get();

    if (documentSnapshot.exists) {
      subtitles = documentSnapshot.get('interest');
      print("fetching the interest");
      print('Interests: $subtitles');
    } else {
      print('Document does not exist');
    }
  } catch (error) {
    print('Failed to retrieve interests: $error');
  }
}

  

  @override
  void initState(){
    super.initState();
    fetchInterests();

  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar (title : Text("News"),
      backgroundColor: Colors.black,
      //add a button in the appbar
      actions:[IconButton(onPressed: (){
          
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Interest()));
      }, icon: Icon(Icons.abc_outlined))]
      ),
      

      backgroundColor: kBackgroundcolor,
      body:Column(
        children: [
          ButtonRow(listname: names, height: 50, whenselected: const Color.fromARGB(255, 83, 83, 83), whennotselected: const Color.fromARGB(255, 43, 43, 43), textselected: Colors.white, textnotselected: Color.fromARGB(255, 136, 136, 136)),
          Expanded(
            child: Swiper(itemCount: names.length,
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
                              child: Expanded(
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

  late List listname;
  late  double height;
  late Color whenselected;
  late Color whennotselected;
  late Color textselected;
  late Color textnotselected;
  
  ButtonRow({required this.listname,
  required this.height,
  required this.whenselected,
  required this.whennotselected,
  required this.textselected,
  required this.textnotselected,
  });
  @override
  _ButtonRowState createState() => _ButtonRowState();
}

class _ButtonRowState extends State<ButtonRow> {
  String selectedButton = "hello"; // Default selected button

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

List<String> names= ["puagzh","mukilan"];