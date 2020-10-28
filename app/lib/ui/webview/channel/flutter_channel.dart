/*
 * @Description: 
 * @Author: CoolSnow (coolsnow2020@gmail.com)
 * @Date: 2020-09-11 11:23:31
 * @LastEditors: CoolSnow
 * @LastEditTime: 2020-09-11 11:40:19
 */
import 'package:flutter/cupertino.dart';
import 'package:video_getter/util/log_util.dart';
import 'package:webview_flutter/webview_flutter.dart';

///
/// Usage:
///
/// in .js files:
///
/// FlutterChannel.postMessage('hello');
///
class FlutterChannel {
  static const name = "FlutterChannel";
  JavascriptChannel channel(BuildContext context) {
    return JavascriptChannel(
        name: name,
        onMessageReceived: (JavascriptMessage message) {
          String msg = message.message;
          logUtil.d('onMessageReceived $msg');
        });
  }
}
