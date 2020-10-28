/*
 * @Description: 
 * @Author: CoolSnow (coolsnow2020@gmail.com)
 * @Date: 2020-09-09 10:38:59
 * @LastEditors: CoolSnow
 * @LastEditTime: 2020-09-21 10:44:48
 */
import 'dart:ui';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quick_start/ui/app_theme.dart';
import 'package:flutter_quick_start/ui/page/home.dart';
import 'package:flutter_quick_start/ui/page/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quick_start/config/config.dart';
import 'package:flutter_quick_start/config/pref_key.dart';
import 'package:flutter_quick_start/config/route/routes.dart';
import 'package:flutter_quick_start/locale/i18n.dart';
import 'package:flutter_quick_start/locale/locale_util.dart';
import 'package:flutter_quick_start/storage/Pref.dart';
import 'package:flutter_quick_start/util/log_util.dart';
import 'package:flutter_quick_start/util/time_util.dart';

class App extends StatefulWidget {
  _AppState createState() => new _AppState();
}

class _AppState extends State<App> {
  _AppState() {
    //---router
    final router = FluroRouter();
    Routes.configureRoutes(router);
    Config.router = router;
    //---shared preferences
    Pref.setString(PrefKey.launchTime, TimeUtil.format(DateTime.now()));
    //---logutil
    logUtil.setEnabled(Config.debug);
    logUtil.d("App created");
  }
  @override
  Widget build(BuildContext context) {
    final app = MaterialApp(
      title: Config.app,
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: AppTheme.primary,
        splashColor: AppTheme.splash,
      ),
      localizationsDelegates: [
        const I18nDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: localeUtil.supportedLocales(),
      onGenerateRoute: Config.router.generator,
      home: _buildSplashScreen(),
    );
    return app;
  }

  _buildSplashScreen() {
    return SplashScreen(
        seconds: 3,
        navigateAfterSeconds: HomePage(),
        title: Text('flutter_easy',
            style: TextStyle(
                fontWeight: FontWeight.w700, fontSize: 20, color: Colors.pink)),
        imageBackground: AssetImage('assets/images/splash.jpg'),
        icon: AssetImage('assets/images/avatar.jpg'),
        backgroundColor: Colors.white,
        photoSize: 60.0,
        loaderColor: Colors.white);
  }
}
