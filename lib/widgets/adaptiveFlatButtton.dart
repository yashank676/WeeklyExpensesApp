import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'new_transaction.dart';

class adaptiveFlatButton extends StatelessWidget {
  final String text;
  final Function handler;
  adaptiveFlatButton(this.text,this.handler);

  @override
  Widget build(BuildContext context) {
    return 
    Platform.isIOS?
    CupertinoButton(
      child: Text(text,
      style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Quicksand'),),
      onPressed:()=> handler())
    :
    FlatButton(
      textColor: Colors.red,
      onPressed:()=> handler(),
      child: Text(text,style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Quicksand'),)
      );
  }
}