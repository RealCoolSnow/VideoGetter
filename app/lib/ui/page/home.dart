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
import 'package:video_getter/locale/i18n.dart';
import 'package:video_getter/service/http/http_util.dart';
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
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                TextField(
                    controller: _inputController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3)),
                        hintText: I18n.of(context).text("input_url_tip"))),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    verticalDirection: VerticalDirection.down,
                    children: <Widget>[
                      RaisedButton(
                          onPressed: _paste,
                          child: Text(I18n.of(context).text("paste"))),
                      RaisedButton(
                          onPressed: _download,
                          child: Text(I18n.of(context).text("download")))
                    ]),
              ],
            )));
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
        ToastUtil.show(value.toString());
      }).catchError((error) {
        LoadingUtil.dismiss();
        ToastUtil.show(error.msg);
      });
    }
  }
}
