import 'package:elnahwy_tex/ui/screens/Edit_screen/edit_Screen.dart';
import 'package:elnahwy_tex/ui/screens/add_client/add_client.dart';
import 'package:elnahwy_tex/ui/screens/client_data/client_data.dart';
import 'package:elnahwy_tex/model/clientNameModel.dart';
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
  TextEditingController editingController = TextEditingController();
  TabController controller;
  List<String> listItems = [
    "Johnny Depp",
    "Al Pacino",
    "Robert De Niro",
    "Kevin Spacey",
    "Denzel Washington",
    "Russell Crowe",
    "SBrad Pitt",
    "Sylvester Stallone",
    'Mohamed Wagdy',
    'محمد وجدي',
    'عماد عبد الحليم',
    'خالد حكيم',
    'احمد ضبش',
  ];
  var items = List<String>();
  @override  void initState() {
    // TODO: implement initState
    items.addAll(listItems);
    super.initState();
    controller = new TabController(length: 4, vsync: this);

  }

  @override  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

//make object from our DB
  DatabaseHelper databaseHelper = DatabaseHelper();

//make list data to hold out clients name data
  List<ClientNames> clientsNamesList=[];
  int count = 0;
  int customPosition;


  @override
  Widget build(BuildContext context) {
    //if out list == null initiate new one
    if(clientsNamesList == null){
      clientsNamesList = List<ClientNames>();
      updateListView();
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          navigateToAddClient(new ClientNames());
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
                            itemCount: count,
                            itemBuilder: (context, int position) {
                              customPosition=position;
                              return GestureDetector(
                                onLongPress: () {
                                  _showMyDialog(context);
                                },
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: client_data(),
                                    ),
                                  );
                                },
                                child: custom_data(this.clientsNamesList[position].cNName.toString(), 'No_title')
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
    );
  }


  //show snack bar and update the list after delete
  void _showSnackBar(BuildContext context,String message){
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

//delete item from the list
  void _delete(BuildContext context,ClientNames clientNames) async{
    int result = await databaseHelper.deleteRaw('clientName_table', 'c_n_id', clientNames.cNId);
    if(result !=0){
      _showSnackBar(context, 'تم مسح الأسم بنجاح');
      // TODO : UPDATE THE LIST VIEW AFTER DELETE AN ELEMENT
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database)
    {
      Future<List<ClientNames>> clientNamesListFuture = databaseHelper.getClientNamesList();
      clientNamesListFuture.then((namesList)
      {
        setState(() {
          this.clientsNamesList =namesList;
          this.count = namesList.length;

        });
      });
    });


  }

  void navigateToAddClient(ClientNames clientNames) async{
    bool result = await Navigator.push(context,MaterialPageRoute(builder: (context) {
      return Add_Client();
    }));
    setState(() {
      if (result== true) {
        print(":kakk");
      }
    });
  }


  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'تعديل او اضافه',
            textAlign: TextAlign.right,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontFamily: "Cairo", fontSize: 14),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'تعديل او حذف هذا العميل ',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "Cairo",
                      fontSize: 14),
                ),
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
                        type: PageTransitionType.fade, child: edit_screen(ClientNames())));
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
                              //ربنا يستر على الهبده دى
                              _delete(context, clientsNamesList[customPosition]);
                              //احذف عميل من الداتا بيز
                              print("حذف عميل ");
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
                            onPressed: () async{
                              //هيرجع للصفحه اللى وراه
                              //Navigator.of(context, rootNavigator: false).pop();
                              Navigator.pop(context);
                              await Navigator.of(context)
                                  .push(new MaterialPageRoute(builder: (context) => ClientPage()));
                            },
                          ),
                        ],
                      );
                    });
              },
            ),
          ],
        );
      },
    );
  }

  void filterSearchResults(String query) {
    List<String> dummySearchList = List<String>();
    dummySearchList.addAll(listItems);
    if (query.isNotEmpty) {
      List<String> dummyListData = List<String>();
      dummySearchList.forEach((item) {
        if (item.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(listItems);
      });
    }
  } //Now using

  Widget _buildCell(BuildContext context, int index,String name,) { // same as previous video
    return Padding(
      padding: EdgeInsets.only(left: 12.0,top: 5.0, right: 12.0),
      child: Material(
        color: Colors.grey,
        elevation: 5.0,
        borderRadius: BorderRadius.circular(10.0),
        child: ListTile(
          title: Text(
            name,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontFamily: "Cairo", fontSize: 20, fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Text(
              'عدد الاصناف',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontFamily: "Cairo",
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          leading: Image.asset("images/ic_keyboard_arrow_left_48px.png"),
        ),
      ),
    );
  }

}



Widget cust_txtformfield_dialog_(String title, var typeinput, TextEditingController controller){
  return Padding(
    padding: EdgeInsets.all(2),
    child:  TextFormField(
      controller:controller ,
      keyboardType:typeinput,
      cursorColor: Colors.black,
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        fillColor: Colors.white,
        hintText: title,
        hintStyle: TextStyle(
            fontFamily: "Cairo",
            color: Colors.black.withOpacity(0.4)
        ),
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


