import 'package:elnahwy_tex/ui/screens/client_data/client_data.dart';
import 'package:elnahwy_tex/widget/cust_txtformfield_dialog.dart';
import 'package:elnahwy_tex/widget/textformfieldclothdata.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

Widget Container_client_cloth (
    BuildContext context,
    int id,
    String  clothName,
    String clothtype,
    String clothtupenumber,
    String clothNote){

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xffC3FCF2).withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
//اسم القماش
            Row(
              children: [
                IconButton(
                    icon: Icon(Icons.more_vert),
                    onPressed: () {
                      edit_delete_dialog_in_data(context , id);
                    }),
                Flexible(child: textformcloth(clothName.toString())),
              ],
            ),
            Row(children: <Widget>[
//عدد الامتار
              Flexible(child: textformcloth(clothtupenumber.toString())),
//نوع الشريط
              Flexible(child: textformcloth(clothtype.toString()))
            ],
            ),
            textformcloth(clothNote.toString())
          ],
        ),
      ),
    ),
  );
}
Future<void> edit_delete_dialog_in_data(BuildContext context , int id) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "حذف البيانات ",
            textAlign: TextAlign.right,
            style: TextStyle(
                fontFamily: "Cairo", fontWeight: FontWeight.bold, fontSize: 20),
          ),
          content: Text(
            "هل تريد حذف هذه البيانات",
            textAlign: TextAlign.right,
            style: TextStyle(
                fontFamily: "Cairo",
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.red),
          ),
          actions: <Widget>[
            //delete
            TextButton(
              child: Text(
                'حذف ',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "Cairo",
                    fontSize: 14,
                    color: Colors.red),
              ),
              onPressed: () {
                //Delete function
              },
            ),
            //edit
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
                addcliendata(context);
              },
            ),

          ],
        );
      });

}
Future<void> addcliendata(BuildContext context) {
  TextEditingController  clothname = TextEditingController();
  TextEditingController clothtype = TextEditingController();
  TextEditingController clothtupenumber = TextEditingController();
  TextEditingController clothNote = TextEditingController();
  return showDialog(
      context: context,
      builder: (BuildContext dialogcontext) {
        return AlertDialog(
          title: Text(
            "إضافه بيانات ",
            textAlign: TextAlign.right,
            style: TextStyle(
                fontFamily: "Cairo", fontWeight: FontWeight.bold, fontSize: 20),
          ),
          content: SingleChildScrollView(
            child: Column(children: <Widget>[
              cust_txtformfield_dialog("اسم القماش",TextInputType.text,clothname),
              cust_txtformfield_dialog("عدد الامتار",TextInputType.number,clothtupenumber),
              cust_txtformfield_dialog("نوع الشريط",TextInputType.text,clothtype),
              cust_txtformfield_dialog("ملاحظات",TextInputType.multiline,clothNote)

            ],),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'إالغاء ',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "Cairo",
                    fontSize: 14,
                    color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(dialogcontext).pop();
                },
            ),
            TextButton(
              child: Text(
                'حفظ (اضافه) ',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "Cairo",
                    fontSize: 14,
                    color: Colors.green),
              ),
              onPressed: () {
                //insert function
                print("Client Name : ${clothname.toString()}");
                print("Meters : ${clothtupenumber.toString()}");
                print("Type : ${clothtype.toString()}");
                print("Note : ${clothNote.toString()}");
                Navigator.of(dialogcontext).maybePop();
              },
            ),
          ],
        );
      });
}




