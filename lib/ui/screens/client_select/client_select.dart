import 'package:elnahwy_tex/Widget/background_color.dart';
import 'package:flutter/material.dart';

class Client_Select extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Background_color(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text("A7a"),
              Container(
                height: 48,
                width: 236,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
