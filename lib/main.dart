import 'package:MilletFlutterApp/ui/login/login_ui.dart';
import 'package:MilletFlutterApp/util/log_util.dart';
import 'package:MilletFlutterApp/util/sp_util.dart';
import 'package:flutter/material.dart';

import 'constant/config.dart';
import 'net/http_manager.dart';
import 'net/lcfarm_log_interceptor.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Config.fill(debug: true, dbName: "millet", apiUrl: "https://wanandroid.com/");
  /// 初始化日志
  LogUtil.init(isDebug: true, tag: "MilletTag");
  /// 初始化网络
  HttpManager().init(baseUrl: Config.inst.apiUrl, interceptors: [LcfarmLogInterceptor()]);
  /// 初始化sp
  await SpUtil().init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginUi(),
    );
  }
}
