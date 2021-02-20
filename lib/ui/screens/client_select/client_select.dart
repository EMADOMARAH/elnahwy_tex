import 'package:elnahwy_tex/ui/screens/Edit_screen/edit_Screen.dart';
import 'package:elnahwy_tex/ui/screens/edit_form/edit__form.dart';
import 'package:elnahwy_tex/ui/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';


class Client_Select extends StatelessWidget {
  TextEditingController cilentNameController = TextEditingController();
  TextEditingController notypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            print("احا");
            txt_dialog_form(context);
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
                                  topRight: Radius.circular(40)),
                              color: Colors.white),
                          child: Padding(
                            padding: EdgeInsets.only(top: 27, left: 5, right: 5),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(40),
                                      topRight: Radius.circular(40)),
                                  color: Colors.white),
                              child: Container(
                                height: 700,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                          onLongPress: () {
                                            print('long press');
                                            _showMyDialog(context);
                                          },
                                          onTap: () {
                                            print('emad selected');
                                            Navigator.push(
                                              context,
                                              PageTransition(
                                                type:
                                                PageTransitionType.rightToLeft,
                                                child: form_client(),
                                              ),
                                            );
                                          },
                                          child: custom_data("Title", "No_title")),
                                      cust_divider(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ));
  }
  Future<void> txt_dialog_form(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
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
                cust_txtformfield_dialog("عدد الانواع", TextInputType.number,notypeController )
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
                                  .push(new MaterialPageRoute(builder: (context) => Client_Select()));
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
                print(cilentNameController);
                // Fluttertoast.showToast(msg: "message");
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
          ],
        );
      },
    );
  }
  /*displayToastMessage (String message , BuildContext context){
    Fluttertoast.showToast(msg: message);
  }*/
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
        title: Text(Title,textAlign: TextAlign.right,),
        subtitle: Padding(
          padding: const EdgeInsets.only(right:18.0),
          child: Text(No_title,textAlign: TextAlign.right,),
        ),
        leading: Image.asset("images/ic_keyboard_arrow_left_48px.png"),
      ),
    );
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
                        type: PageTransitionType.fade, child: edit_screen()));
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
                            onPressed: () {},
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
                            onPressed: () {},
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
