/*
 * @Description: 
 * @Author: CoolSnow (coolsnow2020@gmail.com)
 * @Date: 2020-09-08 18:56:21
 * @LastEditors: CoolSnow
 * @LastEditTime: 2020-09-11 16:04:30
 */
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:video_getter/config/config.dart';
import 'package:video_getter/config/route/routes.dart';
import 'package:video_getter/locale/i18n.dart';
import 'package:video_getter/service/http/http_util.dart';
import 'package:video_getter/ui/app_theme.dart';
import 'package:video_getter/util/loading_util.dart';
import 'package:video_getter/util/toast_util.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _inputController;
  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text(I18n.of(context).text('app_name')),
      actions: <Widget>[],
    );
  }

  Widget _buildBody() {
    return FlutterEasyLoading(
        child: Container(
            color: AppColor.nearlyWhite,
            padding: const EdgeInsets.all(15),
            child: SafeArea(
                child: Column(
              children: [
                _buildTextField(),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _buildButton(AppColor.accent,
                          I18n.of(context).text("paste"), _paste),
                      _buildButton(AppColor.primary,
                          I18n.of(context).text("download"), _download)
                    ]),
              ],
            ))));
  }

  Widget _buildButton(Color bg, String text, GestureTapCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Center(
        child: Container(
          width: 180,
          height: 48,
          decoration: BoxDecoration(
            color: bg,
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.withOpacity(0.6),
                  offset: const Offset(4, 4),
                  blurRadius: 8.0),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    text,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: AppFontSize.normal),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.withOpacity(0.8),
                offset: const Offset(4, 4),
                blurRadius: 8),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Container(
            padding: const EdgeInsets.all(4.0),
            constraints: const BoxConstraints(minHeight: 80, maxHeight: 160),
            color: AppColor.white,
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
              child: TextField(
                maxLines: null,
                controller: _inputController,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColor.dark_grey,
                ),
                cursorColor: Colors.blue,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: I18n.of(context).text("input_url_tip")),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _paste() {
    FlutterClipboard.paste().then((value) {
      setState(() {
        _inputController.text = value;
      });
    });
  }

  _download() {
    String url = _inputController.text.trim();
    if (!url.toLowerCase().startsWith("http")) {
      ToastUtil.show(I18n.of(context).text("error_url"));
    } else {
      LoadingUtil.show(context);
      HttpUtil().get('/parse', getParams: {"url": url}).then((value) {
        LoadingUtil.dismiss();
        ToastUtil.show(value['url']);
        final url = Uri.encodeComponent(value['url']);
        final title = '';
        Config.router
            .navigateTo(context, Routes.webview + "?url=$url&title=$title");
      }).catchError((error) {
        LoadingUtil.dismiss();
        ToastUtil.show(error.msg);
      });
    }
  }
}
