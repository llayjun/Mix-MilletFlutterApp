import 'package:MilletFlutterApp/test/article_bean.dart';
import 'package:MilletFlutterApp/vm/base_refresh_list_vmodel.dart';
import 'package:MilletFlutterApp/vm/base_vmodel.dart';
import 'package:common_utils/common_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginVModel extends BaseRefreshListVModel {
  List<ArticleBean> _articleBeanList = [];

  List<ArticleBean> get articleBeanList => _articleBeanList;

  @override
  void onDataReady() {

  }

  /// 登录
  login(String name, String pass) {
    if (TextUtil.isEmpty(name)) {
      Fluttertoast.showToast(msg: "请输入手机号手机号");
      return;
    }
    if (TextUtil.isEmpty(pass)) {
      Fluttertoast.showToast(msg: "请输入密码密码");
      return;
    }
    apiService.getInfo().then((value) => {
      _articleBeanList = value,
      notifyListeners()
    }).catchError((value) {
      Fluttertoast.showToast(msg: value);
    });
  }

}
