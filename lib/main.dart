import 'package:elnahwy_tex/model/clientNameModel.dart';
import 'package:elnahwy_tex/ui/screens/Cateogry_item/cateogry_item.dart';
import 'package:elnahwy_tex/ui/screens/Edit_screen/edit_Screen.dart';
import 'package:elnahwy_tex/ui/screens/client_select/client_page.dart';
import 'package:elnahwy_tex/ui/screens/home_screen/home_screen.dart';
import 'package:elnahwy_tex/ui/screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Splash_Screen(),
    );
  }
}


