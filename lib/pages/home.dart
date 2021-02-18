import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn googleSignIn =GoogleSignIn();

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isAuth=false;

  @override
  void initState(){
    super.initState();
    googleSignIn.onCurrentUserChanged.listen((account){
      if(account!=null)
        {
          print("User $account signed in");
              setState(() {
                isAuth=true;
              });
        }
      else{
        setState(() {
          isAuth=false;
        });
      }
    });
  }

  login(){
    googleSignIn.signIn();
  }

  buildAuthScreen(){
    return Container(alignment: Alignment.center,
      child: Text("Authenticated",style: TextStyle(fontFamily: "NR",fontSize: 50),),
    );
  }
  buildUnauthScreen(){
    return Container(alignment: Alignment.center,decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Theme.of(context).primaryColor,
          Theme.of(context).accentColor,
        ],
      ),
    ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Bo nd",style: TextStyle(fontFamily: "NR",fontSize: 80,color: Colors.white),),
          Text("  U  ",style: TextStyle(fontFamily: "NR",fontSize: 80,color: Colors.white),),
          GestureDetector(onTap: (){
            login();
          },child: Container(
            width:200,
            height: 50,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/google_signin_button.png"),fit: BoxFit.fill)
            )
          ),),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isAuth ? buildAuthScreen() : buildUnauthScreen();
  }
}
