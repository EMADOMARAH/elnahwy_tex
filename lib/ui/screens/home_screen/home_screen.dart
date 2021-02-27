import 'package:elnahwy_tex/ui/screens/client_select/client_page.dart';
import 'package:elnahwy_tex/ui/screens/Cateogry_item/cateogry_item.dart';
import 'package:elnahwy_tex/ui/screens/le_tex/main_LE_Tex.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Home_Screen extends StatelessWidget {

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
            child: Container(
              child: Column(
                children: [
                  Spacer(flex: 1,),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeftWithFade,
                          child:factory_select(),
                        ),
                      );
                    },
                    child: CustomContainer('المصنع', 'images/Factory.png', Colors.grey[100]),
                  ),
                  Spacer(flex: 1,),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeftWithFade,
                          child:LE_tex_home(),
                        ),
                      );
                    },
                    child: CustomContainer('لى تيكس', 'images/LeTex.png',Colors.grey[100]),
                  ),
                  Spacer(flex: 1,),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeftWithFade,
                          child:ClientPage(),
                        ),
                      );
                    },
                    child: CustomContainer('العملاء', 'images/Client.png',  Colors.orangeAccent.withOpacity(0.9)),
                  ),
                  Spacer(flex: 1,),
                ],
              ),
            ),
          ),
        ),
    );
  }
}


class CustomContainer extends StatelessWidget {
  final String title;
  final String image;
  final Color color;
  CustomContainer(this.title,this.image,this.color);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 7.0,
            spreadRadius: 1.0,
            offset: Offset(1.0, 0.0), // shadow direction: bottom right
          )
        ],
        color: color,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10,20,10,0),
            child: Image.asset(image,height: 80,width: 80,),
          ),
          Spacer(flex: 1,),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              title,style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontFamily:"Cairo",
              fontWeight: FontWeight.bold,
            ),),
          ),
        ],
      ),
    );
  }
}
