import 'package:flutter/material.dart';

Widget custom_data(String Title, String No_title,Widget widget) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.grey[30], borderRadius: BorderRadius.circular(10)),
    child: ListTile(
      title: Text(
        Title,
        textAlign: TextAlign.right,
        style: TextStyle(
            fontFamily: "Cairo", fontSize: 20, fontWeight: FontWeight.bold),
      ),
      leading: widget
    ),
  );
}

