import 'package:cet301finalproject_bound/widgets/header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cet301finalproject_bound/main.dart';

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  List<dynamic> users=[];
  void initState(){

    super.initState();
    getUserData();

  }
  getUserData() async{

      userRef.get().then((QuerySnapshot snapshot) => {
        snapshot.docs.forEach((DocumentSnapshot doc) {
          print(doc.data());
        })
      });
  }
  @override
  Widget build(context) {
    return Scaffold(
      appBar: header(context, titleText: "Bound", fontFamilyText: "MB",fontSize: 45),
      body: RaisedButton(
        onPressed: (){getUserData();}, child: Text("Press to see that application can fetch data from database, just a simple demonstration for now."),
      ),
    );
  }
}
