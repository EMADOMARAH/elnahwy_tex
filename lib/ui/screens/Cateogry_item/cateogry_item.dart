import 'package:elnahwy_tex/ui/screens/Cloth_type/clothtypeabout.dart';
import 'package:elnahwy_tex/ui/screens/home_screen/home_screen.dart';
import 'package:elnahwy_tex/widget/container_clientdata_cloth.dart';
import 'package:elnahwy_tex/widget/cutom_data_tile_client.dart';
import 'package:elnahwy_tex/widget/divider_cutom.dart';
import 'package:elnahwy_tex/widget/showDialogclient.dart';
import 'package:elnahwy_tex/widget/txt_dialog_form.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class factory_select extends StatefulWidget {
  @override
  _factory_selectState createState() => _factory_selectState();
}

class _factory_selectState extends State<factory_select> {
  TextEditingController cilentNameController = TextEditingController();

  TextEditingController notypeController = TextEditingController();
  TextEditingController editingController = TextEditingController();
  var showItemList = List<Widget>();

  Future<bool> popfunc() async {
    return true;
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            print("aaaa");
            txt_dialog_form(context);
          },
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
        body: WillPopScope(
          onWillPop: popfunc,
          child: Container(
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
                        //search , back arrow & icon ROW
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
                                  onChanged: (value) {},
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
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      contentPadding: EdgeInsets.all(10))),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Image(
                              image: AssetImage('images/Factory.png'),
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
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: 27, left: 5, right: 5),
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
                                          child: clothabout(),
                                        ),
                                      );
                                    },
                                    child: custom_data(
                                      "Title",
                                      "No_title",
                                      IconButton(
                                        icon: Icon(Icons.more_vert),
                                        onPressed: () {
                                          /*id = this
                                              .clientsNamesList[position]
                                              .cNId;
                                          name = this
                                              .clientsNamesList[position]
                                              .cNName
                                              .toString();
                                          this.customPosition = position;*/
                                          _showMyDialog(context, null,
                                              null, null);
                                        },
                                      ),
                                    ),
                                  );
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
        ));
  }
  Future<void> _showMyDialog(BuildContext context , int customPosition, int id , String name) async {
    print("Position : $customPosition   id : $id   name : $name");
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => true,
          child: AlertDialog(
            title: Text(
              'تعديل او حذف ',
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: "Cairo",
                  fontSize: 14),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    'هل تريد حذف او تعديل هذا العميل ',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "Cairo",
                        fontSize: 14),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              //زرار التعديل ف الدايلوج
              TextButton(
                child: Text(
                  'تعديل ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "Cairo",
                      fontSize: 14,
                      color: Colors.green),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          child: null ));/*edit_screen(ClientNames.withId(id, name)))).then((value) => updateListView());*/
                },
              ),
              TextButton(
                child: Text(
                  'حذف',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "Cairo",
                      fontSize: 14,
                      color: Colors.red),
                ),
                //Second Dialog
                onPressed: () {
                  showDialog<void>(
                      context: context,
                      barrierDismissible: true, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            'هل انت متاكد من حذف هذا العميل ',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "Cairo",
                                fontSize: 14),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text(
                                'تأكيد ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Cairo",
                                    fontSize: 14,
                                    color: Colors.green),
                              ),
                              onPressed: () {

                             /*   _delete(context,clientsNamesList[customPosition] );
                                //احذف عميل من الداتا بيز
                                Navigator.pop(context);
                                Navigator.pop(context);
                                updateListView();
                                //اعمل تحديث للداتا بعد الحذف*/
                              },
                            ),
                            TextButton(
                              child: Text(
                                'إلغاء ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Cairo",
                                    fontSize: 14,
                                    color: Colors.red),
                              ),
                              onPressed: () async {
                                //هيرجع للصفحه اللى وراه
                                //Navigator.of(context, rootNavigator: false).pop();
                                Navigator.pop(context);
                                /*await Navigator.of(context).push(
                                    new MaterialPageRoute(
                                        builder: (context) => ClientPage()));*/
                              },
                            ),
                          ],
                        );
                      });
                },
              ),
            ],
          ),
        );
      },
    );
  }

}
