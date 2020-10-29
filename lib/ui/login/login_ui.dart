import 'package:MilletFlutterApp/constant/app_colors.dart';
import 'package:MilletFlutterApp/ui/login/login_vm.dart';
import 'package:MilletFlutterApp/ui/register/register_ui.dart';
import 'package:MilletFlutterApp/util/navigator_util.dart';
import 'package:MilletFlutterApp/util/screen_util.dart';
import 'package:MilletFlutterApp/widget/common_widget.dart';
import 'package:MilletFlutterApp/widget/round_check_box.dart';
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

  /// 判断是否可以登录按钮
  _canClickButton(LoginVModel model) {
    if(_nameController.value.text.isNotEmpty && _passController.value.text.isNotEmpty && model.check) {
      model.canClickLogin = true;
    } else {
      model.canClickLogin = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginVModel>.value(
        value: LoginVModel(),
        child: Consumer<LoginVModel>(
          builder: (context, model, child) {
            return Scaffold(
              appBar: AppBar(shadowColor: Colors.transparent, backgroundColor: AppColors.color_FFFFFF, actions: [
                  GestureDetector(child: Container(child: Text("注册", style: TextStyle(color: AppColors.color_333333, fontSize: Screen.sp(46)),), alignment: Alignment.center, padding: EdgeInsets.only(right: Screen.w(45)),), onTap: () {
                    NavigatorUtil.push(context, RegisterUi());
                  },)
              ],),
              backgroundColor: AppColors.color_FFFFFF,
              body: Container(
                padding: EdgeInsets.only(top: Screen.h(115), left: Screen.w(86), right: Screen.w(86)),
                child: SingleChildScrollView(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("手机快捷登录", style: TextStyle(color: AppColors.color_333333, fontSize: Screen.sp(58)), textAlign: TextAlign.start,),
                    SizeDivider(height: Screen.h(15)),
                    Text("未注册过的手机号将自动创建账号", style: TextStyle(color: AppColors.color_999999, fontSize: Screen.sp(35)),),
                    SizeDivider(height: Screen.h(60)),
                    /// 输入框
                    /// 用户名
                    TextFormField(
                      validator: (value) {
                        return value.length > 11 ? "账号长度不能超过11位" : null;
                      },
                      onChanged: (value) {
                        _canClickButton(model);
                      },
                      autovalidate: true,
                      controller: _nameController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "请输入账号",
                          hintStyle: TextStyle(fontSize: Screen.sp(43), color: AppColors.color_bdbdbd)),
                      keyboardType: TextInputType.phone,
                    ),
                    SizeDivider(height: Screen.h(1), color: AppColors.color_e2e2e2,),
                    SizeDivider(height: Screen.h(60)),
                    /// 密码
                    TextFormField(
                      validator: (value) {
                        return value.length > 6 ? "密码长度不能超过6位" : null;
                      },
                      onChanged: (value) {
                        _canClickButton(model);
                      },
                      autovalidate: true,
                      controller: _passController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "请输入密码",
                          hintStyle: TextStyle(fontSize: Screen.sp(43), color: AppColors.color_bdbdbd)),
                      keyboardType: TextInputType.text,
                    ),
                    SizeDivider(height: Screen.h(1), color: AppColors.color_e2e2e2,),
                    SizeDivider(height: Screen.h(60)),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RoundCheckBox(value: model.check, onChanged: (value) {
                          model.check = value;
                          _canClickButton(model);
                        }),
                        SizeDivider(width: Screen.w(20)),
                        Expanded(child: Text("我已阅读并同意《蓝吧社区隐私政策》及《蓝吧社区用户服务协议》", style: TextStyle(color: AppColors.color_999999, fontSize: Screen.sp(35),)),),
                    ],),
                    SizeDivider(height: Screen.h(120)),

                    GestureDetector(
                      child: Opacity(
                        opacity: model.canClickLogin?1: 0.6,
                        child: Container(
                          alignment: Alignment.center,
                          width: Screen.w(),
                          height: Screen.h(130),
                          child: Text("立即登录", style: TextStyle(color: AppColors.color_FFFFFF, fontSize: Screen.sp(46)),),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14.0),
                              gradient: LinearGradient(colors: [
                                AppColors.color_4a73ff,
                                AppColors.color_4a73ff
                              ])),
                        ),
                      ),
                      onTap: () {
                        model.login(context, _nameController.text, _passController.text);
                      },
                    )
                  ],
                )),
              ),
            );
          },
        ));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passController.dispose();
    super.dispose();
  }
}
