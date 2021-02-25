import 'package:elnahwy_tex/ui/screens/client_select/client_page.dart';
import 'package:elnahwy_tex/widget/cust_label.dart';
import 'package:elnahwy_tex/widget/cust_txtformfield.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class client_data extends StatelessWidget {
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
                      type: PageTransitionType.rightToLeft,
                      child: ClientPage(),
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
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    cust_label("اسم العميل"),
                    cust_txtformfield("اسم العميل", TextInputType.text),
                    cust_label("عدد انواع القماش"),
                    cust_txtformfield(
                        "عدد انواع القماش", TextInputType.number),
                    cust_txtformfield("", TextInputType.text),
                    Spacer(
                      flex: 1,
                    ),
                    Center(
                      child: RaisedButton(
                        color: Colors.white,
                        child: Text(
                          'رجوع',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: "Cairo",
                              fontSize: 18,
                              color: Colors.green),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type:
                              PageTransitionType.leftToRight,
                              child: ClientPage(),
                            ),
                          );
                        }),
                    )
                  ],
                ),
              ))),
    );
  }

}
