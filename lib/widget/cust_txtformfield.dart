import 'package:flutter/material.dart';

Widget cust_txtformfield(String title, var typeinput) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8,right: 8,left: 8),
    child: TextFormField(
      readOnly: false,
      keyboardType: typeinput,
      cursorColor: Colors.black,
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
        contentPadding: EdgeInsets.all(10),
      ),
    ),
  );
}
