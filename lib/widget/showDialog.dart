import 'package:elnahwy_tex/model/clientNameModel.dart';
import 'package:elnahwy_tex/ui/screens/Edit_screen/edit_Screen.dart';
import 'package:elnahwy_tex/ui/screens/client_select/client_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

Future<void> showMyDialog(BuildContext context) async {
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
                      type: PageTransitionType.fade, child: edit_screen(new ClientNames() )));
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
                          onPressed: () async {
                            //هيرجع للصفحه اللى وراه
                            //Navigator.of(context, rootNavigator: false).pop();
                            Navigator.pop(context);
                            await Navigator.of(context).push(
                                new MaterialPageRoute(
                                    builder: (context) => ClientPage()));
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