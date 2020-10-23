import 'package:MilletFlutterApp/vm/base_vmodel.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterVModel extends BaseVModel {

  @override
  void onDataReady() {

  }

  /// 注册
  register(BuildContext context, String name, String phone, String passWord, int sex) {
    if (TextUtil.isEmpty(name)) {
      Fluttertoast.showToast(msg: "请输入姓名");
      return;
    }
    if (TextUtil.isEmpty(phone)) {
      Fluttertoast.showToast(msg: "请输入手机号");
      return;
    }
    if (TextUtil.isEmpty(passWord)) {
      Fluttertoast.showToast(msg: "请输入密码");
      return;
    }
    apiService.registerUser(name, phone, passWord, sex).then((value) => {
      Navigator.pop(context)
    }).catchError((value) {
      Fluttertoast.showToast(msg: value);
    });
  }

}
