import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title:'cet301finalproject_bound',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("Project"),) ,
        body: Container(alignment: Alignment.center,color: Colors.blueGrey,
          child: Text("Working on the project, I will probably complete the project late for that I am sorry, I would really appreciate your understanding.",
            style: TextStyle(color: Colors.white), textAlign: TextAlign.justify,),
        ),
      ),
    );
  }
}