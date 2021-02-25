import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget textformcloth(String title){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      readOnly: true,
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        fillColor: Colors.white.withOpacity(0.2),
        filled: true,
        hintText: title,
        hintStyle: TextStyle(
            fontFamily: "Cairo",
            fontSize: 18,
            color: Colors.black.withOpacity(0.7)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Color(0xff659B91),
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Color(0xffC3FCF2),
            width: 2,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),
      ),
    ),
  );
}