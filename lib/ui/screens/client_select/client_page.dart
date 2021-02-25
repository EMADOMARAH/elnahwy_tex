import 'package:elnahwy_tex/model/clientNameModel.dart';
import 'package:elnahwy_tex/ui/screens/Edit_screen/edit_Screen.dart';
import 'package:elnahwy_tex/ui/screens/client_data/client_data.dart';
import 'package:elnahwy_tex/model/clientNameModel.dart';
import 'package:elnahwy_tex/utils/database_helper.dart';
import 'package:elnahwy_tex/ui/screens/home_screen/home_screen.dart';
import 'package:elnahwy_tex/widget/cutom_data_tile_client.dart';
import 'package:elnahwy_tex/widget/divider_cutom.dart';
import 'package:elnahwy_tex/widget/txt_dialog_form.dart';
import 'package:flutter/material.dart';
import 'package:elnahwy_tex/widget/showDialog.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sqflite/sqflite.dart';


class ClientPage extends StatefulWidget {
  @override
  _ClientPageState createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  final initList = List<Widget>.generate(15, (i) => custom_data('wagdy', ''));
  TextEditingController editingController = TextEditingController();
  var showItemList = List<Widget>();

  @override
  void initState() {
    showItemList.addAll(initList);
    super.initState();
  }

  filterSearch(String query) {
    List<Widget> searchList = List<Widget>();
    searchList.addAll(initList);
    if (query.isNotEmpty) {
      List<Widget> resultListData = List<Widget>();
      searchList.forEach((item) {
        if (item == null) {
          resultListData.add(item);
        }
      });
      setState(() {
        showItemList.clear();
        showItemList.addAll(resultListData);
      });
      return;
    } else {
      setState(() {
        showItemList.clear();
        showItemList.addAll(initList);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          print("احا");
          txt_dialog_form(context);
        },
        icon: Icon(
          Icons.add,
          color: Colors.black,
          size: 30,
        ),
        label: Text(
          "إضافة",
          style:
              TextStyle(fontFamily: "Cairo", fontSize: 20, color: Colors.black),
        ),
        backgroundColor: Color(0xff6BD5E1),
      ),
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
        child: ListView(
          children: [
            Container(
              child: Padding(
                padding: EdgeInsets.all(14),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.leftToRight,
                                  child: Home_Screen(),
                                ),
                              );
                            }),
                        Flexible(
                          child: TextFormField(
                              onChanged: (value) {
                                filterSearch(value);
                              },
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
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 27, left: 5, right: 5),
                        child: SingleChildScrollView(
                          child: ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) {
                              return cust_divider();
                            },
                            shrinkWrap: true,
                            itemCount: showItemList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onLongPress: () {
                                    showMyDialog(context);
                                  },
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: client_data(),
                                      ),
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      custom_data("وجدى", '123'),
                                      cust_divider(),
                                      custom_data("wagdy", '15'),
                                      cust_divider(),
                                      custom_data("emad", ''),
                                      cust_divider(),
                                      custom_data("emad", ''),
                                      cust_divider(),
                                      custom_data("dabash", ''),
                                      cust_divider(),
                                      custom_data("Title", ''),
                                      cust_divider(),
                                    ],
                                  ));
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

