import 'package:MilletFlutterApp/constant/app_colors.dart';
import 'package:MilletFlutterApp/util/screen_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 空白
Widget SizeDivider({double width = 0, double height = 0, Color color = Colors.transparent}) {
  if (height > 0) {
    return Divider(
      height: height,
      color: color,
    );
  } else if (width > 0) {
    return VerticalDivider(
      width: width,
      color: color,
    );
  } else {
    return Divider(
      height: 0,
    );
  }
}

/// TextAndStyle
Widget TextAndStyle(String data, Color color, double fontSize) => Text(
      data,
      style: TextStyle(color: color, fontSize: Screen.sp(fontSize)),
    );

/// 圆角文字， fill
/// example TextFill()
Widget TextFill(String text, double fontSize, Color textColor, {double h = 0, double v = 0, double radius = 0, Color bg = AppColors.color_FFFFFF}) =>
    Container(
      padding: EdgeInsets.only(
          left: Screen.w(h),
          right: Screen.w(h),
          top: Screen.h(v),
          bottom: Screen.h(v)),
      alignment: Alignment.center,
      decoration: new BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: Screen.sp(fontSize), color: textColor),
      ),
    );