import 'package:MilletFlutterApp/util/screen_util.dart';
import 'package:flutter/cupertino.dart';

/// 空白
Widget SizeSpace({double width = 0, double height = 0}) => SizedBox(width: width, height: height,);

/// TextAndStyle
Widget TextAndStyle(String data, Color color, double fontSize) => Text(data, style: TextStyle(color: color, fontSize: Screen.sp(fontSize)),);