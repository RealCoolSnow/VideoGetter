/*
 * @Description: 
 * @Author: CoolSnow (coolsnow2020@gmail.com)
 * @Date: 2020-09-09 10:47:39
 * @LastEditors: CoolSnow
 * @LastEditTime: 2020-09-17 19:05:01
 */
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:video_getter/config/route/route_handlers.dart';

/// Usage:
///
/// router.navigateTo(context, Routes.home, transition: TransitionType.fadeIn);
///
///
class Routes {
  static const String home = "/";
  static const String about = "/about";
  static const String webview = "/webview";
  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
    });
    router.define(home, handler: homeHandler);
    router.define(about, handler: aboutHandler);
    router.define(webview,
        handler: webviewHanlder, transitionType: TransitionType.fadeIn);
  }
}
