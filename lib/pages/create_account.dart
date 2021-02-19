import 'package:cet301finalproject_bound/widgets/header.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {

  final formKey=GlobalKey<FormState>();

  String username;

  submit(){
    formKey.currentState.save();
    Navigator.pop(context,username);
  }

  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
      appBar: header(context,titleText: "Create Account",fontFamilyText: "MB",fontSize: 30),
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
                      key: formKey,
                      child: TextFormField(
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
    );
  }
}
