import 'package:MilletFlutterApp/constant/app_colors.dart';
import 'package:MilletFlutterApp/vm/base_refresh_list_vmodel.dart';
import 'package:MilletFlutterApp/vm/base_vmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

enum RefreshType {
  none,

  /// 一般布局，默认none
  normal,

  /// 刷新列表布局
  withWidget,

  /// 包含子界面布局
}

/// 定义加载成功的布局（none, normal）
typedef DataChild<T> = Widget Function(T value);

/// 定义包含刷新功能子界面，比如搜索界面，顶部搜索框，底部是刷新列表(withWidget)
typedef DataOutRefreshChild<T> = Widget Function(
    T value, EasyRefresh easyRefresh);

class LoadingContainer<T extends BaseRefreshListVModel> extends StatefulWidget {
  final DataChild<T> successChild; // 成功的子布局（普通和刷新布局）
  final DataOutRefreshChild<T> outRefreshChild; // 包含刷新功能子界面
  final T model; // model
  final Function(T model) onModelReady; // 准备数据
  final Widget noDateWidget; // 没有数据的界面，可自定义
  final bool autoDispose; // 自动取消，一般不做处理
  final RefreshType refreshType; // 布局状态，包含普通，一般列表，带子布局的列表

  const LoadingContainer(
      {Key key,
      @required this.successChild,
      @required this.model,
      this.onModelReady,
      this.noDateWidget,
      this.autoDispose = true,
      this.outRefreshChild,
      this.refreshType = RefreshType.none})
      : super(key: key);

  @override
  LoadingContainerState<T> createState() {
    return LoadingContainerState<T>();
  }
}

class LoadingContainerState<T extends BaseRefreshListVModel>
    extends State<LoadingContainer<T>> {
  T model;

  @override
  void initState() {
    model = widget.model;
    widget.onModelReady?.call(model);
    model.onDataReady();
    super.initState();
  }

  @override
  void dispose() {
    if (widget.autoDispose) model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: model,
      child: Consumer<T>(
        builder: (context, model, child) {
          return _buildCurrentWidget(model);
        },
      ),
    );
  }

  /// 状态变化
  Widget _buildCurrentWidget(T model) {
    EasyRefresh easyRefresh = EasyRefresh(
        onRefresh: () async {
          await model.refresh();
        },
        onLoad: () async {
          await model.loadMore();
        },
        controller: model.easyRefreshController,
        child: widget.successChild(model));

    switch (model.viewState) {
      case ViewState.success:
        return (widget.refreshType == RefreshType.none)
            ? widget.successChild(model)
            : (widget.refreshType == RefreshType.normal)
                ? easyRefresh
                : widget.outRefreshChild(model, easyRefresh);
        break;
      case ViewState.loading:
        return _loadingWidget;
        break;
      case ViewState.empty:
        return widget.noDateWidget ?? _emptyDataWidget();
        break;
      case ViewState.error:
        return _errorWidget(model);
        break;
      default:
        return _errorWidget(model);
        break;
    }
  }

  /// 加载中
  Widget get _loadingWidget {
    return Center(
        child: Container(
      child: SpinKitFadingCircle(
        color: AppColors.color_999999,
        size: 30,
      ),
    ));
  }

  /// 没有数据
  Widget _emptyDataWidget() {
    return Center(
      child: Text('没有数据'),
    );
  }

  /// 加载失败
  Widget _errorWidget(T model) {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('加载失败'),
            FlatButton(
                textColor: AppColors.color_FFFFFF,
                color: AppColors.color_2d84eb,
                onPressed: () {
                  /// 重新加载数据
                  model.onDataReady();
                },
                child: Text('请重新加载'))
          ],
        ),
      ),
    );
  }
}
