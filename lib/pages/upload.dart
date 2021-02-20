import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cet301finalproject_bound/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Upload extends StatefulWidget {
  final User currentUser;
  Upload({this.currentUser});
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  PickedFile file;

  initiateCamera()async{
    Navigator.pop(context);
    PickedFile file=await ImagePicker().getImage(source: ImageSource.camera,
      maxHeight: 600,
      maxWidth: 600,
    );
    setState(() {
      this.file=file;
    });
  }
  initiateGallery()async{
    Navigator.pop(context);
    PickedFile file= await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      this.file=file;
    });
  }

  selectImage(mainContext){
    return showDialog(context: mainContext,
    builder: (context){
        return SimpleDialog(
          title: Text("Create Post"),
          children: <Widget>[
            SimpleDialogOption(
              child: Text("Camera"),
              onPressed: () => initiateCamera(),
            ),
            SimpleDialogOption(
              child: Text("Gallery"),
              onPressed: ()=> initiateGallery(),
            ),
            SimpleDialogOption(
              child: Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      }
    );
  }

  Container buildSplashScreen(){
    return Container(
      color: Theme.of(context).accentColor,
      child: Column(crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(padding: EdgeInsets.only(right: 45),
          child: Image.asset("assets/images/upload.png"),),
        RaisedButton(color: Theme.of(context).primaryColor,
            child:Text("Upload",style: TextStyle(fontFamily: "ML",fontSize: 35,color: Colors.white),),
            onPressed: () => selectImage(context),
            ),
        ],
      ),
    );
  }
  clearImage(){
    setState(() {
      file=null;
    });
  }
  Scaffold buildUploadForm(){
    return Scaffold(
      appBar: AppBar(centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: clearImage,
        ),
        title: Text("Caption",style: TextStyle(color: Colors.white),),
        actions: [
          FlatButton(onPressed: () => print("Pressed"),
              child: Text("Post",style: TextStyle(color: Colors.deepOrange[400],fontSize: 20),))
        ],
      ),
      body: Container(color: Theme.of(context).primaryColor,
        child: ListView(
          children: [
            Container(
              height: 300,
              width: MediaQuery.of(context).size.width*0.8,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(File(file.path)),
                      )
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 7.5)),
            Container(color: Theme.of(context).accentColor,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(widget.currentUser.photoURL),
                ),
                title: Container(
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(hintStyle: TextStyle(color: Colors.white),
                      hintText: "Write a caption",
                      border: InputBorder.none,
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Divider(),
            Container(color: Theme.of(context).accentColor,
              child: ListTile(
                leading: Icon(Icons.place,color:Colors.deepOrange,size: 40,),
                title: Container(
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(hintStyle: TextStyle(color: Colors.white),
                      hintText: "Choose a location for this photo",
                      border: InputBorder.none,
                    ), style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Container(
              width: 300,
              height: 150,
              alignment: Alignment.center,
              child: RaisedButton.icon(
                label:Text("Use Current Location",style: TextStyle(color: Colors.white),),
                color: Colors.deepOrange[400],
                onPressed: ()=>print("User Location Taken"),
                icon: Icon(
                    Icons.my_location,color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return file==null? buildSplashScreen(): buildUploadForm();
  }
}
