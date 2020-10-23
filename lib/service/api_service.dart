import 'dart:async';
import 'dart:convert';

import 'package:MilletFlutterApp/bean/base/base_list_bean.dart';
import 'package:MilletFlutterApp/bean/register_user_bean.dart';
import 'package:MilletFlutterApp/net/http_manager.dart';
import 'package:MilletFlutterApp/test/article_bean.dart';
import 'package:MilletFlutterApp/test/article_item_bean.dart';
import 'package:common_utils/common_utils.dart';

class ApiService {

  /// test
  Future<List<ArticleBean>> getInfo() async {
    Completer<List<ArticleBean>> completer = Completer();
    HttpManager().get(
        url: "wxarticle/chapters/json",
        successCallback: (value) {
          List responseJson = json.decode(json.encode(value));
          List<ArticleBean> modelTestList = responseJson.map((m) => new ArticleBean.fromJson(m)).toList();
          completer.complete(modelTestList);
        },
        errorCallback: (value) {
          completer.completeError(value.message);
        },
        tag: "");
    return completer.future;
  }

  /// 注册
  Future<RegisterUserBean> registerUser(String name, String mobile, String passWord, int sex) async {
    Completer<RegisterUserBean> completer = Completer();
    Map<String, dynamic> params = new Map();
    if(!TextUtil.isEmpty(name))
        params["name"] = name;
    if(!TextUtil.isEmpty(mobile))
        params["mobile"] = mobile;
    if(!TextUtil.isEmpty(name))
        params["passWord"] = passWord;
    params["sex"] = sex;
    HttpManager().post(
        url: "api/app/users/register",
        data: params,
        successCallback: (value) {
          RegisterUserBean registerUserBean = RegisterUserBean.fromJson(json.decode(json.encode(value)));
          completer.complete(registerUserBean);
        },
        errorCallback: (value) {
          completer.completeError(value.message);
        },
        tag: "");
    return completer.future;
  }

  /// 登录
  Future<RegisterUserBean> login(String mobile, String passWord) async {
    Completer<RegisterUserBean> completer = Completer();
    Map<String, dynamic> params = new Map();
    if(!TextUtil.isEmpty(mobile))
      params["mobile"] = mobile;
    if(!TextUtil.isEmpty(passWord))
      params["passWord"] = passWord;
    HttpManager().post(
        url: "api/app/users/userLogin",
        data: params,
        successCallback: (value) {
          RegisterUserBean registerUserBean = RegisterUserBean.fromJson(json.decode(json.encode(value)));
          completer.complete(registerUserBean);
        },
        errorCallback: (value) {
          completer.completeError(value.message);
        },
        tag: "");
    return completer.future;
  }

  /// 列表
  Future<List<ArticleItemBean>> getArticle(Map<String, dynamic> params) async {
    Completer<List<ArticleItemBean>> completer = Completer();
    HttpManager().get(
        url: "/user_article/list/${params["pageNum"]}/json",
        successCallback: (value) {
          Map map = json.decode(json.encode(value));
          BaseListBean baseListBean = BaseListBean.fromJson(map);
          List<ArticleItemBean> modelTestList = baseListBean.datas.map((m) => new ArticleItemBean.fromJson(m)).toList();
          completer.complete(modelTestList);
        },
        errorCallback: (value) {
          completer.completeError(value.message);
        },
        tag: "");
    return completer.future;
  }

}
