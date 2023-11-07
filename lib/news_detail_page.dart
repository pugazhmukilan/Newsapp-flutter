import 'package:flutter/material.dart';
import "package:news_app/constants.dart";
import 'package:url_launcher/url_launcher.dart';

import "interest.dart";
import "welcomepage.dart";

class Detail extends StatefulWidget {
  

  @override
  State<Detail> createState() => _DetailState();
  late String image;
  late String title;
  late String content;
  late String sourcename;
  late String sourceurl;
  Detail({required this.image, required this.title,required this.content, required this.sourcename,required this.sourceurl});
}

class _DetailState extends State<Detail> {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundcolor,
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

    body: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 12, 5, 0),
            child:Image.network("${widget.image}",scale: 1.6,),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 20, 8, 0),
            child: Text(widget.title,style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 21),),
          ),
        Divider(
          thickness: 1.5,
          height:20,
          indent: 20,
          endIndent: 20,
          color:const Color.fromARGB(255, 69, 69, 69)
        ),
        Padding(
            padding: const EdgeInsets.fromLTRB(8, 20, 8, 0),
            child: Text(widget.content,style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15),),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 20, 8, 0),
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("SOURCE WEBSITE: ",style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),),
                Text("${widget.sourcename}",style: TextStyle(color: Color.fromARGB(255, 50, 252, 0),fontWeight: FontWeight.w700, fontSize: 15),),
              ],
            )
          ),
        Padding(
            padding: const EdgeInsets.fromLTRB(8, 20, 8, 0),
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: kBackgroundcolor),
                  onPressed: () async {
                    print("launching the url");
                    await launch("${widget.sourceurl}");
                  },
                  child: Text('Learn more!'),
                ),
              ],
            )
          ),

          


        ],
      ),
    
    ),
    
        ) ;
  }
}


