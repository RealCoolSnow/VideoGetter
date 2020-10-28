/*
 * @Description: 
 * @Author: CoolSnow (coolsnow2020@gmail.com)
 * @Date: 2020-09-14 10:32:11
 * @LastEditors: CoolSnow
 * @LastEditTime: 2020-09-14 11:00:01
 */
import 'package:flutter/material.dart';
import 'package:video_getter/locale/i18n.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

///
///
/// see - https://github.com/huangjianke/flutter_easyloading
/// Loading Util
///
///
class LoadingUtil {
  static show(
    BuildContext context,
  ) {
    EasyLoading.show(status: I18n.of(context).text("loading"));
  }

  static showMessage(String msg) {
    EasyLoading.show(status: msg);
  }

  /// show progress with [value] [status], value should be 0.0 ~ 1.0.
  static showProgress(double value, {String status}) {
    EasyLoading.showProgress(value, status: status);
  }

  static showSuccess(
    String status, {
    Duration duration,
  }) {
    EasyLoading.showSuccess(status, duration: duration);
  }

  static showError(
    String status, {
    Duration duration,
  }) {
    EasyLoading.showError(status, duration: duration);
  }

  static showInfo(
    String status, {
    Duration duration,
  }) {
    EasyLoading.showInfo(status, duration: duration);
  }

  static showToast(
    String status, {
    Duration duration,
  }) {
    EasyLoading.showToast(status, duration: duration);
  }

  static dismiss() {
    EasyLoading.dismiss();
  }
}
