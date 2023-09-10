import  "package:flutter/material.dart";
import "package:news_app/constants.dart";

class Interest extends StatefulWidget{

  @override
  _InterestState createState() => _InterestState();
}

class _InterestState extends State<Interest>{
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
                        Selectionbutton(ico: "icons/sports", topic: 'time'),
                        Selectionbutton(ico: "icons/sports", topic: 'time'),
                      ],
                    ),
                    Row(
                      children: [
                        Selectionbutton(ico:"icons/sports", topic: 'time'),
                        Selectionbutton(ico: "icons/sports", topic: 'time'),
                      ],
                    ),
                    Row(
                      children: [
                        Selectionbutton(ico:"icons/sports", topic: 'time'),
                        Selectionbutton(ico: "icons/sports", topic: 'time'),
                      ],
                    ),
                    Row(
                      children: [
                        Selectionbutton(ico: "icons/sports", topic: 'time'),
                        Selectionbutton(ico: "icons/sports", topic: 'time'),
                      ],
                    ),

                  ],
                )
              ),
        ),
          ]
        ),
        );
      
  }
}