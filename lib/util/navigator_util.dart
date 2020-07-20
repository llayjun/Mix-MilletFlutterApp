import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NavigatorUtil {
  /// 跳转页面
  static push(BuildContext context, Widget page) async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => page));
    return result;
  }

  /// 带返回值的
  static Future getValuePush(BuildContext context, Widget page) {
    Completer completer = Completer();
    Navigator.push(context, MaterialPageRoute(builder: (context) => page))
        .then((value) {
      completer.complete(value);
    });
    return completer.future;
  }

  /// 跳转到指定界面，删除上面的
  static popUntil(BuildContext context, String name){
    Navigator.popUntil(context, ModalRoute.withName(name));
  }

  /// 跳转到指定界面，弹出中间部分
  static pushAndRemoveUtil(BuildContext context, Widget page){
    Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (_) => page), (route) => route == null);
  }

  /// 跳转到下个界面，pop自己
  static pushReplacement(BuildContext context, Widget page) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => page));
  }
}
