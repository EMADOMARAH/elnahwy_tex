import 'package:elnahwy_tex/model/factoryTypeModel.dart';
import 'package:elnahwy_tex/ui/screens/Cloth_type/clothtypeabout.dart';
import 'package:elnahwy_tex/ui/screens/home_screen/home_screen.dart';
import 'package:elnahwy_tex/utils/database_helper.dart';
import 'package:elnahwy_tex/widget/container_clientdata_cloth.dart';
import 'package:elnahwy_tex/widget/cust_txtformfield_dialog.dart';
import 'package:elnahwy_tex/widget/cutom_data_tile_client.dart';
import 'package:elnahwy_tex/widget/divider_cutom.dart';
import 'package:elnahwy_tex/widget/showDialogclient.dart';
import 'package:elnahwy_tex/widget/txt_dialog_form.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sqflite/sqflite.dart';

class factory_select extends StatefulWidget {
  @override
  _factory_selectState createState() => _factory_selectState();
}

class _factory_selectState extends State<factory_select>
    with SingleTickerProviderStateMixin {

  //make object from our DB
  DatabaseHelper databaseHelper = DatabaseHelper();
  TextEditingController factoryTypeController = TextEditingController();
  TabController controller;
  //make list data to hold out  factory type data
  FactoryTypes factoryTypes = new FactoryTypes();
  List<FactoryTypes> factoryTypesList = [];
  int count = 0;
  int customPosition;

  var id , name;
  var showItemList = List<Widget>();
  TextEditingController editingController = TextEditingController();


  var allTypes = [];
  var items = List();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = new TabController(length: 4, vsync: this);
    updateTypesListView();
    databaseHelper.getFactoryTypesList("").then((type){
      setState(() {
        allTypes = type;
        items = allTypes;
      });
    });}
  void filterSearchResults(String query) async {
    factoryTypesList = [];
    var dummySearchList = allTypes;
    if(query.isNotEmpty){
      setState(() {
        for(int index =0 ; index < dummySearchList.length; index++){
          FactoryTypes factoryTypes = dummySearchList[index];
          if(factoryTypes.name.toString().contains(query)){
            print('user'+index.toString());
            print(factoryTypes);
            factoryTypesList.add(factoryTypes);
          }
        }
      });
    }else{
      setState(() {
        updateTypesListView();
      });
    }
  }


  Future<bool> popfunc() async {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            txt_dialog_form(context,"إضافه نوع قماش","إسم القماش");
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
        body: WillPopScope(
          onWillPop: popfunc,
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
            child: ListView(
              children: [
                Container(
                  child: Padding(
                    padding: EdgeInsets.all(14),
                    child: Column(
                      children: <Widget>[
                        //search , back arrow & icon ROW
                        Row(
                          children: <Widget>[
                            IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.leftToRight,
                                      child: Home_Screen(),
                                    ),
                                  );
                                }),
                            Flexible(
                              child: TextFormField(
                                  onChanged: (value) {
                                    filterSearchResults(value);
                                  },
                                  keyboardType: TextInputType.text,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, top: 10, bottom: 10),
                                        child: Image.asset(
                                          'images/Search.png',
                                          width: 10,
                                          height: 10,
                                        ),
                                      ),
                                      fillColor: Colors.white.withOpacity(0.54),
                                      filled: true,
                                      hintText: 'بحــث',
                                      focusColor: Colors.white,
                                      hintStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontFamily: "Cairo",
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      contentPadding: EdgeInsets.all(10))),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Image(
                              image: AssetImage('images/Factory.png'),
                              height: 66,
                              width: 66,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: 27, left: 5, right: 5),
                            child: SingleChildScrollView(
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: factoryTypesList.length,
                                itemBuilder: (context, int position) {
                                  return GestureDetector(
                                    onLongPress: () {
                                      showMyDialog(context);
                                    },
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: clothabout(),
                                        ),
                                      );
                                    },
                                    child: custom_data(
                                      this.factoryTypesList[position].fTName.toString(),
                                      "No_title",
                                      IconButton(
                                        icon: Icon(Icons.more_vert),
                                        onPressed: () {
                                          id = this
                                              .factoryTypesList[position]
                                              .fTId;
                                          name = this
                                              .factoryTypesList[position]
                                              .fTName
                                              .toString();
                                          this.customPosition = position;
                                          _showMyDialog(context, position, factoryTypesList[position].fTId, factoryTypesList[position].fTName);
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Future<void> _showMyDialog(BuildContext context , int customPosition, int id , String name) async {
    print("Position : $customPosition   id : $id   name : $name");
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => true,
          child: AlertDialog(
            title: Text(
              'تعديل او حذف ',
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: "Cairo",
                  fontSize: 14),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    'هل تريد حذف او تعديل هذا الصنف ',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "Cairo",
                        fontSize: 14),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              //زرار التعديل ف الدايلوج
              TextButton(
                child: Text(
                  'تعديل ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "Cairo",
                      fontSize: 14,
                      color: Colors.green),
                ),
                onPressed: () {
                  txt_dialog_form(context,"تعديل اسم الصنف ",null);/*edit_screen(ClientNames.withId(id, name)))).then((value) => updateListView());*/
                },
              ),
              TextButton(
                child: Text(
                  'حذف',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "Cairo",
                      fontSize: 14,
                      color: Colors.red),
                ),
                //Second Dialog
                onPressed: () {
                  showDialog<void>(
                      context: context,
                      barrierDismissible: true, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            'هل انت متاكد من حذف هذا الصنف ',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "Cairo",
                                fontSize: 14),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text(
                                'تأكيد ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Cairo",
                                    fontSize: 14,
                                    color: Colors.green),
                              ),
                              onPressed: () {

                                _deleteType(context,factoryTypesList[customPosition] );
                                //احذف عميل من الداتا بيز
                                Navigator.pop(context);
                                moveToLastScreen();
                                updateTypesListView();
                              },
                            ),
                            TextButton(
                              child: Text(
                                'إلغاء ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Cairo",
                                    fontSize: 14,
                                    color: Colors.red),
                              ),
                              onPressed: () async {
                                //هيرجع للصفحه اللى وراه
                                //Navigator.of(context, rootNavigator: false).pop();
                                Navigator.pop(context);
                                moveToLastScreen();
                                /*await Navigator.of(context).push(
                                    new MaterialPageRoute(
                                        builder: (context) => ClientPage()));*/
                              },
                            ),
                          ],
                        );
                      });
                },
              ),
            ],
          ),
        );
      },
    );
  }
  Future<void> txt_dialog_form(BuildContext context,String title,String textTitle) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontFamily: "Cairo", fontSize: 18),
          ),
          content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  cust_txtformfield_dialog(
                      textTitle, TextInputType.text, factoryTypeController),
                ],
              )),
          actions: <Widget>[
            RaisedButton(
              child: Text(
                'إلغاء',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "Cairo",
                    fontSize: 14,
                    color: Colors.red),
              ),
              //Second Dialog
              onPressed: () {
                Navigator.pop(context);
                //moveToLastScreen();
              },
            ),
            RaisedButton(
              color: Colors.green,
              child: Text(
                'إضافة ',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "Cairo",
                    fontSize: 14,
                    color: Colors.white),
              ),
              onPressed: () {
                this.factoryTypes.fTName =factoryTypeController.text;
                this.factoryTypes.fTSource = 'F';
                //اضافه عميل جديد
                Navigator.pop(context);
                moveToLastScreen();
                save();
              },
            ),
          ],
        );
      },
    ).then((value) => updateTypesListView());



  }

  //save data to data base
  void save() async{
    //moveToLastScreen();
    //print("In SAVE");
    if (factoryTypes.fTName.isNotEmpty) {
      int result; //
      if (factoryTypes.fTId!= null) {
        result = await databaseHelper.updateFactoryType(factoryTypes);
      }else{
        // to check the operation success
        result = await databaseHelper.insertFactoryType(factoryTypes);
      }
      //print('LETS GOOOOOO ${factoryTypes.fTName}');
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

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  // delete item from types List<dynamic> listName
  void _deleteType(BuildContext context, FactoryTypes factoryTypes) async{
    int result = await databaseHelper.deleteRaw('factoryType_table', 'f_t_id', factoryTypes.fTId);
    if (result !=0) {
      updateTypesListView();
    }

  }


  void updateTypesListView() async {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<FactoryTypes>> factoryTypesListFuture =
      databaseHelper.getFactoryTypesList("");
      factoryTypesListFuture.then((typesList) {
        setState(() {
          this.factoryTypesList= typesList;
          this.count = typesList.length;
        });
      });
    });
  }


}
