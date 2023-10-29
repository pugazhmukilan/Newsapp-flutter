import 'package:flutter/material.dart';

import "constants.dart";
class Newspage extends StatefulWidget {
  late List<String> subtitles1;
  Newspage({required this.subtitles1});

  @override
  _NewspageState createState() => _NewspageState();
}

class _NewspageState extends State<Newspage> {
  late List<String> subtitles;
  late String selectedCategory;

  @override
  void initState() {
    super.initState();
    subtitles = widget.subtitles1;
    selectedCategory = subtitles.first; // Set the default category
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "News",
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontFamily: "Pacifico",
            fontSize: 35,
          ),
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              // ... (your existing code for Interest page)
            },
            icon: Icon(Icons.abc_outlined, color: Color.fromARGB(255, 255, 255, 255)),
          ),
          IconButton(
            onPressed: () {
              // ... (your existing code for logout)
            },
            icon: Icon(Icons.logout_outlined, color: Color.fromARGB(255, 255, 255, 255)),
          ),
        ],
      ),
      backgroundColor: kBackgroundcolor,
      body: Column(
        children: [
          ButtonRow(
            listname: subtitles,
            height: 50,
            whenselected: const Color.fromARGB(255, 83, 83, 83),
            whennotselected: const Color.fromARGB(255, 43, 43, 43),
            textselected: Colors.white,
            textnotselected: Color.fromARGB(255, 136, 136, 136),
            defaultbutton: selectedCategory,
            onCategorySelected: (category) {
              setState(() {
                selectedCategory = category;
              });
            },
          ),
          Expanded(
            child: NewsList(category: selectedCategory),
          ),
          ElevatedButton(onPressed: (){
            getnews();
          }, child: Text("get the news")),
        ],
      ),
    );
  }
}

class NewsList extends StatelessWidget {
  final String category;

  NewsList({required this.category});

  // Implement your logic to fetch news based on the category and display here

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10, // Adjust the number of items based on your data
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
          child: Container(
           
            height:300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network("https://static.toiimg.com/thumb/imgsize-81054,msid-104771131,width-600,resizemode-4/104771131.jpg",scale: 1.6,),
                Expanded(
                  child: Container(
                    width:double.infinity,
                    
                    
                    child:Center(child: Text("$category, $index",style: TextStyle(color: Colors.white),),),
                
                
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ButtonRow extends StatefulWidget {
  late List<String> listname;
  late double height;
  late Color whenselected;
  late Color whennotselected;
  late Color textselected;
  late Color textnotselected;
  late String defaultbutton;
  final Function(String) onCategorySelected;

  ButtonRow({
    required this.listname,
    required this.height,
    required this.whenselected,
    required this.whennotselected,
    required this.textselected,
    required this.textnotselected,
    required this.defaultbutton,
    required this.onCategorySelected,
  });

  @override
  _ButtonRowState createState() => _ButtonRowState();
}

class _ButtonRowState extends State<ButtonRow> {
  late String selectedButton = widget.defaultbutton; // Default selected button

  void _handleButtonPress(String buttonName) {
    setState(() {
      selectedButton = buttonName;
      widget.onCategorySelected(buttonName);
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
              height: widget.height,
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
                    fontSize: 15,
                    fontFamily: "Raleway",
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.none,
                    color: isSelected ? widget.textselected : widget.textnotselected,
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
