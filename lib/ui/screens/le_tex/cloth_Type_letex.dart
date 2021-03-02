import 'package:elnahwy_tex/ui/screens/Cateogry_item/cateogry_item.dart';
import 'package:elnahwy_tex/ui/screens/le_tex/main_LE_Tex.dart';
import 'package:elnahwy_tex/widget/LE_tex_ccontainer_data_add_edit.dart';
import 'package:elnahwy_tex/widget/cust_label.dart';
import 'package:elnahwy_tex/widget/cust_txtformfield.dart';
import 'package:elnahwy_tex/widget/cust_txtformfield_dialog.dart';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class letex_clothtype extends StatefulWidget {
  @override
  _letex_clothtypeState createState() => _letex_clothtypeState();
}

TextEditingController clientname;
TextEditingController clothtype;
TextEditingController clothtupenumber;
TextEditingController clothNote;

class _letex_clothtypeState extends State<letex_clothtype> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            addclothdata(context);
          },
          icon: Icon(
            Icons.add,
            color: Colors.black,
            size: 30,
          ),
          label: Text(
            "إضافة",
            style: TextStyle(
                fontFamily: "Cairo", fontSize: 20, color: Colors.black),
          ),
          backgroundColor: Color(0xff6BD5E1),
        ),
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Color(0xff659B91),
            title: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: LE_tex_home(),
                      ),
                    );
                  },
                ),
                Spacer(
                  flex: 1,
                ),
                Text(
                  "بيانات القماش لى تيكس",
                  style: TextStyle(
                      fontFamily: "Cairo", fontWeight: FontWeight.bold),
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
                    cust_label("اسم الصنف"),
                    cust_txtformfield("اسم الصنف", TextInputType.text),
                    le_tex_container(clientname, clothtupenumber, clothtype,
                        clothNote, context),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

Future<void> addclothdata(BuildContext context) {
  TextEditingController clientname = TextEditingController();
  TextEditingController clothtype = TextEditingController();
  TextEditingController clothtupenumber = TextEditingController();
  TextEditingController clothNote = TextEditingController();
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
            child: Column(
              children: <Widget>[
                cust_txtformfield_dialog(
                    "اسم العميل", TextInputType.text, clientname),
                cust_txtformfield_dialog(
                    "عدد الامتار", TextInputType.number, clothtupenumber),
                cust_txtformfield_dialog(
                    "نوع الشريط", TextInputType.text, clothtype),
                cust_txtformfield_dialog(
                    "ملاحظات", TextInputType.multiline, clothNote)
              ],
            ),
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
                        type: PageTransitionType.leftToRight,
                        child: letex_clothtype()));
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
                        type: PageTransitionType.leftToRight,
                        child: LE_tex_home()));
              },
            ),
          ],
        );
      });
}
