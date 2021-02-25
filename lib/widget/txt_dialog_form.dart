import 'package:elnahwy_tex/ui/screens/client_select/client_page.dart';
import 'package:flutter/material.dart';

import 'cust_txtformfield_dialog.dart';
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
                cust_txtformfield_dialog(
                    "اسم العميل", TextInputType.text, cilentNameController),
                cust_txtformfield_dialog(
                    "عدد الانواع", TextInputType.number, notypeController)
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
                            await Navigator.of(context).push(
                                new MaterialPageRoute(
                                    builder: (context) => ClientPage()));
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
