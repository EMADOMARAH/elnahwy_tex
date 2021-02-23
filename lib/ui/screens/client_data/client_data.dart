import 'package:elnahwy_tex/ui/screens/client_select/client_page.dart';
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
  Widget cust_label (String ltext){
    return Padding(
      padding: const EdgeInsets.only(right :20.0),
      child: Text(ltext,style: TextStyle(
        fontFamily: "Cairo",fontSize: 15,color: Colors.black,
      ),),
    );

  }
  Widget cust_txtformfield(String title, var typeinput) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8,right: 8,left: 8),
      child: TextFormField(
        readOnly: true,
        keyboardType: typeinput,
        cursorColor: Colors.black,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          fillColor: Colors.white.withOpacity(0.2),
          filled: true,
          hintText: title,
          hintStyle: TextStyle(
              fontFamily: "Cairo",
              fontSize: 18,
              color: Colors.black.withOpacity(0.7)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Color(0xff659B91),
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Color(0xffC3FCF2),
              width: 2,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.red,
              width: 2,
            ),
          ),
          contentPadding: EdgeInsets.all(10),
        ),
      ),
    );
  }
}
