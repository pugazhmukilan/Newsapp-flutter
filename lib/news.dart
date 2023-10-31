import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/interest.dart';
import 'package:news_app/welcomepage.dart';

import "constants.dart";
import "errorpage.dart";
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
  selectedCategory = subtitles.first;
  print(selectedCategory);

  Future.delayed(Duration.zero, () async {
    await getnews(context,selectedCategory);
  });
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
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Interest()));
            },
            icon: Icon(Icons.abc_outlined, color: Color.fromARGB(255, 255, 255, 255)),
          ),
          IconButton(
            onPressed: () {
             Navigator.pop(context);
             Navigator.push(context, MaterialPageRoute(builder: (context)=>Welcomepage()));
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
            child: NewsList(category: selectedCategory,article:articles),
          ),
          
        ],
      ),
    );
  }
}

class NewsList extends StatelessWidget {
  final String category;
  final List article;

  NewsList({required this.category, required this.article});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: article.length,
      itemBuilder: (context, index) {
        if (article.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: Container(
              height: 500,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(article[index]["image"], scale: 1.6),
                  SizedBox(height: 20),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(article[index]['title'],
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18),
                            ),
                            Text(article[index]['description'], style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container(
            // Placeholder widget or message when articles are empty
            child: Center(
              child: Text("No articles available"),
            ),
          );
        }
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
  late String selectedButton = widget.defaultbutton;
  //create initistate()
  

  void _handleButtonPress(String buttonName) {
    setState(() {
      selectedButton = buttonName;
      print(buttonName);
      getnews(context,buttonName);
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
List articles = [];
getnews(BuildContext context, String cat) async {
  String apiKey = "96d23f736a4bf75fe969ae5ee5c85761";
  print("cat+++++++++++++++++++++++++++++++++++++++++++"+cat);
  String category = cat;
  String url =
      "https://gnews.io/api/v4/top-headlines?category=$category&lang=en&country=in&max=10&apikey=$apiKey";


  var response = await http.get(Uri.parse(url));


  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    
    articles = data["articles"] ?? [];
    



    // The loop will handle displaying all the articles returned by the request.
  for (var article in articles) {
      print("Title: ${article['title']}");
      
      // Add more properties as needed
      print("");
    }
  } else {
    print("Error: ${response.statusCode}");
    if (response.statusCode == 403){
      Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Errorpage(errormessage: "${response.statusCode}",submessage:"Your API call limit breached!"),
            ),
    );
    }
    else{
      Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Errorpage(errormessage: "${response.statusCode}",submessage:"Error found try again after some time"),
            ),
    );
      
    }
     
  }
}

getnews1() async {
  String apiKey = "96d23f736a4bf75fe969ae5ee5c85761";
  
  String category = "politics";
  String url =
      "https://gnews.io/api/v4/top-headlines?category=$category&lang=en&country=in&max=10&apikey=$apiKey";


  var response = await http.get(Uri.parse(url));


  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    
    articles = data["articles"] ?? [];
    



    // The loop will handle displaying all the articles returned by the request.
  for (var article in articles) {
      print("Title: ${article['title']}");
      
      // Add more properties as needed
      print("");
    }
  } else {
    print("Error: ${response.statusCode}");
  }
}


