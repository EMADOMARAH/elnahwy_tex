import 'package:elnahwy_tex/widget/textformfieldclothdata.dart';
import 'package:flutter/material.dart';

Widget factorycust_container(
    TextEditingController clothName,
    TextEditingController clothtype,
    TextEditingController clothtupenumber,
    TextEditingController clothNote,
    BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffC3FCF2).withGreen(120)),
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
                      edit_delete_dialog_in_data(context);
                    }),
                Flexible(child: textformcloth(clothName.toString())),
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
              },
            ),

          ],
        );
      });
}
