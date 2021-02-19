import 'package:cet301finalproject_bound/pages/activity_feed.dart';
import 'package:cet301finalproject_bound/pages/profile.dart';
import 'package:cet301finalproject_bound/pages/search.dart';
import 'package:cet301finalproject_bound/pages/timeline.dart';
import 'package:cet301finalproject_bound/pages/upload.dart';
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
  PageController pageController;
  int pageIndex=0;
  @override
  void initState(){
    super.initState();
    pageController=PageController();
    googleSignIn.onCurrentUserChanged.listen((account){
      signInControl(account);
    },onError: (error){
      print("Error sign in: $error");
    });

    googleSignIn.signInSilently(suppressErrors: false).then((account){
      signInControl(account);
    }).catchError((error){
      print("Error sign in: $error");
    });
  }

  signInControl(GoogleSignInAccount account){
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
  }

  onPageChanged(int pageIndex)
  {
    setState(() {
      this.pageIndex=pageIndex;
    });
  }

  @override
  void dispose(){
    pageController.dispose();
    super.dispose();
  }

  onTap(int pageIndex)
  {
    pageController.animateToPage(pageIndex, duration: Duration(milliseconds: 250),curve: Curves.bounceInOut);
  }

  login(){
    googleSignIn.signIn();
  }

  logout(){
    var currentUser=googleSignIn.currentUser;
    print("User $currentUser signed out");
    googleSignIn.signOut();
  }
  Scaffold buildAuthScreen(){
    return Scaffold(
        body:PageView(
          children: <Widget>[
            Timeline(),
            Search(),
            Upload(),
            ActivityFeed(),
            Profile(),
          ], controller: pageController, onPageChanged: onPageChanged, physics: NeverScrollableScrollPhysics(),
        ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: pageIndex,
        onTap: onTap,
        activeColor: Theme.of(context).primaryColor,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home)),
          BottomNavigationBarItem(icon: Icon(Icons.search)),
          BottomNavigationBarItem(icon: Icon(Icons.add_box,size: 50,)),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_active)),
          BottomNavigationBarItem(icon: Icon(Icons.account_box)),
        ],
      ),

      /*Container(alignment: Alignment.center,color: Colors.blueGrey,
      child: RaisedButton(child:Text("Log out",style: TextStyle(fontFamily: "NR",fontSize: 50),),
      onPressed: (){
        logout();
      }
    )
    )*/
    );
  }
  Scaffold buildUnauthScreen(){
    return Scaffold(
        body: Container(alignment: Alignment.center,decoration: BoxDecoration(
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
    ),);
  }

  @override
  Widget build(BuildContext context) {
    return isAuth ? buildAuthScreen() : buildUnauthScreen();
  }
}
