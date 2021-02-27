import 'package:flutter/material.dart';

Widget custom_data(String Title, String No_title,Widget widget) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.grey[100], borderRadius: BorderRadius.circular(10)),
    child: ListTile(
      title: Text(
        Title,
        textAlign: TextAlign.right,
        style: TextStyle(
            fontFamily: "Cairo", fontSize: 20, fontWeight: FontWeight.bold),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: Text(
          No_title,
          textAlign: TextAlign.right,
          style: TextStyle(
            fontFamily: "Cairo",
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      leading: widget
    ),
  );
}

