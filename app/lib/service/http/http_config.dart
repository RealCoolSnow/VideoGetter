/*
 * @Description: 
 * @Author: CoolSnow (coolsnow2020@gmail.com)
 * @Date: 2020-09-09 18:22:17
 * @LastEditors: CoolSnow
 * @LastEditTime: 2020-09-10 11:58:20
 */
import 'dart:io';

class HttpConfig {
  static const String baseUrl = "https://app.joy666.cn/api";
  static final ContentType contentType = ContentType.json;
  static const connectTimeout = 30000;
  static const receiveTimeout = 30000;
}
