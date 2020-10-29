import 'package:MilletFlutterApp/ui/main/main_page.dart';
import 'package:MilletFlutterApp/util/navigator_util.dart';
import 'package:MilletFlutterApp/vm/base_vmodel.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginVModel extends BaseVModel {

  // 协议选中
  bool _check = false;

  bool get check => _check;

  set check(bool value) {
    _check = value;
    notifyListeners();
  }

  /// 是否可以点击登陆按钮
  bool _canClickLogin = false;

  bool get canClickLogin => _canClickLogin;

  set canClickLogin(bool value) {
    _canClickLogin = value;
    notifyListeners();
  }

  @override
  void onDataReady() {

  }

  /// 登录
  login(BuildContext context, String name, String pass) {
    if (TextUtil.isEmpty(name)) {
      Fluttertoast.showToast(msg: "请输入手机号手机号");
      return;
    }
    if (TextUtil.isEmpty(pass)) {
      Fluttertoast.showToast(msg: "请输入密码密码");
      return;
    }
    if (!_check) {
      Fluttertoast.showToast(msg: "请先同意服务");
      return;
    }
    apiService.login(name, pass).then((value) => {
      notifyListeners(),
      NavigatorUtil.pushReplacementNamed(context, "/home")
    }).catchError((value) {
      Fluttertoast.showToast(msg: value);
    });
  }

}
