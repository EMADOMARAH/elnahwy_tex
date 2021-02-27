import 'package:elnahwy_tex/ui/screens/Cateogry_item/cateogry_item.dart';
import 'package:elnahwy_tex/ui/screens/client_select/client_page.dart';
import 'package:flutter/material.dart';
import 'package:elnahwy_tex/widget/cust_txtformfield_dialog.dart';
import 'cust_txtformfield_dialog.dart';
Future<void> txt_dialog_form(BuildContext context) async {
  TextEditingController cilentNameController = TextEditingController();
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'إضافه نوع قماش جديد',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontFamily: "Cairo", fontSize: 18),
        ),
        content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                cust_txtformfield_dialog(
                    "اسم القماش", TextInputType.text, cilentNameController),
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
                        'هل تريد إلغاء اضافه القماش ؟',
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
                                    builder: (context) => factory_select()));
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
                  color: Colors.white),
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
