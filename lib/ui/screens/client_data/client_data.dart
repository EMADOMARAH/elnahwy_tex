import 'dart:ui';

import 'package:elnahwy_tex/ui/screens/client_select/client_page.dart';
import 'package:elnahwy_tex/widget/container_clientdata_cloth.dart';
import 'package:elnahwy_tex/widget/cust_label.dart';
import 'package:elnahwy_tex/widget/cust_txtformfield.dart';
import 'package:elnahwy_tex/widget/cust_txtformfield_dialog.dart';
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          addcliendata(context);
        },
        icon: Icon(
          Icons.add,
          color: Colors.black,
          size: 30,
        ),
        label: Text(
          "إضافة",
          style:
          TextStyle(fontFamily: "Cairo", fontSize: 20, color: Colors.black),
        ),
        backgroundColor: Color(0xff6BD5E1),
      ),

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
      body: SafeArea(
        child: Container(
          height: double.infinity,
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
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  cust_label("اسم العميل"),
                  cust_txtformfield("اسم العميل", TextInputType.text),
                  Container_client_cloth(context,clothName, clothtupenumber, clothtype, clothNote),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
Future<void> addcliendata(BuildContext context) {
  TextEditingController  clientname=TextEditingController();
  TextEditingController clothtype=TextEditingController();
  TextEditingController clothtupenumber=TextEditingController();
  TextEditingController clothNote=TextEditingController();
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "إضافه بيانات ",
            textAlign: TextAlign.right,
            style: TextStyle(
                fontFamily: "Cairo", fontWeight: FontWeight.bold, fontSize: 20),
          ),
          content: SingleChildScrollView(
            child: Column(children: <Widget>[
              cust_txtformfield_dialog("اسم القماش",TextInputType.text,clientname),
              cust_txtformfield_dialog("عدد الامتار",TextInputType.number,clothtupenumber),
              cust_txtformfield_dialog("نوع الشريط",TextInputType.text,clothtype),
              cust_txtformfield_dialog("ملاحظات",TextInputType.multiline,clothNote)

            ],),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'إالغاء ',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "Cairo",
                    fontSize: 14,
                    color: Colors.red),
              ),
              onPressed: () {
                Navigator.pop(
                    context,
                    PageTransition(
                        type:
                        PageTransitionType.leftToRight,
                        child: ClientPage()));
              },
            ),
            TextButton(
              child: Text(
                'حفظ (اضافه) ',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "Cairo",
                    fontSize: 14,
                    color: Colors.green),
              ),
              onPressed: () {
                //insert function
                print("Client Name : ${clientname.toString()}");
                print("Meters : ${clothtupenumber.toString()}");
                print("Type : ${clothtype.toString()}");
                print("Note : ${clothNote.toString()}");
                Navigator.pop(
                    context,
                    PageTransition(
                        type:
                        PageTransitionType.leftToRight,
                        child: ClientPage()));
              },
            ),
          ],
        );
      });
}
