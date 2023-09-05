import  "package:flutter/material.dart";
import "package:news_app/constants.dart";

class Interest extends StatefulWidget{

  @override
  _InterestState createState() => _InterestState();
}

class _InterestState extends State<Interest>{
  @override
  Widget build(BuildContext context){
  
      return Scaffold(
        backgroundColor: kBackgroundcolor,
        
        body:Column(
          children:[
            Expanded(
              flex:1,
              child: SizedBox(
                height: 80,
              ),
            ),
            
            Expanded(
              flex: 4,
              child: CustomScrollView(
                        physics: const BouncingScrollPhysics(),
                        slivers: [
                
                // ignore: prefer_const_constructors
              
                         //search bar
                    
                        
                        SliverList(
                delegate: SliverChildBuilderDelegate(
                
                    
                  
                  (BuildContext context,int index){
                    return Expanded(
                      child: Row(children: [
                        Selectionbutton(),
                        Selectionbutton(),
                        Selectionbutton(),]),
                    );
                  },
                  childCount: 20,
                  
                ),
                     
                         ),
                         ]
                       ),
             ),]
        ),
      );
  }
}