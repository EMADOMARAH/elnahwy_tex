import 'package:flutter/material.dart';

Widget cust_label (String ltext){
  return Padding(
    padding: const EdgeInsets.only(right :20.0),
    child: Text(ltext,style: TextStyle(
      fontFamily: "Cairo",fontSize: 15,color: Colors.black,
    ),),
  );
}