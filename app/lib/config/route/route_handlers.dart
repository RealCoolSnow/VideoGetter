/*
 * @Description: 
 * @Author: CoolSnow (coolsnow2020@gmail.com)
 * @Date: 2020-09-09 10:44:05
 * @LastEditors: CoolSnow
 * @LastEditTime: 2020-09-10 18:50:07
 */

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quick_start/ui/page/about.dart';
import 'package:flutter_quick_start/ui/page/home.dart';
import 'package:flutter_quick_start/ui/webview/webview.dart';

/// home
var homeHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return HomePage();
});

/// about
var aboutHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return AboutPage();
});

/// webview
var webviewHanlder = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String url = params["url"]?.first;
  String title = params["title"]?.first;
  return WebViewPage(url: url, title: title);
});
