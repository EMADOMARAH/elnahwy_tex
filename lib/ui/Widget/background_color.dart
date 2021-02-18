import 'package:flutter/material.dart';
class Background_color extends StatelessWidget {
  @override
  Widget child ;
  Background_color ({Widget child});
  Widget build(BuildContext context) {
    return Container(
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
      child: child,
    );
  }
}
