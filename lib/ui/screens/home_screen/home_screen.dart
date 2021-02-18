import 'package:flutter/material.dart';

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
                  onTap: (){},
                  child: CustomContainer('المصنع', 'images/Factory.png', Colors.white),
                ),
                Spacer(flex: 1,),
                GestureDetector(
                  onTap: (){},
                  child: CustomContainer('لا تيكس', 'images/LeTex.png', Colors.white),
                ),
                Spacer(flex: 1,),
                GestureDetector(
                  onTap: (){},
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
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(image,height: 80,width: 80,),
          ),
          Spacer(flex: 1,),
          Text(title,style: TextStyle(fontSize: 19,color: Colors.black,fontFamily:"Cairo" ),),
        ],
      ),
    );
  }
}
