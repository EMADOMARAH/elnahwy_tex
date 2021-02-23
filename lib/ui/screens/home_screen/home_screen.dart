import 'package:elnahwy_tex/ui/screens/client_select/client_page.dart';
import 'package:elnahwy_tex/ui/screens/Cateogry_item/cateogry_item.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Home_Screen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff659B91),
        body: Center(
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
                        child:category_item(),
                      ),
                    );
                  },
                  child: CustomContainer('المصنع', 'images/Factory.png', Colors.white),
                ),
                Spacer(flex: 1,),
                GestureDetector(
                  onTap: (){},
                  child: CustomContainer('لى تيكس', 'images/LeTex.png', Colors.white),
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
                  child: CustomContainer('العملاء', 'images/Client.png', Colors.white),
                ),
                Spacer(flex: 1,),
              ],
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
        color: color,
        borderRadius: BorderRadius.circular(5),
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
