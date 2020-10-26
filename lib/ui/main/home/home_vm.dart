import 'package:MilletFlutterApp/bean/banner_image_bean.dart';
import 'package:MilletFlutterApp/test/article_item_bean.dart';
import 'package:MilletFlutterApp/vm/base_refresh_list_vmodel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeVModel extends BaseRefreshListVModel<ArticleItemBean> {

  List<BannerImageBean> _bannerList = [];

  List<BannerImageBean> get bannerList => _bannerList;

  set bannerList(List<BannerImageBean> value) {
    _bannerList = value;
    notifyListeners();
  }

  @override
  void onDataReady() {

  }

  /// 轮播图
  getBannerList(BuildContext context) {
    apiService.getBannerImageList().then((value) => {
      bannerList = value
    }).catchError((value) {
      Fluttertoast.showToast(msg: value);
    });
  }

}
