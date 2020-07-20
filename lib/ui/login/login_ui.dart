import 'package:MilletFlutterApp/constant/app_colors.dart';
import 'package:MilletFlutterApp/constant/app_images.dart';
import 'package:MilletFlutterApp/net/http_manager.dart';
import 'package:MilletFlutterApp/ui/login/login_vm.dart';
import 'package:MilletFlutterApp/util/screen_util.dart';
import 'package:MilletFlutterApp/widget/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginUi extends StatefulWidget {
  @override
  _LoginUiState createState() => _LoginUiState();
}

class _LoginUiState extends State<LoginUi> {
  TextEditingController _nameController;
  TextEditingController _passController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _passController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginVModel>(
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: AppColors.color_FFFFFF,
          body: Container(
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: Screen.h(400)),
                  alignment: Alignment.center,
                  child: GestureDetector(
                    child: Image.asset(
                      AppImages.login_top_logo,
                      width: Screen.w(220),
                      height: Screen.w(220),
                    ),
                    onTap: () {},
                  ),
                ),
                SizeSpace(height: 100),

                /// 输入框
                /// 用户名
                Container(
                  height: Screen.h(120),
                  margin:
                      EdgeInsets.only(left: Screen.w(45), right: Screen.w(45)),
                  decoration: BoxDecoration(
                      color: AppColors.color_F8F7FC,
                      borderRadius: BorderRadius.circular(63)),
                  child: TextFormField(
                    validator: (value) {
                      return value.length > 6 ? "用户名长度不能超过6位" : null;
                    },
                    autovalidate: true,
                    controller: _nameController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: Screen.w(45)),
                        border: InputBorder.none,
                        hintText: "请输入用户名",
                        hintStyle: TextStyle(
                            fontSize: Screen.sp(43),
                            color: AppColors.color_CCCCCC)),
                    keyboardType: TextInputType.text,
                  ),
                ),
                SizeSpace(height: 20),

                /// 密码
                Container(
                  height: Screen.h(120),
                  margin:
                      EdgeInsets.only(left: Screen.w(45), right: Screen.w(45)),
                  decoration: BoxDecoration(
                      color: AppColors.color_F8F7FC,
                      borderRadius: BorderRadius.circular(63)),
                  child: TextFormField(
                    validator: (value) {
                      return value.length > 6 ? "密码长度不能超过6位" : null;
                    },
                    autovalidate: true,
                    controller: _passController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: Screen.w(45)),
                        border: InputBorder.none,
                        hintText: "请输入密码",
                        hintStyle: TextStyle(
                            fontSize: Screen.sp(43),
                            color: AppColors.color_CCCCCC)),
                    keyboardType: TextInputType.text,
                  ),
                ),
                SizeSpace(height: 120),
                GestureDetector(
                  child: Container(
                    margin: EdgeInsets.all(Screen.w(45)),
                    alignment: Alignment.center,
                    width: Screen.w(),
                    height: Screen.h(120),
                    child: TextAndStyle("${model.string??"立即登录"}", AppColors.color_333333, 40),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(63.0),
                        gradient: LinearGradient(colors: [
                          AppColors.color_FD4A1C,
                          AppColors.color_FF9A85
                        ])),
                  ),
                  onTap: () {
                    model.login(_nameController.text, _passController.text);
                  },
                )
              ],
            )),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passController.dispose();
    super.dispose();
  }
}
