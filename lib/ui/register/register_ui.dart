import 'package:MilletFlutterApp/constant/app_colors.dart';
import 'package:MilletFlutterApp/ui/login/login_vm.dart';
import 'package:MilletFlutterApp/ui/register/register_vm.dart';
import 'package:MilletFlutterApp/util/navigator_util.dart';
import 'package:MilletFlutterApp/util/screen_util.dart';
import 'package:MilletFlutterApp/widget/common_widget.dart';
import 'package:MilletFlutterApp/widget/head_view_widget.dart';
import 'package:MilletFlutterApp/widget/round_check_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterUi extends StatefulWidget {
  @override
  _RegisterUiState createState() => _RegisterUiState();
}

class _RegisterUiState extends State<RegisterUi> {
  TextEditingController _nameController;
  TextEditingController _phoneController;
  TextEditingController _passController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _passController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterVModel>.value(
        value: RegisterVModel(),
        child: Consumer<RegisterVModel>(
          builder: (context, model, child) {
            return Scaffold(
              appBar: headView(context, "注册账号"),
              backgroundColor: AppColors.color_FFFFFF,
              body: Container(
                padding: EdgeInsets.only(top: Screen.h(115), left: Screen.w(86), right: Screen.w(86)),
                child: SingleChildScrollView(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizeDivider(height: Screen.h(80)),
                    /// 输入框
                    /// 用户名
                    TextFormField(
                      validator: (value) {
                        return value.length > 8 ? "账号长度不能超过8位" : null;
                      },
                      autovalidate: true,
                      controller: _nameController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "请输入姓名",
                          hintStyle: TextStyle(fontSize: Screen.sp(43), color: AppColors.color_bdbdbd)),
                      keyboardType: TextInputType.text,
                    ),
                    SizeDivider(height: Screen.h(1), color: AppColors.color_e2e2e2,),
                    SizeDivider(height: Screen.h(60)),
                    /// 输入框
                    /// 手机号
                    TextFormField(
                      validator: (value) {
                        return value.length > 11 ? "手机号长度不能超过11位" : null;
                      },
                      autovalidate: true,
                      controller: _phoneController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "请输入手机号",
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
                      autovalidate: true,
                      controller: _passController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "请输入密码",
                          hintStyle: TextStyle(fontSize: Screen.sp(43), color: AppColors.color_bdbdbd)),
                      keyboardType: TextInputType.text,
                    ),
                    SizeDivider(height: Screen.h(1), color: AppColors.color_e2e2e2,),
                    SizeDivider(height: Screen.h(120)),

                    GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        width: Screen.w(),
                        height: Screen.h(130),
                        child: Text("注册", style: TextStyle(color: AppColors.color_FFFFFF, fontSize: Screen.sp(46)),),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14.0),
                            gradient: LinearGradient(colors: [
                              AppColors.color_4a73ff,
                              AppColors.color_4a73ff
                            ])),
                      ),
                      onTap: () {
                        model.register(context, _nameController.text, _phoneController.text, _passController.text, 0);
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
    _phoneController.dispose();
    _passController.dispose();
    super.dispose();
  }
}
