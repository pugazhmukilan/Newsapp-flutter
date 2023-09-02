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
      body:Column(

        children: [
          Text("Interest ",style: TextStyle(fontSize: 40),),

          SingleChildScrollView(
            child:Column(
              children: [

                Row(
                  children: [
                    Selectionbutton(),
                    Selectionbutton(),
                    Selectionbutton(),
                    
                  ],
                ),
                Row(
                  children: [
                    Selectionbutton(),
                    Selectionbutton(),
                    Selectionbutton(),
                    
                  ],
                ),
                Row(
                  children: [
                    Selectionbutton(),
                    Selectionbutton(),
                    Selectionbutton(),
                    
                  ],
                ),
                Row(
                  children: [
                    Selectionbutton(),
                    Selectionbutton(),
                    Selectionbutton(),
                    
                  ],
                ),
                Row(
                  children: [
                    Selectionbutton(),
                    Selectionbutton(),
                    Selectionbutton(),
                    
                  ],
                ),
                Row(
                  children: [
                    Selectionbutton(),
                    Selectionbutton(),
                    Selectionbutton(),
                    
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}