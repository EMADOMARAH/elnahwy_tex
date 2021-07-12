import 'dart:ui';

import 'package:elnahwy_tex/model/clientTypeModel.dart';
import 'package:elnahwy_tex/ui/screens/client_select/client_page.dart';
import 'package:elnahwy_tex/utils/database_helper.dart';
import 'package:elnahwy_tex/widget/container_clientdata_cloth.dart';
import 'package:elnahwy_tex/widget/cust_label.dart';
import 'package:elnahwy_tex/widget/cust_txtformfield.dart';
import 'package:elnahwy_tex/widget/cust_txtformfield_dialog.dart';
import 'package:elnahwy_tex/widget/textformfieldclothdata.dart';
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
        child: SingleChildScrollView(
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
                  Padding(
                    padding: EdgeInsets.only(top: 27, left: 5, right: 5),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: count,
                      itemBuilder: (context, int position) {
                        return GestureDetector(
                          onLongPress: () {
                            // showMyDialog(context);
                          },
                          child: Container_client_cloth(
                              context,
                              clientTypesList[position].cTId,
                              clientTypesList[position].cTName.toString(),
                              clientTypesList[position].cTTape.toString(),
                              clientTypesList[position].cTMeters.toString(),
                              clientTypesList[position].cTNote.toString()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget Container_client_cloth (
      BuildContext context,
      int id,
      String  clothName,
      String clothtype,
      String clothtupenumber,
      String clothNote){

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xffC3FCF2).withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
//اسم القماش
              Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.more_vert),
                      onPressed: () {
                        edit_delete_dialog_in_data(context , id);
                      }),
                  Flexible(child: textformcloth(clothName.toString())),
                ],
              ),
              Row(children: <Widget>[
//عدد الامتار
                Flexible(child: textformcloth(clothtupenumber.toString())),
//نوع الشريط
                Flexible(child: textformcloth(clothtype.toString()))
              ],
              ),
              textformcloth(clothNote.toString())
            ],
          ),
        ),
      ),
    );
  }
  Future<void> edit_delete_dialog_in_data(BuildContext context , int id) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "حذف البيانات ",
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontFamily: "Cairo", fontWeight: FontWeight.bold, fontSize: 20),
            ),
            content: Text(
              "هل تريد حذف هذه البيانات",
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontFamily: "Cairo",
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.red),
            ),
            actions: <Widget>[
              //delete
              TextButton(
                child: Text(
                  'حذف ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "Cairo",
                      fontSize: 14,
                      color: Colors.red),
                ),
                onPressed: () {
                  _deleteType(context, id);
                  Navigator.pop(context);
                  updateTypesListView();
                },
              ),
              //edit


            ],
          );
        });

  }
  Future<void> addcliendata(BuildContext context) {
    TextEditingController  clothname = TextEditingController();
    TextEditingController clothtype = TextEditingController();
    TextEditingController clothtupenumber = TextEditingController();
    TextEditingController clothNote = TextEditingController();
    return showDialog(
        context: context,
        builder: (BuildContext dialogcontext) {
          return AlertDialog(
            title: Text(
              "إضافه بيانات ",
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontFamily: "Cairo", fontWeight: FontWeight.bold, fontSize: 20),
            ),
            content: SingleChildScrollView(
              child: Column(children: <Widget>[
                cust_txtformfield_dialog("اسم القماش",TextInputType.text,clothname),
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
                  Navigator.of(dialogcontext).pop();
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
                  this.clientType.cTName = clothname.text;
                  this.clientType.cTMeters = clothtupenumber.text;
                  this.clientType.cTTape = clothtype.text;
                  this.clientType.cTNote = clothNote.text;
                  this.clientType.cNId =id;
                  Navigator.pop(context);
                  save();
                  updateTypesListView();
                },
              ),
            ],
          );
        });
  }

  void updateTypesListView() async {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<ClientType>> factoryClientsListFuture =
      databaseHelper.getClientTypesList();
      factoryClientsListFuture.then((typesList) {
        setState(() {
          this.clientTypesList = typesList;
          this.count = typesList.length;
        });
      });
    });

  }

  // delete item from types List<dynamic> listName
  void _deleteType(BuildContext context, int  clientTypeId) async{
    int result = await databaseHelper.deleteRaw('clientType_table', 'c_t_id', clientTypeId);
    if (result !=0) {
      updateTypesListView();
    }

  }


  //save data to data base
  void save() async {

    if (clientType.cTName.isNotEmpty && clientType.cTMeters.isNotEmpty && clientType.cTTape.isNotEmpty) {
      int result; //
      if (clientType.cTId != null) {
        result = await databaseHelper.updateClientType(clientType);
        print("بنعدل");
      } else {
        // to check the operation success
        result = await databaseHelper.insertClientType(clientType);
        print("نحفظ");
      }
      if (result != 0) {
        // Success
         _ShowAlertDialog('نجاح' , 'تم الحفظ بنجاح',Colors.green);
      } else {
        //Failure
         _ShowAlertDialog('فشل' , 'حدث خطأ اثناء الحفظ',Colors.amber);
      }
    } else {
      _ShowAlertDialog("خطأ", "نوع القماش فاضى!",Colors.red);
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
