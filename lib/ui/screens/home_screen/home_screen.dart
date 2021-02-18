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
                SizedBox(height: 100,),
                GestureDetector(
                  onTap: (){},
                  child: CustomContainer('المصنع', 'images/Factory.png', Colors.white),
                ),
                SizedBox(height: 50,),
                GestureDetector(
                  onTap: (){},
                  child: CustomContainer('لا تيكس', 'images/LeTex.png', Colors.white),
                ),
                SizedBox(height: 50,),
                GestureDetector(
                  onTap: (){},
                  child: CustomContainer('العملاء', 'images/Client.png', Colors.white),
                ),
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
            padding: const EdgeInsets.all(12.0),
            child: Image.asset(image,height: 80,width: 80,),
          ),
          SizedBox(height: 15,),
          Text(title,style: TextStyle(fontSize: 18,color: Colors.black,fontFamily:"Cairo" ),),
        ],
      ),
    );
  }
}
