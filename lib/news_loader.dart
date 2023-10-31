import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import "package:news_app/constants.dart";
import "package:news_app/interest.dart";
import "package:news_app/news.dart";
import "package:news_app/welcomepage.dart";

FirebaseAuth auth = FirebaseAuth.instance;

class Newsloader extends StatefulWidget {
  @override
  _Newsloadstate createState() => _Newsloadstate();
}

class _Newsloadstate extends State<Newsloader> {
  List<String> subtitles = [];

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundcolor,
      appBar: AppBar(
        title: Text(
          "News",
          style: TextStyle(
            color: Color.fromARGB(255, 112, 112, 112),
            fontFamily: "Pacifico",
            fontSize: 35,
          ),
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => Interest()));
            },
            icon: Icon(Icons.abc_outlined, color: Color.fromARGB(255, 112, 112, 112)),
          ),
          IconButton(
            onPressed: () {
              FirebaseAuth auth = FirebaseAuth.instance;
              auth.signOut().then((value) async {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => Welcomepage()));
              });
            },
            icon: Icon(Icons.logout_outlined, color: Color.fromARGB(255, 112, 112, 112)),
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: fetchInterests("mukilan@gmail.com"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
      // Handle the case where the future is still in progress
      return CircularProgressIndicator();
    } else if (snapshot.hasError) {
      // Handle the case where the future completes with an error
      return Text('Error: ${snapshot.error}');
    } else {
      subtitles = List<String>.from(snapshot.data as Iterable<dynamic>);
      Future.delayed(Duration.zero, () {

                Navigator.pop(context);
                
                Navigator.push(context, MaterialPageRoute(builder: (context) => Newspage(subtitles1: subtitles,)));
              });
      // Handle the case where the future completes successfully
      
      return Text("");
    }
          },
        ),
    ),

    );
  }
}
