import 'package:flutter/material.dart';

AppBar header(context, {String titleText,String fontFamilyText, double fontSize, bool backButton=true}) {
  return AppBar(
    automaticallyImplyLeading: backButton,
    title:Text(titleText,
        style: TextStyle(
          fontFamily: fontFamilyText,
          fontSize: fontSize,
        )
    ),
    centerTitle: true,
    backgroundColor: Theme.of(context).primaryColor,
  );
}
