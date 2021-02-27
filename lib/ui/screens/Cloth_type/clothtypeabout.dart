import 'package:elnahwy_tex/ui/screens/Cateogry_item/cateogry_item.dart';
import 'package:elnahwy_tex/widget/cust_label.dart';
import 'package:elnahwy_tex/widget/cust_txtformfield.dart';
import 'package:elnahwy_tex/widget/factorycontainercustom.dart';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
class clothabout extends StatefulWidget {
  @override
  _clothaboutState createState() => _clothaboutState();
}

class _clothaboutState extends State<clothabout> {

  TextEditingController  clientname;

  TextEditingController clothtype;

  TextEditingController clothtupenumber;

  TextEditingController clothNote;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            //Dialog to enter Data
          },
          icon: Icon(
            Icons.add,
            color: Colors.green,
            size: 30,
          ),
          label: Text(
            "إضافة",
            style:
            TextStyle(fontFamily: "Cairo", fontSize: 20, color: Colors.green),
          ),
          backgroundColor: Colors.black87,
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
                        child: factory_select(),
                      ),
                    );
                  },
                ),
                Spacer(
                  flex: 1,
                ),
                Text(
                  "بيانات القماش",
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
            )
            , child:Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                cust_label("اسم القماش"),
                cust_txtformfield("اسم القماش", TextInputType.text),
                factorycust_container(clientname,clothtupenumber,clothtype,clothNote,context),
                factorycust_container(clientname,clothtupenumber,clothtype,clothNote,context),
                factorycust_container(clientname,clothtupenumber,clothtype,clothNote,context),
                factorycust_container(clientname,clothtupenumber,clothtype,clothNote,context),
                factorycust_container(clientname,clothtupenumber,clothtype,clothNote,context),

                Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: RaisedButton(
                      color: Colors.white,
                      child: Text(
                        'رجوع',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "Cairo",
                            fontSize: 18,
                            color: Colors.green),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type:
                            PageTransitionType.leftToRight,
                            child: factory_select(),
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
          ),
        )
    );
  }
}
