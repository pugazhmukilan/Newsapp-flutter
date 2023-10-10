import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import "package:flutter_swiper_view/flutter_swiper_view.dart";
import "package:news_app/constants.dart";

import "interest.dart";
import "welcomepage.dart";

FirebaseAuth auth =FirebaseAuth.instance;
class Newspage extends StatefulWidget{
  late List<String>subtitles1;
  Newspage({required this.subtitles1});

  @override
  _NewspageState createState()=> _NewspageState();
}

class _NewspageState extends State<Newspage>{
  late List<String> subtitles;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subtitles =widget.subtitles1;
  }
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "News",
          style: TextStyle(
            color: Color.fromARGB(255, 112, 112, 112),
            fontFamily: "Pacifico",
            fontSize: 35,
          ),
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => Interest()));
            },
            icon: Icon(Icons.abc_outlined, color: Color.fromARGB(255, 112, 112, 112)),
          ),
          IconButton(
            onPressed: () {
              FirebaseAuth auth = FirebaseAuth.instance;
              auth.signOut().then((value) async {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => Welcomepage()));
              });
            },
            icon: Icon(Icons.logout_outlined, color: Color.fromARGB(255, 112, 112, 112)),
          ),
        ],
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

