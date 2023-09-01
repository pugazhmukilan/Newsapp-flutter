import "package:flutter/material.dart";

import "constants.dart";
class User_info extends StatefulWidget{
  late String username;
  late String password;
  late String email;
  User_info(this.username, this.password ,  this.email);
  @override
  _User_infoState createState()=> _User_infoState();

}


class _User_infoState extends State<User_info>{

  @override
  Widget build (BuildContext context){
    return Scaffold(
      backgroundColor: kBackgroundcolor,
      body:Container(
        decoration: BoxDecoration(
          color: kContainercolor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Column(
          children: [
            infolabel(text:widget.username),
             infolabel(text:widget.email),
              infolabel(text:widget.password),
              TextButton(onPressed: (){
                
              },
              child: Text("My intrest",style:TextStyle(color:Colors.blue,fontFamily: "Commissioner")))
          ],
        ),
      ),
    );
  }
}

class infolabel extends StatelessWidget {
  

  final String text;
  infolabel({required this.text});
  

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(text,style:TextStyle(fontFamily: "Commissioner",color:Colors.white)),
    );
  }
}

