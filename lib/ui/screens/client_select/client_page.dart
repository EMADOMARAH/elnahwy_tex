import 'package:elnahwy_tex/ui/screens/Edit_screen/edit_Screen.dart';
import 'package:elnahwy_tex/ui/screens/client_data/client_data.dart';
import 'package:elnahwy_tex/model/clientNameModel.dart';
import 'package:elnahwy_tex/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sqflite/sqflite.dart';

class ClientPage extends StatefulWidget {

  @override
  _ClientPageState createState() => _ClientPageState();
}
class _ClientPageState extends State<ClientPage> {
//make object from our DB
  DatabaseHelper databaseHelper = DatabaseHelper();

//make list data to hold out clients name data
  List<ClientNames> clientsNamesList;
  int count = 0;
  int customPosition;

  TextEditingController editingController = TextEditingController();

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
          navigateToClientDetail(new ClientNames() , "اضافه عميل");
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

  void navigateToClientDetail(ClientNames clientNames, String title) async{
    bool result = await Navigator.push(context,MaterialPageRoute(builder: (context) {
      return edit_screen(clientNames);
    }));
    if (result== true) {
      updateListView();
    }
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


}







Future<void> txt_dialog_form(BuildContext context) async {
  TextEditingController cilentNameController = TextEditingController();
  TextEditingController notypeController = TextEditingController();
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'إضافه عميل جديد',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontFamily: "Cairo", fontSize: 18),
        ),
        content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                cust_txtformfield_dialog("اسم العميل", TextInputType.text,cilentNameController),
              ],
            )
        ),
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
              showDialog<void>(
                  context: context,
                  barrierDismissible: true, // user must tap button!
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        'هل تريد إلغاء اضافه العميل ؟',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "Cairo",
                            fontSize: 14),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text(
                            'نعم',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "Cairo",
                                fontSize: 14,
                                color: Colors.red),
                          ),
                          onPressed: () async {
                            Navigator.pop(context);
                            await Navigator.of(context)
                                .push(new MaterialPageRoute(builder: (context) => ClientPage()));
                          },
                        ),
                        TextButton(
                          child: Text(
                            'إلغاء ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "Cairo",
                                fontSize: 14,
                                color: Colors.green),
                          ),
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                        ),
                      ],
                    );
                  });
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
                  color: Colors.black38.withOpacity(0.5)),
            ),
            onPressed: () {
              //اضافه عميل جديد
              print(cilentNameController);
              Navigator.of(context, rootNavigator: true).pop();
            },
          ),
        ],
      );
    },
  );
}
Widget cust_txtformfield_dialog(String title, var typeinput, TextEditingController controller){
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
Widget cust_divider(){
  return  Divider(
    color: Colors.black38.withOpacity(0.2),
    thickness: 2,
  );
}
Widget custom_data(String Title, String No_title) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.grey[100], borderRadius: BorderRadius.circular(10)),
    child: ListTile(
      title: Text(Title,textAlign: TextAlign.right,style: TextStyle(
        fontFamily: "Cairo",fontSize: 20,fontWeight: FontWeight.bold
      ),),
      subtitle: Padding(
        padding: const EdgeInsets.only(right:15.0),
        child: Text(No_title,textAlign: TextAlign.right,style: TextStyle(
          fontFamily: "Cairo",fontWeight:FontWeight.w300,
        ),),
      ),
      leading: Image.asset("images/ic_keyboard_arrow_left_48px.png"),
    ),
  );
}


