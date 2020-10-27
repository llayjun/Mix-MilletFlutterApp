import 'package:MilletFlutterApp/constant/app_colors.dart';
import 'package:MilletFlutterApp/util/screen_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget headView(BuildContext context, String title) => AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: AppColors.color_333333,
          size: Screen.w(50),
        ),
        onPressed: () {Navigator.pop(context);},
      ),
      shadowColor: Colors.transparent,
      backgroundColor: AppColors.color_FFFFFF,
      title: Text(
        "$title",
        style: TextStyle(color: AppColors.color_333333, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
    );
