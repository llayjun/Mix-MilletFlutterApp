import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 屏幕尺寸适配器
class Screen {
  /// 初始化屏幕适配器
  ///
  /// baseWidth：设计图宽度px
  /// baseHeight： 设计图高度px
  static void init(BuildContext context,
      [double baseWidth = 1080, double baseHeight = 1921]) {
    // 设置设计稿尺寸
    ScreenUtil.instance = ScreenUtil(width: baseWidth, height: baseHeight)
      ..init(context);
  }

  /// 根据屏幕宽度适配
  /// 不给参数，则返回原始屏幕宽度
  static double w([double width]) {
    if (width == null) {
      return ScreenUtil.screenWidth;
    }

    return ScreenUtil.getInstance().setWidth(width);
  }

  /// 根据屏幕高度适配
  static double h([double height]) {
    if (height == null) {
      return ScreenUtil.screenHeight;
    }

    return ScreenUtil.getInstance().setHeight(height);
  }

  /// 设置字体大小
  static double sp(double fontSize) {
    return ScreenUtil.getInstance().setSp(fontSize);
  }
}
