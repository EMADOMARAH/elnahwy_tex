import 'dart:ui';

import 'package:elnahwy_tex/model/clientTypeModel.dart';
import 'package:elnahwy_tex/ui/screens/client_select/client_page.dart';
import 'package:elnahwy_tex/utils/database_helper.dart';
import 'package:elnahwy_tex/widget/container_clientdata_cloth.dart';
import 'package:elnahwy_tex/widget/cust_label.dart';
import 'package:elnahwy_tex/widget/cust_txtformfield.dart';
import 'package:elnahwy_tex/widget/cust_txtformfield_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sqflite/sqflite.dart';

class client_data extends StatefulWidget {
  final int id;
  final String clientName;
  client_data({Key key, @required this.id, @required this.clientName}) : super(key: key);
  @override
  _client_dataState createState() => _client_dataState(id, clientName);
}

class _client_dataState extends State<client_data> {
  int id;
  String clientName;
  _client_dataState(this.id, this.clientName);
  //make object from our DB
  DatabaseHelper databaseHelper = DatabaseHelper();
  ClientType clientType = new ClientType();
  List<ClientType> clientTypesList = [];
  int count = 0;

  String clothName;
  String clothtype;
  String clothtupenumber;
  String clothNote;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateTypesListView();
    print(clientName);
  }

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
          style: TextStyle(fontFamily: "Cairo", fontSize: 20, color: Colors.black),
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
                style: TextStyle(fontFamily: "Cairo", fontWeight: FontWeight.bold),
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
                  cust_txtformfield(clientName.toString(), null),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: clientTypesList.length,
                    itemBuilder: (context, int position) {
                      return GestureDetector(
                        onLongPress: () {
                          // showMyDialog(context);
                        },
                        child: Container_client_cloth(
                            context,
                            clientTypesList[position].cTName.toString(),
                            clientTypesList[position].cTTape.toString(),
                            clientTypesList[position].cTMeters.toString(),
                            clientTypesList[position].cTNote.toString()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void updateTypesListView() async {
    // try to avoid VoidCallbacks
    // final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    // dbFuture.then((database) {
    //   Future<List<Map<String, dynamic>>> clientTypesListFuture =
    //   databaseHelper.getSecondTableDataMapList('clientType_table', 'c_n_id', id);
    //   clientTypesListFuture.then((typesList) {
    //     setState(() {
    //       this.clientTypesList= typesList.cast<ClientType>();
    //       this.count = typesList.length;
    //       print (count);
    //     });
    //   });
    // });
    //
    // final db = await databaseHelper.initializeDatabase();
    // in 2 lines only
    // todo (max) : 3 use async await when possible
    // don't user Future.then when the code base get bigger
    // it will look like طبق كشري او والله
    clientTypesList = await databaseHelper.getSecondTableDataMapList('clientType_table', 'c_n_id', id);

    setState(() => count = clientTypesList.length);
  }

  Future<void> addcliendata(BuildContext context) {
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
              style: TextStyle(fontFamily: "Cairo", fontWeight: FontWeight.bold, fontSize: 20),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  cust_txtformfield_dialog("اسم القماش", TextInputType.text, clientname),
                  cust_txtformfield_dialog("عدد الامتار", TextInputType.number, clothtupenumber),
                  cust_txtformfield_dialog("نوع الشريط", TextInputType.text, clothtype),
                  cust_txtformfield_dialog("ملاحظات", TextInputType.multiline, clothNote)
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'إالغاء ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Cairo", fontSize: 14, color: Colors.red),
                ),
                onPressed: () {
                  Navigator.pop(context, PageTransition(type: PageTransitionType.leftToRight, child: ClientPage()));
                },
              ),
              TextButton(
                child: Text(
                  'حفظ (اضافه) ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Cairo", fontSize: 14, color: Colors.green),
                ),
                onPressed: () {
                  //insert function
                  this.clientType.cTName = clientname.text;
                  this.clientType.cTMeters = clothtupenumber.toString();
                  this.clientType.cTTape = clothtype.text;
                  this.clientType.cTNote = clothNote.text;
                  this.clientType.cNId = id;
                  save();
                  Navigator.pop(context, PageTransition(type: PageTransitionType.leftToRight, child: ClientPage()));
                },
              ),
            ],
          );
        });
  }

  //save data to data base
  void save() async {
    //moveToLastScreen();
    //print("In SAVE");
    if (clientType.cTName.isNotEmpty) {
      int result; //
      if (clientType.cTId != null) {
        result = await databaseHelper.updateClientType(clientType);
        print("update client type");
      } else {
        // to check the operation success
        result = await databaseHelper.insertClientType(clientType);

      }
      //print('LETS GOOOOOO ${factoryTypes.fTName}');
      if (result != 0) {
        // Success
        // _ShowAlertDialog('نجاح' , 'تم الحفظ بنجاح',Colors.green);
      } else {
        //Failure
        // _ShowAlertDialog('فشل' , 'حدث خطأ اثناء الحفظ',Colors.amber);
      }
    } else {
      //_ShowAlertDialog("خطأ", "نوع القماش فاضى!",Colors.red);
    }
  }

  void _ShowAlertDialog(String title, String msg, var tcolor) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontFamily: "Cairo", color: tcolor, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      content: Text(
        msg,
        textAlign: TextAlign.center,
        style: TextStyle(fontFamily: "Cairo", color: Colors.black, fontSize: 20),
      ),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
