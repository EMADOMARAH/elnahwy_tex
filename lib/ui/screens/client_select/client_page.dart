import 'package:elnahwy_tex/ui/screens/Edit_screen/edit_Screen.dart';
import 'package:elnahwy_tex/ui/screens/add_client/add_client.dart';
import 'package:elnahwy_tex/ui/screens/client_data/client_data.dart';
import 'package:elnahwy_tex/model/clientNameModel.dart';
import 'package:elnahwy_tex/ui/screens/home_screen/home_screen.dart';
import 'package:elnahwy_tex/utils/database_helper.dart';
import 'package:elnahwy_tex/widget/cutom_data_tile_client.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sqflite/sqflite.dart';

class ClientPage extends StatefulWidget {
  @override
  _ClientPageState createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage>
    with SingleTickerProviderStateMixin {
//make object from our DB
DatabaseHelper databaseHelper = DatabaseHelper();
TextEditingController editingController = TextEditingController();
TabController controller;
//make list data to hold out clients name data
List<ClientNames> clientsNamesList = [];
int count = 0;
int customPosition;

var id , name;
var allClient = [];
var items = List();
@override
void initState() {
  // TODO: implement initState
  super.initState();
  controller = new TabController(length: 4, vsync: this);
  updateListView();
  databaseHelper.getClientNamesList().then((client){
    setState(() {
      allClient = client;
      items = allClient;
    });
  });}
void filterSearchResults(String query) async {
  clientsNamesList=[];
  var dummySearchList = allClient;
  if(query.isNotEmpty){
    setState(() {
      for(int index =0 ; index < dummySearchList.length; index++){
        ClientNames clientNames = dummySearchList[index];
        if(clientNames.name.toString().contains(query)){
          print('user'+index.toString());
          print(clientNames);
          clientsNamesList.add(clientNames);
        }
      }
    });
  }else{
    setState(() {
      updateListView();
    });
  }
}

@override
void dispose() {
  // TODO: implement dispose
  controller.dispose();
  super.dispose();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          //navigateToAddClient();
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Add_Client();
          })).then((value) => updateListView());
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
      body: Container(
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
                                  type: PageTransitionType.rightToLeft,
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
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  contentPadding: EdgeInsets.all(10))),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Image(
                          image: AssetImage('images/Client.png'),
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
                        padding: EdgeInsets.only(top: 27, left: 5, right: 5),
                        child: SingleChildScrollView(
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: clientsNamesList.length,
                            itemBuilder: (context, int position) {

                              return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: client_data(),
                                      ),
                                    );
                                  },
                                  child: custom_data(
                                    this.clientsNamesList[position].cNName.toString(),
                                    'No_title',
                                    IconButton(
                                      icon: Icon(Icons.more_vert),
                                      onPressed: () {
                                        id = this.clientsNamesList[position].cNId;
                                        name = this.clientsNamesList[position].cNName.toString();
                                        this.customPosition = position;
                                        _showMyDialog(context,customPosition,id,name);
                                      },
                                    ),
                                  ));
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
    );
  }


//delete item from the list
  void _delete(BuildContext context, ClientNames clientNames) async {
    int result = await databaseHelper.deleteRaw(
        'clientName_table', 'c_n_id', clientNames.cNId);
    if (result != 0) {
      // TODO : UPDATE THE LIST VIEW AFTER DELETE AN ELEMENT
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<ClientNames>> clientNamesListFuture =
          databaseHelper.getClientNamesList();
      clientNamesListFuture.then((namesList) {
        setState(() {
          this.clientsNamesList = namesList;
          this.count = namesList.length;
        });
      });
    });

    print("Count : ${count.toString()}");
  }

  void navigateToAddClient() async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Add_Client();
    }));
    setState(() {
      if (result == true) {
        updateListView();
      }
    });
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
                    'هل تريد حذف او تعديل هذا العميل ',
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
                 Navigator.push(
                     context,
                     PageTransition(
                     type: PageTransitionType.fade,
                     child:  edit_screen(ClientNames.withId(id, name)))).then((value) => updateListView());
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
                            'هل انت متاكد من حذف هذا العميل ',
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

                                _delete(context,clientsNamesList[customPosition] );
                                //احذف عميل من الداتا بيز
                                Navigator.pop(context);
                                Navigator.pop(context);
                                updateListView();
                                //اعمل تحديث للداتا بعد الحذف
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
  Widget _buildCell(
    BuildContext context,
    int index,
    String name,
  ) {
    // same as previous video
  }
}

Widget cust_txtformfield_dialog_(
    String title, var typeinput, TextEditingController controller) {
  return Padding(
    padding: EdgeInsets.all(2),
    child: TextFormField(
      controller: controller,
      keyboardType: typeinput,
      cursorColor: Colors.black,
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        fillColor: Colors.white,
        hintText: title,
        hintStyle: TextStyle(
            fontFamily: "Cairo", color: Colors.black.withOpacity(0.4)),
        /*border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:BorderSide(
              color: Colors.black,
              width: 2,
            ),
          ),*/
        contentPadding: EdgeInsets.all(5),
      ),
    ),
  );
}
