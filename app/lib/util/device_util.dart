/*
 * @Description: 
 * @Author: CoolSnow (coolsnow2020@gmail.com)
 * @Date: 2020-09-09 18:39:18
 * @LastEditors: CoolSnow
 * @LastEditTime: 2020-09-10 11:57:32
 */
import 'dart:io';

import 'package:device_info/device_info.dart';

class DeviceUtil {
  ///
  static bool isMobile() {
    var ret = false;
    try {
      ret = Platform.isIOS || Platform.isAndroid;
    } catch (e) {
      ret = false;
    }
    return ret;
  }

  static String getName() {
    String ret = 'unknown';
    try {
      ret = Platform.operatingSystem;
    } catch (e) {
      print(e);
    }
    return ret;
  }

  static Future<String> getDeviceId() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if (isMobile()) {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidDeviceInfo =
            await deviceInfoPlugin.androidInfo;
        return Future.value(androidDeviceInfo.androidId);
      } else if (Platform.isIOS) {
        IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
        return Future.value(iosDeviceInfo.identifierForVendor);
      }
    }
    var now = DateTime.now();
    return Future.value(now.millisecondsSinceEpoch.toString());
  }

  static Future<String> getDeviceInfo() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if (isMobile()) {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidDeviceInfo =
            await deviceInfoPlugin.androidInfo;
        Map<String, dynamic> info = {
          'brand': androidDeviceInfo.brand,
          'manufacturer': androidDeviceInfo.manufacturer,
          'model': androidDeviceInfo.model,
          'product': androidDeviceInfo.product,
          'sdkInt': androidDeviceInfo.version.sdkInt
        };
        return Future.value(info.toString());
      } else if (Platform.isIOS) {
        IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
        Map<String, dynamic> info = {
          'systemName': iosDeviceInfo.systemName,
          'systemVersion': iosDeviceInfo.systemVersion,
          'model': iosDeviceInfo.model,
          'name': iosDeviceInfo.name,
          'utsname': iosDeviceInfo.utsname
        };
        return Future.value(info.toString());
      }
    }
    return Future.value("{}");
  }
}
