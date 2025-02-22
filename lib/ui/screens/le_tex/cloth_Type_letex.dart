import 'package:elnahwy_tex/model/factoryClientModel.dart';
import 'package:elnahwy_tex/ui/screens/Cateogry_item/cateogry_item.dart';
import 'package:elnahwy_tex/ui/screens/le_tex/main_LE_Tex.dart';
import 'package:elnahwy_tex/utils/database_helper.dart';
import 'package:elnahwy_tex/widget/LE_tex_ccontainer_data_add_edit.dart';
import 'package:elnahwy_tex/widget/cust_label.dart';
import 'package:elnahwy_tex/widget/cust_txtformfield.dart';
import 'package:elnahwy_tex/widget/cust_txtformfield_dialog.dart';
import 'package:elnahwy_tex/widget/factorycontainercustom.dart';
import 'package:elnahwy_tex/widget/textformfieldclothdata.dart';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sqflite/sqflite.dart';

class letex_clothtype extends StatefulWidget {
  final int id;

  const letex_clothtype({Key key, this.id}) : super(key: key);


  @override
  _letex_clothtypeState createState() => _letex_clothtypeState(id);

}


class _letex_clothtypeState extends State<letex_clothtype> {
  int id;
  _letex_clothtypeState(this.id);

  DatabaseHelper databaseHelper = DatabaseHelper();
  FactoryClients factoryClient = new FactoryClients();
  List<FactoryClients> factoryClientsList= [];
  int listCount = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Clothes Type Id : ${id}");
    updateTypesListView();
  }

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
                  "بيانات القماش لى تيكس",
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
                  Padding(
                    padding:
                    EdgeInsets.only(top: 27, left: 5, right: 5),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: listCount,
                      itemBuilder: (context, position) {
                        return GestureDetector(
                          onLongPress: () {
                            //showMyDialog(context);
                          },
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   PageTransition(
                            //     type: PageTransitionType.rightToLeft,
                            //     child: letex_clothtype(),
                            //   ),
                            // );
                          },
                          child:
                          factorycust_container(
                              this.factoryClientsList[position].fCName.toString(),
                              this.factoryClientsList[position].fCTape.toString(),
                              this.factoryClientsList[position].fCMeters.toString(),
                              this.factoryClientsList[position].fCNote.toString(),
                              this.factoryClientsList[position].fCId,
                              context),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  void updateTypesListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<FactoryClients>> factoryClientsListFuture =
      databaseHelper.getFactoryClientsList(id);
      factoryClientsListFuture.then((clientsList) {
        setState(() {
          this.factoryClientsList= clientsList;
          this.listCount = clientsList.length;
        });
      });
    });

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
                  this.factoryClient.fCName = clientname.text;
                  this.factoryClient.fCMeters = clothtupenumber.text;
                  this.factoryClient.fCTape = clothtype.text;
                  this.factoryClient.fCNote = clothNote.text;
                  this.factoryClient.fTId = id;
                  Navigator.pop(context);
                  save();
                  updateTypesListView();
                },
              ),
            ],
          );
        });
  }

  //save data to data base
  void save() async{

    if (factoryClient.fCName.isNotEmpty && factoryClient.fCMeters.isNotEmpty && factoryClient.fCTape.isNotEmpty) {
      int result; // to check the operation success
      if (factoryClient.fCId!= null) {
        print("بنعدل");
        result = await databaseHelper.updateFactoryClient(factoryClient);
      }else{
        // to check the operation success
        print("نحفظ");
        result = await databaseHelper.insertFactoryClient(factoryClient);
        print(factoryClient);
      }

      if (result !=0) {
        // Success
        _ShowAlertDialog('نجاح' , 'تم الحفظ بنجاح',Colors.green);
      }else{
        //Failure
        _ShowAlertDialog('فشل' , 'حدث خطأ اثناء الحفظ',Colors.amber);
      }

    } else{
      _ShowAlertDialog("خطأ", "نوع القماش فاضى!",Colors.red);
    }
  }
  void _ShowAlertDialog(String title, String msg, var tcolor) {
    AlertDialog alertDialog = AlertDialog(
      title:  Text(title,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: "Cairo",color: tcolor,fontSize: 20,fontWeight: FontWeight.bold
        ),),
      content: Text(msg,textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: "Cairo",color: Colors.black,fontSize: 20
        ),),
    );
    showDialog(context: context,
        builder: (_) => alertDialog);
  }
  Widget factorycust_container(
      String clothName,
      String clothtype,
      String clothtupenumber,
      String clothNote,
      int id,
      BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xffC3FCF2).withGreen(120)),
          color: Color(0xffC3FCF2).withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.more_vert),
                      onPressed: () {
                        edit_delete_dialog_in_data(context , id);
                      }),
                  //اسم القماش
                  Flexible(child: textformcloth(clothName.toString())),
                ],
              ),
              Row(
                children: <Widget>[
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
              "هل تريد  حذف هذه البيانات",
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontFamily: "Cairo",
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.red),
            ),
            actions: <Widget>[
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
                  _deleteClient(context, id);
                  Navigator.pop(context);
                  updateTypesListView();
                },
              ),
            ],
          );
        });
  }

  // delete item from types List<dynamic> listName
  void _deleteClient(BuildContext context, int  factoryClientsId) async{
    int result = await databaseHelper.deleteRaw('factoryClient_table', 'f_c_id', factoryClientsId);
    if (result !=0) {
      updateTypesListView();
    }

  }

}


