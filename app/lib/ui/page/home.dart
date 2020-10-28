/*
 * @Description: 
 * @Author: CoolSnow (coolsnow2020@gmail.com)
 * @Date: 2020-09-08 18:56:21
 * @LastEditors: CoolSnow
 * @LastEditTime: 2020-09-11 16:04:30
 */
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:video_getter/config/config.dart';
import 'package:video_getter/config/route/routes.dart';
import 'package:video_getter/locale/i18n.dart';
import 'package:video_getter/ui/page/home/tab1.dart';
import 'package:video_getter/ui/page/home/tab2.dart';
import 'package:video_getter/ui/page/home/tab3.dart';
import 'package:video_getter/ui/widget/smart_drawer.dart';
import 'package:video_getter/util/log_util.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: _buildAppBar(),
        drawer: _buildDrawer(),

        ///to disable slide slip
        ///drawerEdgeDragWidth: 0.0,
        body: _buildBody(),
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text(I18n.of(context).text('app_name')),
      actions: <Widget>[],
      bottom: _buildTabBar(),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      indicatorColor: Colors.white,
      tabs: <Widget>[
        Tab(icon: Icon(Icons.home)),
        Tab(icon: Icon(Icons.change_history)),
        Tab(icon: Icon(Icons.face)),
      ],
    );
  }

  Widget _buildDrawer() {
    return SmartDrawer(
      callback: (isOpened) => {logUtil.d('drawerCallback $isOpened')},
      widthPercent: 0.6,
      child: ListView(
        /// set padding for status bar color
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.pink,
            ),
            child: Center(
              child: SizedBox(
                width: 60,
                height: 60,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text('A',
                      style: TextStyle(color: Colors.purple, fontSize: 30)),
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text(I18n.of(context).text('about')),
            onTap: _showAbout,
          )
        ],
      ),
    );
  }

  Widget _buildBody() {
    return TabBarView(children: [Tab1(), Tab2(), Tab3()]);
  }

  void _handlerDrawerButton() {
    Scaffold.of(context).openDrawer();
  }

  void _closeDrawer() {
    Navigator.of(context).pop();
  }

  void _showAbout() {
    _closeDrawer();
    Config.router
        .navigateTo(context, Routes.about, transition: TransitionType.fadeIn);
  }
}
