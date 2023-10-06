import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import "package:news_app/constants.dart";
import "package:news_app/interest.dart";
import "package:news_app/welcomepage.dart";

FirebaseAuth auth = FirebaseAuth.instance;

class Newsloader extends StatefulWidget {
  @override
  _Newsloadstate createState() => _Newsloadstate();
}

class _Newsloadstate extends State<Newsloader> {
  List<String> subtitles = [];

  void call() async {
    subtitles = await fetchInterests("mukilan@gmail.com");

    print(subtitles);
  }

  @override
  void initState() {
    super.initState();

    call();
  }

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
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Container(
                    height: 400,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 23, 23, 23),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 33, 33, 33),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              width: double.infinity,
                              height: 250,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 33, 33, 33),
                                borderRadius: BorderRadius.circular(35),
                              ),
                              width: double.infinity,
                              height: 100,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              childCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}
