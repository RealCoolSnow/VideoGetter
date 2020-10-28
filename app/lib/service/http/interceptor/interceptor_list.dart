/*
 * @Description: 
 * @Author: CoolSnow (coolsnow2020@gmail.com)
 * @Date: 2020-09-09 18:28:03
 * @LastEditors: CoolSnow
 * @LastEditTime: 2020-09-10 14:24:51
 */
import 'package:dio/dio.dart';
import 'package:video_getter/config/config.dart';
import 'package:video_getter/util/log_util.dart';

class HeaderInterceptor extends Interceptor {
  @override
  Future onRequest(RequestOptions options) {
    options.headers.addAll({"app": Config.app});
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    if (Config.debug) {
      logUtil.d('onResponse: ' + response.data.toString());
    }
    return super.onResponse(response);
  }
}

class ErrorInterceptor extends Interceptor {
  @override
  Future onError(DioError err) {
    if (Config.debug) {
      logUtil.d(err.toString());
    }
    return super.onError(err);
  }
}
