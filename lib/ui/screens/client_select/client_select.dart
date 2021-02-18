import 'package:flutter/material.dart';

class Client_Select extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body :SafeArea(
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
              child: Column(
                children: <Widget>[
                  Flexible(child: TextField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: 'Search',
                          prefixStyle: TextStyle(color: Color(0xff078547)),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: new BorderSide(color: Color(0xff078547))),
                          contentPadding: EdgeInsets.all(10)
                      )
                  ),),
                  SizedBox(width: 10,),
                  Image(image: AssetImage("images/Search.png"))
                ],
              )
          ),
        )
    );
  }
}
