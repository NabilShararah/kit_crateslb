//Nabil Shararah 12232685

import 'package:flutter/material.dart';
import 'home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.amber,
          title: Text('Kit Crates ',
            style: TextStyle(
                fontSize:28,
                color :Colors.black),),

        ),


        body: Center(
          child: Home(),

        ),
      ),
    );
  }
}







