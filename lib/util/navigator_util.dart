import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NavigatorUtil {
  /// 跳转页面
  static push(BuildContext context, Widget page) async {
    final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => page));
    return result;
  }

  /// 跳转页面
  static pushNamed(BuildContext context, String routeName, {Object arguments,}){
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  /// 跳转并有返回值
  static Future<T> getValuePush<T extends Object>(BuildContext context, Widget page) {
    Completer<T> completer = Completer();
    Navigator.push<T>(context, MaterialPageRoute(builder: (context) => page)).then((value) {
      completer.complete(value);
    });
    return completer.future;
  }

  /// 跳转并有返回值，根据路由name
  static Future<T> getValuePushName<T extends Object>(BuildContext context, String newPage, {Object arguments,}) {
    Completer<T> completer = Completer();
    Navigator.pushNamed<T>(context, newPage, arguments: arguments).then((value) {
      completer.complete(value);
    });
    return completer.future;
  }

  /// 替代路由，pushReplacement和popAndPushNamed类似，有小差别
  /// pushReplacementNamed：当用户成功登录并且现在在 HomeScreen 上时，您不希望用户还能够返回到 LoginScreen。
  /// 因此，登录应完全由首页替换。另一个例子是从 SplashScreen 转到 HomeScreen。 它应该只显示一次，用户不能再从 HomeScreen 返回它。
  /// 在这种情况下，由于我们要进入一个全新的屏幕，我们可能需要借助此方法。
  ///
  /// popAndPushNamed：假设您正在有一个 Shopping 应用程序，该应用程序在 ProductsListScreen 中显示产品列表，用户可以在 FiltersScreen 中应用过滤商品。
  /// 当用户单击“应用筛选”按钮时，应弹出 FiltersScreen 并使用新的过滤器值推回到 ProductsListScreen。
  /// 这里 popAndPushNamed 显然更为合适。
  /// screen3 screen4
  /// screen2 screen2
  /// screen1 screen1
  static pushReplacement<TO>(BuildContext context, Widget newPage, {TO result}) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => newPage,), result: result);
  }

  static pushReplacementNamed<TO>(BuildContext context, String newName, {TO result, Object arguments,}) {
    Navigator.pushReplacementNamed(context, newName, result: result, arguments: arguments);
  }

  /// 替代路由，popAndPushNamed和pushReplacement，有小差别
  /// screen3 screen4
  /// screen2 screen2
  /// screen1 screen1
  static popAndPushNamed<TO>(BuildContext context, String newName, {TO result, Object arguments,}) {
    Navigator.popAndPushNamed(context, newName, result: result, arguments: arguments);
  }

  /// 跳转到指定界面，弹出中间部分
  /// screen4
  /// screen3
  /// screen2 screen5
  /// screen1 screen1 loginScreen
  /// predicate参数 (Route<dynamic> route) => false 能够确保删除先前所有实例，比如上面的loginScreen； ModalRoute.withName('/screen1') 跳转到直到哪个界面停止
  static pushAndRemoveUtil(BuildContext context, Widget newPage, RoutePredicate predicate){
    Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (_) => newPage), predicate);
  }

  static pushNamedAndRemoveUntil(BuildContext context, String newRouteName, RoutePredicate predicate, {Object arguments,}){
    Navigator.pushNamedAndRemoveUntil(context, newRouteName, predicate, arguments: arguments);
  }

  /// 反复执行pop 直到该函数的参数predicate返回true为止。
  /// screen3
  /// screen2
  /// screen1 screen1
  static popUntil(BuildContext context, String name){
    Navigator.popUntil(context, ModalRoute.withName(name));
  }

}
