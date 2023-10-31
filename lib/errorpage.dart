import "package:flutter/material.dart";



class Errorpage extends StatelessWidget {
  late String errormessage;
  late String submessage;
  
  Errorpage({super.key,required this.errormessage,required this.submessage});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Error!",style:TextStyle(color: Colors.grey,decoration: TextDecoration.none)),
        Text(errormessage,style:TextStyle(color: Colors.white,decoration: TextDecoration.none)),
        SizedBox(height:10),
        Text(submessage,style:TextStyle(color: Color.fromARGB(255, 255, 0, 0),decoration: TextDecoration.none,fontSize: 15)),

      ],
    );
}
}
