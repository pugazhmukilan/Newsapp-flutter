import 'package:flutter/material.dart';

import "welcomepage.dart";
void main() {
  runApp( MainApp());
}

class MainApp extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        
        body: Welcomepage(),
      ),
    );
  }
}
