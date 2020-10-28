/*
 * @Description: 
 * @Author: CoolSnow (coolsnow2020@gmail.com)
 * @Date: 2020-09-11 16:01:48
 * @LastEditors: CoolSnow
 * @LastEditTime: 2020-09-17 19:05:39
 */
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:video_getter/config/config.dart';
import 'package:video_getter/config/pref_key.dart';
import 'package:video_getter/config/route/routes.dart';
import 'package:video_getter/service/http/http_util.dart';
import 'package:video_getter/storage/Pref.dart';
import 'package:video_getter/util/device_util.dart';
import 'package:video_getter/util/loading_util.dart';
import 'package:video_getter/util/log_util.dart';
import 'package:video_getter/util/permission_util.dart';
import 'package:video_getter/util/time_util.dart';
import 'package:video_getter/util/toast_util.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:permission_handler/permission_handler.dart';

class Tab1 extends StatefulWidget {
  _Tab1State createState() => _Tab1State();
}

class _Tab1State extends State<Tab1> {
  var _context;
  @override
  Widget build(BuildContext context) {
    _context = context;
    return FlutterEasyLoading(
        child: Container(
            child: Column(
      children: [
        RaisedButton(onPressed: _showToast, child: Text('Toast')),
        RaisedButton(onPressed: _showLoading, child: Text('Loading')),
        RaisedButton(
            onPressed: _showPreferences, child: Text('Shared Preferences')),
        RaisedButton(onPressed: _showDeviceInfo, child: Text('Device Info')),
        RaisedButton(onPressed: _showWebView, child: Text('WebView')),
        RaisedButton(
            onPressed: _permissionRequest, child: Text("Permission Request")),
        RaisedButton(onPressed: _httpTest, child: Text('Http Test')),
        _buildHero()
      ],
    )));
  }

  _buildHero() {
    return Container(
        child: GestureDetector(
            child: Hero(
                tag: "myhero",
                child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/avatar.jpg'),
                    radius: 30)),
            onTap: () {
              Config.router.navigateTo(context, Routes.about,
                  transition: TransitionType.fadeIn);
            }));
  }

  _showToast() {
    String now = TimeUtil.format(DateTime.now());
    logUtil.d(now);
    ToastUtil.show(now);
  }

  _showLoading() {
    LoadingUtil.show(context);
    Future.delayed(Duration(seconds: 2), () {
      LoadingUtil.dismiss();
    });
  }

  _showPreferences() {
    Pref.getString(PrefKey.launchTime).then((value) {
      String str = 'launch time: $value';
      ToastUtil.show(str);
    });
  }

  _showDeviceInfo() {
    DeviceUtil.getDeviceInfo().then((value) => ToastUtil.show(value));
  }

  _showWebView() {
    final url = Uri.encodeComponent(
        'https://github.com/RealCoolSnow/flutter_easy'); //Uri.encodeComponent('assets/test.html');
    const title = '';
    Config.router
        .navigateTo(_context, Routes.webview + "?url=$url&title=$title");
  }

  _permissionRequest() async {
    Map<Permission, PermissionStatus> result = await PermissionUtil.requestAll(
        [Permission.location, Permission.storage]);
    ToastUtil.show(
        'Permission.location: ' + result[Permission.location].toString());
    ToastUtil.show(
        'Permission.storage: ' + result[Permission.storage].toString());
  }

  _httpTest() {
    LoadingUtil.show(context);
    HttpUtil().get('/', getParams: {"user": "coolsnow"}).then((value) {
      LoadingUtil.dismiss();
      ToastUtil.show(value.toString());
    }).catchError((error) {
      LoadingUtil.dismiss();
      ToastUtil.show(error.msg);
    });
  }
}
