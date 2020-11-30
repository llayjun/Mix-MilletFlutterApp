import 'dart:async';
import 'dart:convert';

import 'package:MilletFlutterApp/bean/article_list_bean.dart';
import 'package:MilletFlutterApp/bean/article_type_bean.dart';
import 'package:MilletFlutterApp/bean/banner_image_bean.dart';
import 'package:MilletFlutterApp/bean/base/base_list_bean.dart';
import 'package:MilletFlutterApp/bean/login_user_bean.dart';
import 'package:MilletFlutterApp/bean/merchant_detail_bean.dart';
import 'package:MilletFlutterApp/bean/merchant_item_bean.dart';
import 'package:MilletFlutterApp/bean/merchant_task_item_bean.dart';
import 'package:MilletFlutterApp/bean/register_user_bean.dart';
import 'package:MilletFlutterApp/bean/task_detail_bean.dart';
import 'package:MilletFlutterApp/constant/constant.dart';
import 'package:MilletFlutterApp/net/http_manager.dart';
import 'package:MilletFlutterApp/util/sp_util.dart';
import 'package:common_utils/common_utils.dart';

class ApiService {

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
  Future<LoginUserBean> login(String mobile, String passWord) async {
    Completer<LoginUserBean> completer = Completer();
    Map<String, dynamic> params = new Map();
    if(!TextUtil.isEmpty(mobile))
      params["mobile"] = mobile;
    if(!TextUtil.isEmpty(passWord))
      params["passWord"] = passWord;
    HttpManager().post(
        url: "api/app/users/userLogin",
        data: params,
        successCallback: (value) {
          LoginUserBean loginUserBean = LoginUserBean.fromJson(json.decode(json.encode(value)));
          // 保存token，并刷新
          SpUtil().putString(SpKeyUtil.TokenKey, loginUserBean.authorization?? "");
          HttpManager().refreshToken();
          completer.complete(loginUserBean);
        },
        errorCallback: (value) {
          completer.completeError(value.message);
        },
        tag: "");
    return completer.future;
  }

  /// banner图
  Future<List<BannerImageBean>> getBannerImageList() async {
    Completer<List<BannerImageBean>> completer = Completer();
    HttpManager().get(
        url: "api/app/banner/getBannerList",
        successCallback: (value) {
          List responseJson = json.decode(json.encode(value));
          List<BannerImageBean> modelTestList = responseJson.map((m) => new BannerImageBean.fromJson(m)).toList();
          completer.complete(modelTestList);
        },
        errorCallback: (value) {
          completer.completeError(value.message);
        },
        tag: "");
    return completer.future;
  }

  /// 文章类型
  Future<List<ArticleTypeBean>> getArticleTypeList() async {
    Completer<List<ArticleTypeBean>> completer = Completer();
    HttpManager().get(
        url: "api/app/articleType/getArticleTypeList",
        successCallback: (value) {
          List responseJson = json.decode(json.encode(value));
          List<ArticleTypeBean> articleTypeList = responseJson.map((m) => new ArticleTypeBean.fromJson(m)).toList();
          completer.complete(articleTypeList);
        },
        errorCallback: (value) {
          completer.completeError(value.message);
        },
        tag: "");
    return completer.future;
  }

  /// 文章列表分页
  Future<BaseListBean<ArticleListBean>> getArticleListPage({int articleType = 0, int pageNum, int pageSize = 4, String content = ""}) async {
    Map<String, dynamic> params = new Map();
    if(articleType != null) {
      params['articleType'] = articleType;
    }
    if(pageNum != null) {
      params['pageNum'] = pageNum;
    }
    if(pageSize != null) {
      params['pageSize'] = pageSize;
    }
    if(!TextUtil.isEmpty(content)) {
      params['content'] = content;
    }
    Completer<BaseListBean<ArticleListBean>> completer = Completer();
    HttpManager().post(
        url: "api/app/article/getArticleList",
        data: params,
        successCallback: (value) {
          Map map = json.decode(json.encode(value));
          BaseListBean baseListBean = BaseListBean.fromJson(map);
          List<ArticleListBean> modelTestList = baseListBean.records.map((m) => new ArticleListBean.fromJson(m)).toList();
          completer.complete(BaseListBean(current: baseListBean.current, records: modelTestList, pages: baseListBean.pages, size: baseListBean.size, total: baseListBean.total));
        },
        errorCallback: (value) {
          completer.completeError(value.message);
        },
        tag: "");
    return completer.future;
  }

  /// 推荐企业列表
  Future<List<MerchantItemBean>> getRecommendMerchantList() async {
    Completer<List<MerchantItemBean>> completer = Completer();
    HttpManager().get(
        url: "api/app/merchant/getMerchantList",
        successCallback: (value) {
          List responseJson = json.decode(json.encode(value));
          List<MerchantItemBean> modelTestList = responseJson.map((m) => new MerchantItemBean.fromJson(m)).toList();
          completer.complete(modelTestList);
        },
        errorCallback: (value) {
          completer.completeError(value.message);
        },
        tag: "");
    return completer.future;
  }

  /// 企业详情
  Future<MerchantDetailBean> getMerchantDetail(String merchantId) async {
    Map<String, dynamic> data = new Map();
    if(!TextUtil.isEmpty(merchantId)) {
      data['merchantId'] = merchantId;
    }
    Completer<MerchantDetailBean> completer = Completer();
    HttpManager().post(
        url: "api/app/merchant/getMerchantDetail",
        data: data,
        successCallback: (value) {
          MerchantDetailBean merchantDetailBean = MerchantDetailBean.fromJson(json.decode(json.encode(value)));
          completer.complete(merchantDetailBean);
        },
        errorCallback: (value) {
          completer.completeError(value.message);
        },
        tag: "");
    return completer.future;
  }

  /// 推荐企业任务列表
  Future<List<MerchantTaskItemBean>> getRecommendMerchantTaskList() async {
    Completer<List<MerchantTaskItemBean>> completer = Completer();
    HttpManager().get(
        url: "api/app/task/getMerchantTaskList",
        successCallback: (value) {
          List responseJson = json.decode(json.encode(value));
          List<MerchantTaskItemBean> modelTestList = responseJson.map((m) => new MerchantTaskItemBean.fromJson(m)).toList();
          completer.complete(modelTestList);
        },
        errorCallback: (value) {
          completer.completeError(value.message);
        },
        tag: "");
    return completer.future;
  }

  /// 企业任务详情
  Future<TaskDetailBean> getTaskDetail(String taskId) async {
    Map<String, dynamic> data = new Map();
    if(!TextUtil.isEmpty(taskId)) {
      data['merchantTaskId'] = taskId;
    }
    Completer<TaskDetailBean> completer = Completer();
    HttpManager().post(
        url: "api/app/task/getMerchantTaskDetail",
        data: data,
        successCallback: (value) {
          TaskDetailBean taskDetailBean = TaskDetailBean.fromJson(json.decode(json.encode(value)));
          completer.complete(taskDetailBean);
        },
        errorCallback: (value) {
          completer.completeError(value.message);
        },
        tag: "");
    return completer.future;
  }

  /// 企业列表分页
  Future<BaseListBean<MerchantItemBean>> getMerchantListPage({int pageNum, int pageSize = 4, String content = ""}) async {
    Map<String, dynamic> params = new Map();
    if(pageNum != null) {
      params['pageNum'] = pageNum;
    }
    if(pageSize != null) {
      params['pageSize'] = pageSize;
    }
    if(!TextUtil.isEmpty(content)) {
      params['content'] = content;
    }
    Completer<BaseListBean<MerchantItemBean>> completer = Completer();
    HttpManager().post(
        url: "api/app/merchant/getMerchantListPage",
        data: params,
        successCallback: (value) {
          Map map = json.decode(json.encode(value));
          BaseListBean baseListBean = BaseListBean.fromJson(map);
          List<MerchantItemBean> modelTestList = baseListBean.records.map((m) => new MerchantItemBean.fromJson(m)).toList();
          completer.complete(BaseListBean(current: baseListBean.current, records: modelTestList, pages: baseListBean.pages, size: baseListBean.size, total: baseListBean.total));
        },
        errorCallback: (value) {
          completer.completeError(value.message);
        },
        tag: "");
    return completer.future;
  }

  /// 企业任务列表分页
  Future<BaseListBean<MerchantTaskItemBean>> getMerchantTaskListPage({int pageNum, int pageSize = 4, String content = ""}) async {
    Map<String, dynamic> params = new Map();
    if(pageNum != null) {
      params['pageNum'] = pageNum;
    }
    if(pageSize != null) {
      params['pageSize'] = pageSize;
    }
    if(!TextUtil.isEmpty(content)) {
      params['content'] = content;
    }
    Completer<BaseListBean<MerchantTaskItemBean>> completer = Completer();
    HttpManager().post(
        url: "api/app/task/getMerchantTaskListPage",
        data: params,
        successCallback: (value) {
          Map map = json.decode(json.encode(value));
          BaseListBean baseListBean = BaseListBean.fromJson(map);
          List<MerchantTaskItemBean> modelTestList = baseListBean.records.map((m) => new MerchantTaskItemBean.fromJson(m)).toList();
          completer.complete(BaseListBean(current: baseListBean.current, records: modelTestList, pages: baseListBean.pages, size: baseListBean.size, total: baseListBean.total));
        },
        errorCallback: (value) {
          completer.completeError(value.message);
        },
        tag: "");
    return completer.future;
  }



}
