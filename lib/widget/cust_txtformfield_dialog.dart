import 'package:flutter/material.dart';
Widget cust_txtformfield_dialog(
    String title, var typeinput, TextEditingController controller) {
  return Padding(
    padding: EdgeInsets.all(2),
    child: TextFormField(
      controller: controller,
      keyboardType: typeinput,
      cursorColor: Colors.black,
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        fillColor: Colors.white,
        hintText: title,
        hintStyle: TextStyle(
            fontFamily: "Cairo", color: Colors.black.withOpacity(0.4)),
        /*border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:BorderSide(
              color: Colors.black,
              width: 2,
            ),
          ),*/
        contentPadding: EdgeInsets.all(5),
      ),
    ),
  );
}