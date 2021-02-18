import 'package:cet301finalproject_bound/pages/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title:'cet301finalproject_bound',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff1c2833),
        accentColor: Color(0xff424242),
      ),
      home: Scaffold(
        body: Home(),
      ),
    );
  }
}