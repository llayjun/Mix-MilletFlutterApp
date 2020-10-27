import 'package:MilletFlutterApp/bean/banner_image_bean.dart';
import 'package:MilletFlutterApp/bean/merchant_item_bean.dart';
import 'package:MilletFlutterApp/bean/merchant_task_item_bean.dart';
import 'package:MilletFlutterApp/test/article_item_bean.dart';
import 'package:MilletFlutterApp/vm/base_refresh_list_vmodel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeVModel extends BaseRefreshListVModel<ArticleItemBean> {

  /// 轮播图
  List<BannerImageBean> _bannerList = [];

  List<BannerImageBean> get bannerList => _bannerList;

  set bannerList(List<BannerImageBean> value) {
    _bannerList = value;
    notifyListeners();
  }

  /// 推荐企业
  List<MerchantItemBean> _merchantItemList = [];

  List<MerchantItemBean> get merchantItemList => _merchantItemList;

  set merchantItemList(List<MerchantItemBean> value) {
    _merchantItemList = value;
    notifyListeners();
  }

  /// 推荐任务
  List<MerchantTaskItemBean> _merchantTaskItemList = [];

  List<MerchantTaskItemBean> get merchantTaskItemList => _merchantTaskItemList;

  set merchantTaskItemList(List<MerchantTaskItemBean> value) {
    _merchantTaskItemList = value;
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

  /// 推荐企业列表
  getMerchantList(BuildContext context) {
    apiService.getRecommendMerchantList().then((value) => {
      merchantItemList = value
    }).catchError((value) {
      Fluttertoast.showToast(msg: value);
    });
  }

  /// 推荐企业列表
  getMerchantTaskList(BuildContext context) {
    apiService.getRecommendMerchantTaskList().then((value) => {
      merchantTaskItemList = value
    }).catchError((value) {
      Fluttertoast.showToast(msg: value);
    });
  }

}
