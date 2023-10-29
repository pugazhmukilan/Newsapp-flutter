import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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


//firebase retrivel

Future<List<String>> fetchInterests(String userEmail) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  try {
    DocumentSnapshot documentSnapshot = await firestore
        .collection('users') // Your collection name
        .doc(userEmail) // Document ID is the user's email in this case
        .get();

    if (documentSnapshot.exists) {
      List<dynamic> interest = documentSnapshot.get('interest');

      return interest is List && interest.every((item) => item is String)
          ? List<String>.from(interest)
          : [];
    } else {
      print('Document does not exist');
      return [];
    }
  } catch (error) {
    print('Failed to retrieve interests: $error');
    return [];
  }
}




void getnews() async {
  var apiKey = '5cd12da93d244661b22aee82f1d25961';
  var baseUrl = 'https://newsapi.org/v2/';
  var endpoint = 'top-headlines';
  var queryParameters = {
    'q': 'bitcoin',
    'sources': 'bbc-news,the-verge',
    'category': 'business',
    'language': 'en',
    'country': 'us',
    'apiKey': apiKey,
  };

  var uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: queryParameters);
  var response = await http.get(uri);

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    print('Top Headlines: $data');
  } else {
    print('Error: ${response.statusCode}');
  }
}

//api key:5cd12da93d244661b22aee82f1d25961