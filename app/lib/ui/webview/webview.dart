/*
 * @Description: 
 * @Author: CoolSnow (coolsnow2020@gmail.com)
 * @Date: 2020-09-10 18:00:00
 * @LastEditors: CoolSnow
 * @LastEditTime: 2020-09-11 16:57:10
 */
import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quick_start/locale/i18n.dart';
import 'package:flutter_quick_start/ui/webview/channel/flutter_channel.dart';
import 'package:flutter_quick_start/util/clipboard_util.dart';
import 'package:flutter_quick_start/util/log_util.dart';
import 'package:flutter_quick_start/util/toast_util.dart';
import 'package:webview_flutter/webview_flutter.dart';

///
/// webview page
///
///
class WebViewPage extends StatefulWidget {
  final String url;
  final String title;
  WebViewPage({@required this.url, this.title = ""});
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  String url;
  String title = "";

  /// load html from local Assets
  bool isLocal = false;
  bool isLoading = true;
  bool canGoback = false;

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  FlutterChannel flutterChannel = FlutterChannel();

  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(_backInterceptor);
    url = Uri.decodeComponent(widget.url);
    title = widget.title;
    isLocal = url.startsWith("asset");
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(_backInterceptor);
    super.dispose();
  }

  bool _backInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    _onBack();
    return true;
  }

  _loadHtmlFromAssets() async {
    WebViewController controller = await _controller.future;
    String fileHtmlContents = await rootBundle.loadString(url);
    controller.loadUrl(Uri.dataFromString(fileHtmlContents,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }

  _onPageStarted() {
    setState(() {
      isLoading = true;
    });
  }

  _onPageFinished() async {
    setState(() {
      isLoading = false;
    });
    WebViewController controller = await _controller.future;
    var _canGoback = await controller.canGoBack();
    setState(() {
      canGoback = _canGoback;
    });
    if (title.isEmpty) {
      var _title = await controller.getTitle();
      setState(() {
        title = _title;
      });
    }
  }

  _progressIndicator() {
    return Center(
        child: isLoading
            ? Container(
                color: Colors.transparent,
                width: 24.0,
                height: 24.0,
                child: CircularProgressIndicator(
                    backgroundColor: Colors.white70, strokeWidth: 2.4))
            : IconButton(
                iconSize: canGoback ? 24.0 : 0,
                icon: new Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ));
  }

  _onBack() async {
    if (canGoback) {
      WebViewController controller = await _controller.future;
      controller.goBack();
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: _onBack,
          ),
          title: Text(title),
          actions: [_progressIndicator(), WebViewMenu(_controller.future)],
        ),
        body: WebView(
          initialUrl: isLocal ? "" : url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
            if (isLocal) {
              _loadHtmlFromAssets();
            }
          },
          javascriptChannels: <JavascriptChannel>[
            flutterChannel.channel(context),
          ].toSet(),
          navigationDelegate: (NavigationRequest request) {
            // if (request.url.startsWith('https://www.youtube.com/')) {
            //   print('blocking navigation to $request}');
            //   return NavigationDecision.prevent;
            // }
            logUtil.i2('allowing navigation to $request');
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            logUtil.i2('Page started loading: $url');
            _onPageStarted();
          },
          onPageFinished: (String url) {
            logUtil.i2('Page finished loading: $url');
            _onPageFinished();
          },
          gestureNavigationEnabled: true,
        ));
  }
}

enum MenuOptions { refresh, copyLink }

class WebViewMenu extends StatelessWidget {
  final Future<WebViewController> controller;

  WebViewMenu(this.controller);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: controller,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> controller) {
        return PopupMenuButton<MenuOptions>(
          onSelected: (MenuOptions value) {
            switch (value) {
              case MenuOptions.refresh:
                _onRefresh(controller.data, context);
                break;
              case MenuOptions.copyLink:
                _onCopyLink(controller.data, context);
                break;
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuItem<MenuOptions>>[
            PopupMenuItem<MenuOptions>(
              value: MenuOptions.refresh,
              child: Text(I18n.of(context).text('refresh')),
            ),
            PopupMenuItem<MenuOptions>(
              value: MenuOptions.copyLink,
              child: Text(I18n.of(context).text('copy_link')),
            ),
          ],
        );
      },
    );
  }

  void _onRefresh(WebViewController controller, BuildContext context) {
    controller.reload();
  }

  void _onCopyLink(WebViewController controller, BuildContext context) async {
    String url = await controller.currentUrl();
    await ClipboardUtil.copy(url);
    ToastUtil.show(I18n.of(context).text('copied'));
  }
}
