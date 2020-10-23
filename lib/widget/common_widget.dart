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
