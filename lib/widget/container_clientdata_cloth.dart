import 'package:elnahwy_tex/widget/custom_Text_in_all.dart';
import 'package:elnahwy_tex/widget/textformfieldclothdata.dart';
import 'package:flutter/material.dart';

Widget Container_client_cloth (TextEditingController  clothName,
TextEditingController clothtype,
TextEditingController clothtupenumber,
TextEditingController clothNote){

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
            textformcloth(clothName.toString()),
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

