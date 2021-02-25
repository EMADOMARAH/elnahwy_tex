import 'dart:ffi';

import 'package:flutter/material.dart';

Widget customText (String label,var fontweight,double size){
  return Text(
    label.toString(),style: TextStyle(
    fontFamily: "Cairo",fontWeight: fontweight,fontSize: size
  ),
  );
}