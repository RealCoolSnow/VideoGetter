/*
 * @Description: 
 * @Author: CoolSnow (coolsnow2020@gmail.com)
 * @Date: 2020-09-09 10:21:50
 * @LastEditors: CoolSnow
 * @LastEditTime: 2020-09-16 18:37:21
 */
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_quick_start/locale/i18n.dart';

class AboutPage extends StatefulWidget {
  _AboutPageState createState() => new _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(I18n.of(context).text("about")),
        ),
        body: Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Hero(
              tag: 'myhero',
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/avatar.jpg'),
                radius: 120,
              )),
        ));
  }
}
