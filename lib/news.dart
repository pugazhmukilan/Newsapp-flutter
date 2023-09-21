import "package:flutter/material.dart";
import "package:news_app/constants.dart";
import "package:news_app/interest.dart";



class Newspage extends StatefulWidget{

  @override
  _NewspageState createState()=> _NewspageState();
}

class _NewspageState extends State<Newspage>{

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
    );
  }
}