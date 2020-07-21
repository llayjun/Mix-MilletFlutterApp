import 'dart:async';
import 'dart:convert';

import 'package:MilletFlutterApp/net/http_manager.dart';
import 'package:MilletFlutterApp/test/article_bean.dart';

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
}
