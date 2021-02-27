import 'dart:ui';

import 'package:elnahwy_tex/ui/screens/client_select/client_page.dart';
import 'package:elnahwy_tex/widget/container_clientdata_cloth.dart';
import 'package:elnahwy_tex/widget/cust_label.dart';
import 'package:elnahwy_tex/widget/cust_txtformfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class client_data extends StatefulWidget {
  @override
  _client_dataState createState() => _client_dataState();
}

class _client_dataState extends State<client_data> {
  TextEditingController clothName;
  TextEditingController clothtype;
  TextEditingController clothtupenumber;
  TextEditingController clothNote;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Color(0xff659B91),
          title: Row(
            children: <Widget>[
              SizedBox(
                width: 10,
              ),
              Spacer(
                flex: 1,
              ),
              Text(
                "بيانات العميل",
                style:
                    TextStyle(fontFamily: "Cairo", fontWeight: FontWeight.bold),
              )
            ],
          )),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: new LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xffC3FCF2),
                Color(0xff659B91),
              ],
            ),
          ),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                cust_label("اسم العميل"),
                cust_txtformfield("اسم العميل", TextInputType.text),
                Container_client_cloth(
                    clothName, clothtupenumber, clothtype, clothNote),
                Container_client_cloth(
                    clothName, clothtupenumber, clothtype, clothNote),
                Container_client_cloth(
                    clothName, clothtupenumber, clothtype, clothNote),
                Container_client_cloth(
                    clothName, clothtupenumber, clothtype, clothNote),
                Container_client_cloth(
                    clothName, clothtupenumber, clothtype, clothNote),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
