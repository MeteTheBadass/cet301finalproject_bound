import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cet301finalproject_bound/main.dart';
import 'package:cet301finalproject_bound/models/user.dart';
import 'package:cet301finalproject_bound/widgets/progress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController= TextEditingController();
  Future<QuerySnapshot> searchResults;
  User user;
  performSearch(String userSearched){
    Future<QuerySnapshot> users=userRef.where("displayName", isGreaterThanOrEqualTo: userSearched ).get();
    setState(() {
      searchResults=users;
    });
  }
  clearSearch(){
    searchController.clear();
  }
  buildSearchField(){
    return AppBar(
      backgroundColor: Colors.white,
      title: TextFormField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: "Search for a user",
          filled:true,
          prefixIcon: Icon(
            Icons.person_search,
            size: 25,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.close,
            ),
            onPressed: clearSearch,
          )
        ),
        onFieldSubmitted: performSearch,
      ),
    );
  }
  buildNoContent(){
    return Container(
        child: ListView(
          shrinkWrap: true,
          children: [
            Image.asset("assets/images/search.png",height: 500,)
          ],
        ),
    );
  }
  buildSearchResults(){
    return FutureBuilder(
      future: searchResults,
      builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
        if(!snapshot.hasData){
          return circularProgress();
        }
        List<UserResult> searchResults=[];
        snapshot.data.docs.forEach((doc) {
          user=User.fromDocument(doc);
          UserResult searchResult=UserResult(user);
          searchResults.add(searchResult);
        });
        return ListView(
          children: searchResults,
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Theme.of(context).accentColor,
      appBar: buildSearchField(),
      body: searchResults==null? buildNoContent():buildSearchResults(),
    );
  }
}

class UserResult extends StatelessWidget {
  final User user;
  UserResult(this.user);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor.withOpacity(0.9),
      child: Column( children: [
        GestureDetector(
          onTap: () => print("Pressed"),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).accentColor.withOpacity(0.5),
              backgroundImage: CachedNetworkImageProvider(user.photoURL),
            ),
            title: Text(user.displayName,style: TextStyle(color: Colors.white,fontFamily: "ML"),),
            subtitle: Text(user.username,style: TextStyle(color: Colors.white),),
          ),
          ),
        SizedBox(height: 3,child: Container(color: Colors.deepOrange,),),
        ]
      ),
    );
  }
}
