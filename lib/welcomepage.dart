import "package:flutter/material.dart";

import 'Signup.dart';
import "constants.dart";
import "login.dart";
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
                color: Color.fromARGB(255, 134, 134, 134),
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                bottomLeft: Radius.circular(0),
                ),
                ),
                ),
              child:Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomButton(onPressed: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>Login()));
                    }, colours: const Color.fromARGB(255, 235, 235, 235)
                    , text: "Login"),
                    SizedBox(
                      height: 40,
                    ),
                    CustomButton(onPressed: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>Signup()));
                    }, colours: const Color.fromARGB(255, 235, 235, 235)
                    , text: "Signup"),
                  ],
                ),
              ),
            
                  ),
          ),
          
        ],
    
      ),
    );
  }
}



class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color colours;
  final String text;

  CustomButton({required this.onPressed,required this.colours,required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 3),
      child: SizedBox(
        height: 60,
        width: 250,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: colours,shadowColor: Colors.black),
          onPressed: onPressed,
          child: Text(text),
        ),
      ),
    );
  }
}