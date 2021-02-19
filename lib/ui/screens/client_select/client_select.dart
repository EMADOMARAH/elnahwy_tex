import 'package:flutter/material.dart';

class Client_Select extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          icon: Icon(
            Icons.add,
            color: Colors.black,
            size: 30,
          ),
          label: Text(
            "إضافة",
            style: TextStyle(
                fontFamily: "Cairo", fontSize: 20, color: Colors.black),
          ),
          backgroundColor: Color(0xff6BD5E1),
        ),
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
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Flexible(
                            child: TextFormField(
                                keyboardType: TextInputType.text,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.only(
                                          left: 10, top: 10, bottom: 10),
                                      child: Image.asset(
                                        'images/Search.png',
                                        width: 10,
                                        height: 10,
                                      ),
                                    ),
                                    fillColor: Colors.white.withOpacity(0.54),
                                    filled: true,
                                    hintText: 'بحــث',
                                    focusColor: Colors.white,
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontFamily: "Cairo",
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    contentPadding: EdgeInsets.all(10))),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Image(
                            image: AssetImage('images/Client.png'),
                            height: 66,
                            width: 66,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        height: 1000,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40)),
                            color: Colors.white),
                        child: Padding(
                          padding:
                              EdgeInsets.only(top: 27, left: 5, right: 5),
                          child: Container(
                              width: double.infinity,
                              height: 1000,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(40),
                                      topRight: Radius.circular(40)),
                                  color: Colors.white),
                              child: ListView(
                                padding: EdgeInsets.symmetric(horizontal: 1),
                                children: <Widget>[
                                  Container(
                                    color: Colors.grey[400],
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Image.asset(
                                            "images/ic_keyboard_arrow_left_48px.png",height: 48,width: 48,),
                                        Spacer(flex: 1),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: <Widget>[
                                            Padding(padding: EdgeInsets.only(right: 15),child: Text(
                                              "عماد عمارة",
                                              style: TextStyle(
                                                fontFamily: "Cairo",
                                                fontSize: 17,
                                              ),
                                            ),),
                                            Padding(padding: EdgeInsets.only(right: 30),
                                            child:Text("عدد الاصناف : 15",style: TextStyle(
                                              fontFamily: "Cairo",fontSize: 14
                                            ),),)
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.black38,
                                    thickness: 2,
                                  ),
                                  Container(
                                    color: Colors.grey[400],
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Image.asset(
                                          "images/ic_keyboard_arrow_left_48px.png",height: 48,width: 48,),
                                        Spacer(flex: 1),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: <Widget>[
                                            Padding(padding: EdgeInsets.only(right: 15),child: Text(
                                              "عماد عمارة",
                                              style: TextStyle(
                                                fontFamily: "Cairo",
                                                fontSize: 17,
                                              ),
                                            ),),
                                            Padding(padding: EdgeInsets.only(right: 30),
                                              child:Text("عدد الاصناف : 15",style: TextStyle(
                                                  fontFamily: "Cairo",fontSize: 14
                                              ),),)
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ));
  }
}
