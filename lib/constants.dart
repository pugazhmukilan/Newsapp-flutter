import 'package:flutter/material.dart';

const Color kBackgroundcolor =  Color.fromARGB(255, 10, 10, 10);
const Color kContainercolor =  Color.fromARGB(255, 40, 40, 40);

const Color kWelcompagebutton = Color.fromARGB(255, 235, 235, 235);


//SELECTION BUTTON COLORS
MaterialStateProperty <Color> unpressedcolor =  MaterialStatePropertyAll(const Color.fromARGB(255, 36, 36, 36));
MaterialStateProperty <Color> pressedcolor =  MaterialStatePropertyAll(Color.fromARGB(255, 249, 225, 255));



//CUSTOM BUTTON FOR THE LOGIN PAGES
class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color colours;
  final String text;

  CustomButton({required this.onPressed,required this.colours,required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 250,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: colours,shadowColor: Colors.black),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}

//ENTRY TEXTFIELD FOR THE LOGIN AND SIGN  IN PAGES

class entrytext extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool secure;

  entrytext({required this.controller,required this.hint,required this.secure});
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
      child: TextField(
        
        style:TextStyle(color: Colors.white,fontFamily: "Commmissioner"),
        obscureText:secure ,
        controller: controller,
      decoration: InputDecoration(


        //BORDER
        border: OutlineInputBorder(
          
          borderRadius: BorderRadius.circular(50.0),
          borderSide: BorderSide(color: Color.fromARGB(255, 138, 138, 138)), // Rounded border
        ),


        //ENABLED BORDER
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0),
          borderSide: BorderSide(color: Color.fromARGB(255, 101, 101, 101)), // Rounded border
        ),


        //FOCUSED BORDER
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0),
          borderSide: BorderSide(color: Color.fromARGB(255, 204, 204, 204)), // Rounded border
        ),


        //HINT TEXT
        hintText: hint,
        hintStyle: TextStyle(
          color: const Color.fromARGB(255, 79, 79, 79),
          fontFamily: "Commissioner",
        ),
      ),
    ),
    );
  }
}


List <String> interest =[];

  class Selectionbutton extends StatefulWidget {
  @override
  late String ico;
  late String topic;
  Selectionbutton({required this.ico,required this.topic});
  _SelectionbuttonState createState() => _SelectionbuttonState();
}

class _SelectionbuttonState extends State<Selectionbutton> {
  bool ispressed = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          height: 110,
          width: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            shape: BoxShape.rectangle,
          ),
          child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
                ),
              ),
              backgroundColor: (ispressed) ? pressedcolor : unpressedcolor
              ),
            
            onPressed: () {
              setState(() {
                ispressed = !ispressed;
                ispressed ? interest.add(widget.topic):interest.remove(widget.topic);
              
                print(interest);
                // Toggle the button state
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(widget.ico),
                Text(widget.topic),
              ],
            ),
          ),
        ),
      ),
    );
    
  }
}


