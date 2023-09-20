import "package:flutter/material.dart";
import "package:news_app/constants.dart";



class Newspage extends StatefulWidget{

  @override
  _NewspageState createState()=> _NewspageState();
}

class _NewspageState extends State<Newspage>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar (title : Text("News"),
      backgroundColor: Colors.black,),

      backgroundColor: kBackgroundcolor,
    );
  }
}