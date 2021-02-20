import 'dart:async';
import 'package:cet301finalproject_bound/widgets/header.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final scaffoldKey=GlobalKey<ScaffoldState>();
  final formKey=GlobalKey<FormState>();

  String username;

  submit(){
    final form=formKey.currentState;
    if(form.validate()){
      form.save();
      SnackBar snackBar=SnackBar(content: Text("Welcome $username"));
      scaffoldKey.currentState.showSnackBar(snackBar);
      Timer(Duration(seconds: 2),(){
        Navigator.pop(context,username);
      }
      );
    }
  }

  @override
  Widget build(BuildContext parentContext) {
    return new WillPopScope(
         onWillPop: () async  => false,
         child: Scaffold(
           key: scaffoldKey,
           appBar: header(context,titleText: "Create Account",fontFamilyText: "MB",fontSize: 30,backButton: false),
           body: ListView(
             children: [
               Container(
                 child: Column(
                   children: [
                     Padding(padding: EdgeInsets.only(top: 25),
                       child: Center(
                         child: Text("Create a Username", style: TextStyle(fontFamily: "ML",fontSize: 20),),
                       ),
                     ),
                     Padding(padding: EdgeInsets.all(15),
                         child: Container(
                           child: Form(
                             autovalidateMode: AutovalidateMode.onUserInteraction,
                             key: formKey,
                             child: TextFormField(
                               validator: (val){
                                 if(val.trim().length<5||val.isEmpty||val.trim().length>15){
                                   return "Invalid Username";
                                 }else return null;
                               },
                               onSaved: (val)=>username=val,
                               decoration: InputDecoration(
                                 border: OutlineInputBorder(),
                                 labelText: "Username",
                                 labelStyle: TextStyle(fontSize: 10),
                                 hintText: "Must be at least 5 characters",
                               ),
                             ),
                           ),
                         )
                     ),
                     GestureDetector(
                       onTap: ()=>submit(),
                       child: Container(alignment: Alignment.center,height: 50,width: 150,decoration: BoxDecoration(
                         color: Colors.blueGrey,
                         borderRadius: BorderRadius.circular(5),
                       ),
                         child: Text(
                           "Submit",style: TextStyle(
                           color: Colors.white,
                           fontSize: 25,
                           fontWeight: FontWeight.bold,
                         ),
                         ),
                       ),
                     )
                   ],
                 ),
               )
             ],
           ),
         )
    );
  }
}
