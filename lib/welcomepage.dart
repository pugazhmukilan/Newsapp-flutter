import "package:flutter/material.dart";

import "constants.dart";
class Welcomepage extends StatefulWidget{

  @override
  _WelcomepageState createState()=> _WelcomepageState();
}


class _WelcomepageState extends State<Welcomepage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundcolor,
      
      body:Stack(
        
        children: [

          Positioned(
            top:375,
            left:25,
            child: Container(
              height:400,
              width: 400,
              
              decoration: ShapeDecoration(
                color: Color(0xFFD9D9D9),
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                bottomLeft: Radius.circular(0),
                ),
                ),
                ),
                            
            
                  ),
          ),
        ],
    
      ),
    );
  }
}
