import 'package:MilletFlutterApp/net/http_manager.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginVModel with ChangeNotifier {
  String _string;

  String get string => _string;

  /// 登录
  login(String name, String pass) {
    if (TextUtil.isEmpty(name)) {
      Fluttertoast.showToast(msg: "请输入手机号手机号1211v122222222");
      return;
    }
    if (TextUtil.isEmpty(pass)) {
      Fluttertoast.showToast(msg: "请输入密码密码1211v12222222222");
      return;
    }
    HttpManager().get(
        url: "wxarticle/chapters/json",
        successCallback: (value) {
          Fluttertoast.showToast(msg: value.toString());
          _string = "获取接口成功";
          notifyListeners();
        },
        errorCallback: (value) {
          Fluttertoast.showToast(msg: value.message);
        },
        tag: "");
  }
}
