import 'package:elnahwy_tex/ui/screens/client_select/client_select.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
class form_client extends StatelessWidget {
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
                        child: Client_Select(),
                      ),
                    );
                  },
                ),
                Spacer(
                  flex: 1,
                ),
                Text(
                  "بيانات العميل",
                  style:
                  TextStyle(fontFamily: "Cairo", fontWeight: FontWeight.bold),
                )
              ],
            )),
        body: SafeArea(
          child: Container(
            alignment: Alignment.topCenter,
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
            child:Column(
              children: <Widget>[
                cust_txtformfield("اسم العميل"),
                cust_txtformfield(""),
                cust_txtformfield("اسم العميل")
              ],
            )
            )
          ),

    );
  }
  Widget cust_txtformfield(String title){
    return Padding(
      padding: EdgeInsets.all(8),
      child:  TextFormField(
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          fillColor: Colors.white.withOpacity(0.54),
          hintText: title,
          hintStyle: TextStyle(
              fontFamily: "Cairo",
              fontSize: 18
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:BorderSide(
              color: Color(0xff659B91),
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide:BorderSide(
              color: Color(0xffC3FCF2),
              width: 2,
            ),
          ),
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(15),
          //   borderSide:BorderSide(
          //     color: Colors.red,
          //     width: 2,
          //   ),
          // ),
          contentPadding: EdgeInsets.all(10),
        ),
      ),
    );
  }
}
