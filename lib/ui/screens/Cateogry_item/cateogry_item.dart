import 'package:flutter/material.dart';

class category_item extends StatelessWidget {
  TextEditingController cilentNameController = TextEditingController();
  TextEditingController notypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            print("aaaa");
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
        )));
  }
}

Future<void> txt_dialog_form(BuildContext context) async {
  TextEditingController cilentNameController = TextEditingController();
  TextEditingController notypeController = TextEditingController();
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
                                .push(new MaterialPageRoute(builder: (context) => category_item()));
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

