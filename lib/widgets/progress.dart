import 'package:flutter/material.dart';

Container circularProgress() {
  return Container(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Colors.blueGrey),
    ),
    alignment: Alignment.center,
  );
}

Container linearProgress() {
  return Container(
    child: LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Colors.blueGrey),
      backgroundColor: Colors.deepOrange,
    ),
  );
}
