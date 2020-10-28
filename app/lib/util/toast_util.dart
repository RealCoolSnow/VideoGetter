/*
 * @Description: 
 * @Author: CoolSnow (coolsnow2020@gmail.com)
 * @Date: 2020-09-09 16:21:58
 * @LastEditors: CoolSnow
 * @LastEditTime: 2020-09-10 11:57:42
 */
import 'package:fluttertoast/fluttertoast.dart';

///
/// Toast util
///
class ToastUtil {
  static void show(String msg) {
    Fluttertoast.showToast(msg: msg, toastLength: Toast.LENGTH_SHORT);
  }
}
