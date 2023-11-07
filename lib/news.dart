import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/interest.dart';
import 'package:news_app/welcomepage.dart';

import "constants.dart";
import "errorpage.dart";
import "news_detail_page.dart";
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
          Expanded(child: NewsList(category: selectedCategory,article: articles,),),
          
          
        ],
      ),
    );
  }
}

class NewsList extends StatefulWidget {
  final String category;
  final List article;

  NewsList({required this.category, required this.article});

  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.article.length,
      itemBuilder: (context, index) {
        if (widget.article.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: kBackgroundcolor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0), // Adjust the radius as needed
              ),),
              onPressed: (){
                print("priting the enetire content of the news");
                print(widget.article[index]['content'] ?? "");
                Navigator.push(context, MaterialPageRoute(builder: (context) => Detail(image: widget.article[index]["image"],
                title: widget.article[index]['title'],
                content:  widget.article[index]['content'] ?? "",
                sourcename: widget.article[index]['source']['name'],
                sourceurl:widget.article[index]['url']),),);
              },
              child: Container(
                height: 550,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(widget.article[index]["image"], scale: 1.6),
                    SizedBox(height: 20),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(widget.article[index]['title'],
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18),
                              ),
                              Text(widget.article[index]['description'], style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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

  void _handleButtonPress(String buttonName) {
  selectedButton = buttonName;
  getnews(context, buttonName).then((_) {
    setState(() {
      
      print("selected button: $buttonName");
      widget.onCategorySelected(buttonName);
      // widget.onButtonPressed(); // No need to call this, as setState triggers a rebuild
    });
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
  articles=[];
  late String url;
  String apiKey = "96d23f736a4bf75fe969ae5ee5c85761";
  print("fetching news from the "+cat);
  String category = cat;
  if (category=="Entertainment"){
    print("********************************************************");
    print("                  ENTERTAINMENT                         "); 
    print("********************************************************");
    url=
      url=
      "https://gnews.io/api/v4/top-headlines?q=entertainment&lang=en&country=in&max=10&apikey=$apiKey";

  }
  else if (category =="cricket"){
    print("********************************************************");
    print("                         CRICKET                         ");
    print("********************************************************");
    url=
      "https://gnews.io/api/v4/top-headlines?category=sports&q=cricket&lang=en&country=in&max=10&apikey=$apiKey";

  }
  else if (category =="Sports"){
    print("********************************************************");
    print("                         SPORTS                         ");
    print("********************************************************");
    url=
      "https://gnews.io/api/v4/top-headlines?category=sports&q=swimming&lang=en&country=in&max=10&apikey=$apiKey";

  }
  else if (category =="World"){
    print("********************************************************");
    print("                         WORLD                         ");
    print("********************************************************");
    url=
      "https://gnews.io/api/v4/top-headlines?category=world&q=politics&lang=en&country=in&max=10&apikey=$apiKey";

  }
  else if (category =="Nation"){
    print("********************************************************");
    print("                         NATION                         ");
    print("********************************************************");
    url=
      "https://gnews.io/api/v4/top-headlines?category=nation&q=politics&lang=en&country=in&max=10&apikey=$apiKey";

  }
  else if(category =="general"){
    print("********************************************************");
    print("                         GENERAL                         ");
    print("********************************************************");
    url=
    url=
      "https://gnews.io/api/v4/top-headlines?category=general&q=world&lang=en&country=in&max=10&apikey=$apiKey";

  }
  else if(category =="Technology"){
    print("********************************************************");
    print("                         TECHNOLOGY                     ");
    print("********************************************************");
    url=
    url=
      "https://gnews.io/api/v4/top-headlines?category=technology&lang=en&country=in&max=10&apikey=$apiKey";

  }
  else if(category =="Scienceandhealth"){
    print("********************************************************");
    print("                 SCIENCE AND HEALTH                     ");
    print("********************************************************");
    url=
    url=
      "https://gnews.io/api/v4/top-headlines?category=scienceandhealth&lang=en&country=in&max=10&apikey=$apiKey";

  }
  else{
    print("********************************************************");
    print("                         ELSE                          ");
    print("********************************************************");
    url=
    url=
      "https://gnews.io/api/v4/top-headlines?category=sports&q=badminton&lang=en&country=in&max=10&apikey=$apiKey";

  }
  

  var response = await http.get(Uri.parse(url));


  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    
    articles = data["articles"] ?? [];
    print(articles);
    
    
  //await Future.delayed(Duration(seconds: 2));


    // The loop will handle displaying all the articles returned by the request.
  for (var article in articles) {
      print("Title: ${article['title']}");
      print("content: ${article['content']??""}");
      print("source: ${article['source']}");
      print("url: ${article['url']}");

      
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
    else if (response.statusCode == 400){
      Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Errorpage(errormessage: "${response.statusCode}",submessage:"Bad Request --your request is invalid"),
            ),
    );
    }
    else if (response.statusCode == 429){
      Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Errorpage(errormessage: "${response.statusCode}",submessage:"Too Many request Per Second"),
            ),
    );
    }
    else if (response.statusCode == 500){
      Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Errorpage(errormessage: "${response.statusCode}",submessage:"Internal Server error"),
            ),
    );
    }
    else if (response.statusCode == 503){
      Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Errorpage(errormessage: "${response.statusCode}",submessage:"Service unavaiable temporarily offile"),
            ),
    );
    }
    
    else{
      Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Errorpage(errormessage: "${response.statusCode}",submessage:"Something went wrong"),
            ),
    );
      
    }
     
  }
}

/*getnews1() async {
  //general, world, nation, business, technology, entertainment, sports, science and health.
  
  
  String apiKey = "96d23f736a4bf75fe969ae5ee5c85761";
  
  String category = 'sports';
  print("from get news+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ $category");
   print("from get news+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ $category");
    print("from get news+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ $category");
  String url =

  //small change is doen check it out
      "https://gnews.io/api/v4/top-headlines?category=$category&lang=en&country=in&apikey=$apiKey";


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
}*/































/*Future<void> getNews(BuildContext context, String cat) async {
  articles = [];
  String apiKey = "96d23f736a4bf75fe969ae5ee5c85761";
  print("fetching news from the " + cat);
  String category = cat;
  String url =
      "https://gnews.io/api/v4/top-headlines?category=$category&lang=en&country=in&max=10&apikey=$apiKey";

  var response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    var articlesData = data["articles"] ?? [];

    // Fetch the full content for each article
    await fetchFullContents(articlesData);

   
      articles = articlesData;
    
  } else {
    print("Error: ${response.statusCode}");
    // Handle errors and navigate to error page...
  }
}

Future<void> fetchFullContents(List<dynamic> articlesData) async {
  for (int index = 0; index < articlesData.length; index++) {
    var articleUrl = articlesData[index]["url"];
    var response = await http.get(Uri.parse(articleUrl));

    if (response.statusCode == 200) {
      var fullArticle = json.decode(response.body);
      
        articlesData[index]['content'] = fullArticle['content'];
      
    } else {
      // Handle errors fetching full content...
      print("Error fetching full article: ${response.statusCode}");
    }
  }
}



*/