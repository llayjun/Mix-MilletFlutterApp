import 'package:MilletFlutterApp/service/api_service.dart';
import 'package:flutter/material.dart';

/// normal click event
abstract class Presenter {
  /// 处理点击事件
  ///
  /// 可根据 [action] 进行区分 ,[action] 应是不可变的量
  void onClick(String action);
}

/// ListView Item Click
abstract class ItemPresenter<T> {
  /// 处理列表点击事件
  ///
  /// 可根据 [action] 进行区分 ,[action] 应是不可变的量
  void onItemClick(String action, T item);
}

/// BaseProvide
abstract class BaseVModel with ChangeNotifier {
  ApiService apiService = ApiService();

  /// 初始化数据
  void initData();

  /// 加载数据
  void loadData();
}
