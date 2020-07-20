import 'package:MilletFlutterApp/constant/app_colors.dart';
import 'package:MilletFlutterApp/constant/app_images.dart';
import 'package:MilletFlutterApp/net/http_manager.dart';
import 'package:MilletFlutterApp/util/screen_util.dart';
import 'package:flutter/material.dart';

class LoginUi extends StatefulWidget {
  @override
  _LoginUiState createState() => _LoginUiState();
}

class _LoginUiState extends State<LoginUi> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.color_ffffff,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              InkWell(child:
              Image.asset(
                AppImages.login_top_logo,
                width: Screen.w(220),
                height: Screen.w(220),
              ),
              onTap: () {
                HttpManager().get(url: "wxarticle/chapters/json", tag: "");
              },)
            ],
          )
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

}
