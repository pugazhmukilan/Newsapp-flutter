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
      body:Column(
        children: [
          ButtonRow(listname: subtitles, height: 50, whenselected: const Color.fromARGB(255, 83, 83, 83), whennotselected: const Color.fromARGB(255, 43, 43, 43), textselected: Colors.white, textnotselected: Color.fromARGB(255, 136, 136, 136)),
          Container(
            child: Text("hello"),
          ),
        
        ],
      )
    );
  }
}


class ButtonRow extends StatefulWidget {

  late List listname;
  late  double height;
  late Color whenselected;
  late Color whennotselected;
  late Color textselected;
  late Color textnotselected;
  
  ButtonRow({required this.listname,
  required this.height,
  required this.whenselected,
  required this.whennotselected,
  required this.textselected,
  required this.textnotselected,
  });
  @override
  _ButtonRowState createState() => _ButtonRowState();
}

class _ButtonRowState extends State<ButtonRow> {
  String selectedButton = "hello"; // Default selected button

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
List<String> subtitles=["hello","pugazh","mukilan","pugazh","mukilan","pugazh","mukilan","pugazh","mukilan","pugazh","mukilan","pugazh","mukilan"];