import 'package:MilletFlutterApp/constant/constant.dart';
import 'package:MilletFlutterApp/ui/login/login_ui.dart';
import 'package:MilletFlutterApp/ui/login/login_vm.dart';
import 'package:MilletFlutterApp/util/log_util.dart';
import 'package:MilletFlutterApp/util/screen_util.dart';
import 'package:MilletFlutterApp/util/sp_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'constant/config.dart';
import 'net/http_manager.dart';
import 'net/lcfarm_log_interceptor.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Config.fill(debug: Constant.Debug, dbName: "millet", apiUrl: Constant.BaseUrl);
  /// 初始化日志
  LogUtil.init(isDebug: Config.inst.debug, tag: "MilletTag");
  /// 初始化网络
  HttpManager().init(baseUrl: Config.inst.apiUrl, interceptors: [LcfarmLogInterceptor()]);
  /// 初始化sp
  await SpUtil().init();
  /// 初始化刷新
  await initRefresh();
  runApp(MyApp());
}

Future initRefresh() async {
  /// 初始化刷新样式
  EasyRefresh.defaultHeader = ClassicalHeader(
      refreshText: "下拉刷新",
      refreshReadyText: "释放刷新",
      refreshingText: "正在刷新",
      refreshedText: "刷新完成",
      infoText: '更新于 %T');
  EasyRefresh.defaultFooter = ClassicalFooter(
      loadText: "下拉加载更多",
      loadReadyText: "释放加载更多",
      loadingText: "加载中",
      loadedText: "加载完成",
      infoText: '更新于 %T');
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    /// 这边的MultiProvider是设置整个app的状态
    return MultiProvider(providers: [
      ChangeNotifierProvider<LoginVModel>.value(value: LoginVModel()),
    ],
      child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      locale: const Locale('zh'),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('zh', 'CH'),
        const Locale('en', 'US'),
      ],
      home: App(),
    ),);
  }

}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    /// 初始化尺寸
    Screen.init(context, 1080, 1920);
    return LoginUi();
  }

}


