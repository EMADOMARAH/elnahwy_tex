
import 'package:elnahwy_tex/ui/screens/client_select/client_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class edit_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xff659B91),
          title: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.arrow_back,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type:
                      PageTransitionType.rightToLeft,
                      child: ClientPage(),
                    ),
                  );
                },
              ),
              Spacer(
                flex: 1,
              ),
              Text(
                "تعديل بيانات العميل",
                style:
                    TextStyle(fontFamily: "Cairo", fontWeight: FontWeight.bold),
              )
            ],
          )),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
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
        ),
      )
    );
  }
}
