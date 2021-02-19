import 'dart:async';

import 'package:elnahwy_tex/ui/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class Splash_Screen extends StatefulWidget {
  @override
  _Splash_ScreenState createState() => _Splash_ScreenState();


}

class _Splash_ScreenState extends State<Splash_Screen> {
  //set timer to screen
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
            () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home_Screen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        ),
        child: Center(
          child: Image(
            width: 300,
              height: 300,
              image: AssetImage(
                'images/giphy.gif',
              ),
              fit: BoxFit.fitWidth),
        ),
      ),
    );
  }
}
