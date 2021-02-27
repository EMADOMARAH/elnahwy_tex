import 'package:flutter/material.dart';
import 'package:elnahwy_tex/model/clientNameModel.dart';
import 'package:elnahwy_tex/ui/screens/client_select/client_page.dart';
import 'package:elnahwy_tex/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

class Add_Client extends StatefulWidget {
  @override
  _Add_ClientState createState() => _Add_ClientState();
}

class _Add_ClientState extends State<Add_Client> {
  DatabaseHelper helper = DatabaseHelper();
  ClientNames clientNames = new ClientNames("");

  TextEditingController clientNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //clientNameController.text = clientNames.cNName;

    return Scaffold(
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
                      type:
                      PageTransitionType.rightToLeft,
                      child: ClientPage(),
                    ),
                  );
                },
              ),
              Spacer(
                flex: 1,
              ),
              Text(
                "إضافه عميل جديد",
                style:
                TextStyle(fontFamily: "Cairo", fontWeight: FontWeight.bold),
              )
            ],
          )),
      body: SafeArea(
          child: Container(
              alignment: Alignment.topCenter,
              height: double.infinity,
              width: double.infinity,
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
                  children: <Widget>[
                    cust_txtformfield(clientNameController,"اسم العميل", TextInputType.text, false),
                    Spacer(
                      flex: 1,
                    ),
                    customcontainerforsave("إضافة عميل"),
                   /* Padding(
                      padding: const EdgeInsets.only(right: 15,left: 15,bottom: 30),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: RaisedButton(
                            color: Color(0xffC3FCF2),
                            child: Text(
                              'اضافه العميل',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Cairo",
                                  fontSize: 18,
                                  color: Colors.green),
                            ),
                            onPressed: () {
                              save();
                              // Navigator.push(
                              //   context,
                              //   PageTransition(
                              //     type:
                              //     PageTransitionType.leftToRight,
                              //     child: ClientPage(),
                              //   ),
                              // );
                            }),
                      ),
                    )*/
                  ],
                ),
              ))),
    );

  }

  Widget cust_txtformfield(TextEditingController textEditingController,String title, var typeinput, bool boolean) {
    return Padding(
      padding: EdgeInsets.only(right: 8,left: 8,top: 40),
      child: TextFormField(
        readOnly: boolean,
        autofocus: true,
        showCursor: true,
        keyboardType: typeinput,
        cursorColor: Colors.black,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          fillColor: Colors.white.withOpacity(0.4),
          filled: true,
          hintText: title,
          hintStyle: TextStyle(
              fontFamily: "Cairo",
              fontSize: 18,
              color: Colors.black.withOpacity(0.7)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Color(0xff659B91),
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Color(0xffC3FCF2),
              width: 2,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.red,
              width: 2,
            ),
          ),
          contentPadding: EdgeInsets.all(10),
        ),
        controller: textEditingController,
        onChanged: (value){
          clientNames.cNName = textEditingController.text;

        },
      ),
    );
  }
//Cutsom RaisdButton
  Widget customcontainerforsave(String title){
    return Padding(
      padding: const EdgeInsets.only(right: 15,left: 15,bottom: 30),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: RaisedButton(
          elevation: 10,
          splashColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: Colors.white.withOpacity(0.5),
            )
          ),
            color: Color(0xffC3FCF2),
            child: Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: "Cairo",
                  fontSize: 18,
                  color: Colors.green),
            ),
            onPressed: () {
              save();
            }),
      ),
    );
  }
  //save data to data base
  void save() async{

    moveToLastScreen();

    if (clientNames.cNName.length > 0 ) {
      int result; // to check the operation success
      result = await helper.insertClientName(clientNames);


      if (result !=0) {
        // Success
        _ShowAlertDialog('نجاح' , 'تم الحفظ بنجاح',Colors.green);
      }else{
        //Failure
        _ShowAlertDialog('فشل' , 'حدث خطأ اثناء الحفظ',Colors.amber);
      }

    } else{
      _ShowAlertDialog("خطأ", "اسم العميل فاضى!",Colors.red);
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
}
