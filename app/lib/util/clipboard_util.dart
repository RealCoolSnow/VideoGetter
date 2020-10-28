/*
 * @Description: 
 * @Author: CoolSnow (coolsnow2020@gmail.com)
 * @Date: 2020-09-11 13:52:43
 * @LastEditors: CoolSnow
 * @LastEditTime: 2020-09-11 14:54:05
 */
import 'package:flutter/services.dart';

///
/// Clipboard Util
///
///
class ClipboardUtil {
  static Future<void> copy(String text) {
    return Clipboard.setData(ClipboardData(text: text));
  }

  static Future<ClipboardData> paste() {
    return Clipboard.getData("text/plain");
  }
}
