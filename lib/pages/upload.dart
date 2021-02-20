import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Upload extends StatefulWidget {
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

  @override
  Widget build(BuildContext context) {
    return file==null? buildSplashScreen():Text("File Loaded");
  }
}
