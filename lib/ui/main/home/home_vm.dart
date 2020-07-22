import 'package:MilletFlutterApp/test/article_item_bean.dart';
import 'package:MilletFlutterApp/vm/base_refresh_list_vmodel.dart';

class HomeVModel extends BaseRefreshListVModel<ArticleItemBean> {

  @override
  void onDataReady() {
    refresh();
  }

  @override
  Future<dynamic> loadListData({int pageNum}) {
    Map<String, dynamic> _params = Map();
    _params['pageNum'] = pageNum;
    return apiService.getArticle(_params);
  }

}
