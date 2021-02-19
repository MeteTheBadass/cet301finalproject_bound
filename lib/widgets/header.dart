import 'package:flutter/material.dart';

AppBar header(context, {String titleText,String fontFamilyText, double fontSize}) {
  return AppBar(
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
