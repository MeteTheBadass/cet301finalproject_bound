import 'package:cet301finalproject_bound/main.dart';
import 'package:cet301finalproject_bound/models/user.dart';
import 'package:cet301finalproject_bound/pages/activity_feed.dart';
import 'package:cet301finalproject_bound/pages/profile.dart';
import 'package:cet301finalproject_bound/pages/search.dart';
import 'package:cet301finalproject_bound/pages/upload.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cet301finalproject_bound/pages/create_account.dart';


final GoogleSignIn googleSignIn =GoogleSignIn();
final DateTime timeStamp=DateTime.now();
User currentUser;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isAuth = false;
  PageController pageController;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    googleSignIn.onCurrentUserChanged.listen((account) {
      signInControl(account);
    }, onError: (error) {
      print("Error sign in: $error");
    });
    googleSignIn.signInSilently(suppressErrors: false).then((account) {
      signInControl(account);
    }).catchError((error) {
      print("Error sign in: $error");
    });
  }

  signInControl(GoogleSignInAccount account) {
    if (account != null) {
      createUserFireBase();
      print("User $account signed in");
      setState(() {
        isAuth = true;
      });
    }
    else {
      setState(() {
        isAuth = false;
      });
    }
  }

  createUserFireBase() async {
    final GoogleSignInAccount user = googleSignIn.currentUser;
    DocumentSnapshot doc = await userRef.doc(user.id).get();
    if (!doc.exists) {
      final username = await Navigator.push(
          context, MaterialPageRoute(builder: (context) => CreateAccount()));
      userRef.doc(user.id).set({
        "id": user.id,
        "username": username,
        "displayName": user.displayName,
        "photoURL": user.photoUrl,
        "email": user.email,
        "bio": "",
        "timeStamp": timeStamp,
      })
          .catchError((error) {
        print("Error: $error");
      });
      doc=await userRef.doc(user.id).get();
    }
    currentUser=User.fromDocument(doc);
  }

    onPageChanged(int pageIndex) {
      setState(() {
        this.pageIndex = pageIndex;
      });
    }
    test(){
    print(currentUser);
    print("Current User's username is ${currentUser.username}");}


    @override
    void dispose() {
      pageController.dispose();
      super.dispose();
    }

    onTap(int pageIndex) {
      pageController.animateToPage(
          pageIndex, duration: Duration(milliseconds: 250),
          curve: Curves.bounceInOut);
    }

    login() {
      googleSignIn.signIn();
    }

    logout() {
      var currentUser = googleSignIn.currentUser;
      print("User $currentUser signed out");
      googleSignIn.signOut();
    }
    Scaffold buildAuthScreen() {
      return Scaffold(
        body: PageView(
          children: <Widget>[
            //Timeline(),
            Container(alignment: Alignment.center,color: Theme.of(context).accentColor,
                child:Column(children: [
                  SizedBox(
                    height: 50,
                  ),
                  RaisedButton(child:Text("Log out",style: TextStyle(fontFamily: "NR",fontSize: 50),),
                      onPressed: (){
                        logout();
                      }
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RaisedButton(child:Text("Fetch data from Firebase \n to Debug Console Button",style: TextStyle(fontFamily: "NR",fontSize: 20),),
                      onPressed: (){
                        test();
                      }
                  ),

                ],)
            ),
            Search(),
            Upload(currentUser:currentUser),
            ActivityFeed(),
            Profile(),
          ],
          controller: pageController,
          onPageChanged: onPageChanged,
          physics: NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: CupertinoTabBar(backgroundColor: Theme.of(context).primaryColor,
          currentIndex: pageIndex,
          onTap: onTap,
          activeColor: Colors.deepOrange,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home)),
            BottomNavigationBarItem(icon: Icon(Icons.search)),
            BottomNavigationBarItem(icon: Icon(Icons.add_box, size: 50,)),
            BottomNavigationBarItem(icon: Icon(Icons.notifications_active)),
            BottomNavigationBarItem(icon: Icon(Icons.account_box)),
          ],
        ),
      );
    }
    Scaffold buildUnauthScreen() {
      return Scaffold(
        body: Container(alignment: Alignment.center, decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme
                  .of(context)
                  .primaryColor,
              Theme
                  .of(context)
                  .accentColor,
            ],
          ),
        ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(radius: 120,backgroundColor: Colors.transparent,
                child: Image.asset("assets/images/iconInApp.png"),
              ),
              SizedBox(height: 50,),
              GestureDetector(onTap: () {
                login();
              }, child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage(
                          "assets/images/google_signin_button.png"),
                          fit: BoxFit.fill)
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
