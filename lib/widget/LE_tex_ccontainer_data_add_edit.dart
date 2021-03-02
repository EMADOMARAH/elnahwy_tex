import 'package:elnahwy_tex/ui/move_to_last_screen.dart';
import 'package:elnahwy_tex/widget/cust_txtformfield_dialog.dart';
import 'package:elnahwy_tex/widget/textformfieldclothdata.dart';
import 'package:flutter/material.dart';
Widget le_tex_container(
    TextEditingController clientname,
    TextEditingController clothtype,
    TextEditingController clothtupenumber,
    TextEditingController clothNote,
    BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffC3FCF2).withGreen(120)),
        color: Color(0xffC3FCF2).withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                IconButton(
                    icon: Icon(Icons.more_vert),
                    onPressed: () {
                      edit_delete_dialog_in_data(context);
                    }),
                //اسم القماش
                Flexible(child: textformcloth(clientname.toString())),
              ],
            ),
            Row(
              children: <Widget>[
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

Future<void> edit_delete_dialog_in_data(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "حذف او تعديل البيانات ",
            textAlign: TextAlign.right,
            style: TextStyle(
                fontFamily: "Cairo", fontWeight: FontWeight.bold, fontSize: 20),
          ),
          content: Text(
            "هل تريد تعديل ام حذف هذه البيانات",
            textAlign: TextAlign.right,
            style: TextStyle(
                fontFamily: "Cairo",
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.red),
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
                editclothdata(context);
              },
            ),
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
          ],
        );
      });
}
Future<void> editclothdata(BuildContext context) {
  TextEditingController clientname = TextEditingController();
  TextEditingController clothtype = TextEditingController();
  TextEditingController clothtupenumber = TextEditingController();
  TextEditingController clothNote = TextEditingController();
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "إضافه بيانات ",
            textAlign: TextAlign.right,
            style: TextStyle(
                fontFamily: "Cairo", fontWeight: FontWeight.bold, fontSize: 20),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                cust_txtformfield_dialog(
                    "اسم العميل", TextInputType.text, clientname),
                cust_txtformfield_dialog(
                    "عدد الامتار", TextInputType.number, clothtupenumber),
                cust_txtformfield_dialog(
                    "نوع الشريط", TextInputType.text, clothtype),
                cust_txtformfield_dialog(
                    "ملاحظات", TextInputType.multiline, clothNote)
              ],
            ),
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
                Navigator.pop(context);
                moveToLastScreen(context);
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
                print("Client Name : ${clientname.toString()}");
                print("Meters : ${clothtupenumber.toString()}");
                print("Type : ${clothtype.toString()}");
                print("Note : ${clothNote.toString()}");
                Navigator.pop(context);
                moveToLastScreen(context);
              },
            ),
          ],
        );
      });
}

