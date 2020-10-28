/*
 * @Description: 
 * @Author: CoolSnow (coolsnow2020@gmail.com)
 * @Date: 2020-09-11 16:02:44
 * @LastEditors: CoolSnow
 * @LastEditTime: 2020-09-16 17:46:35
 */
import 'package:flutter/material.dart';

class Tab2 extends StatefulWidget {
  createState() => _Tab2State();
}

class _Tab2State extends State<Tab2> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;
  static const double imgSize = 180;
  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    CurvedAnimation curvedAnimation =
        CurvedAnimation(parent: animationController, curve: Curves.bounceOut);
    animation = Tween(begin: 80.0, end: imgSize).animate(curvedAnimation);
    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transition(
        child: Center(
          child: GestureDetector(
              child: Image(
                  image: AssetImage('assets/images/avatar.jpg'),
                  width: imgSize,
                  height: imgSize),
              onTap: () {
                switch (animationController.status) {
                  case AnimationStatus.completed:
                    animationController.reverse();
                    break;
                  default:
                    animationController.forward();
                    break;
                }
              }),
        ),
        animation: animation);
  }
}

class Transition extends StatelessWidget {
  Transition({this.child, this.animation});

  final Widget child;
  final Animation<double> animation;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget child) {
            return Container(
                height: animation.value, width: animation.value, child: child);
          },
          child: child),
    );
  }
}
