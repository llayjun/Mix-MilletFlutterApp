import 'package:MilletFlutterApp/bean/base/base_list_bean.dart';
import 'package:MilletFlutterApp/bean/merchant_item_bean.dart';
import 'package:MilletFlutterApp/constant/app_colors.dart';
import 'package:MilletFlutterApp/service/api_service.dart';
import 'package:MilletFlutterApp/ui/merchant_detail/merchant_detail_page.dart';
import 'package:MilletFlutterApp/util/navigator_util.dart';
import 'package:MilletFlutterApp/util/screen_util.dart';
import 'package:MilletFlutterApp/widget/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class WorkPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new WorkPageState();
  }
}

class WorkPageState extends State<WorkPage> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true; //必须重写

  ApiService apiService = ApiService();

  List<MerchantItemBean> merchantList = [];

  // 默认页数
  int index = 1;

  // future，用于防止setState()重置builder的future
  Future future;

  // 是否是初始化数据
  bool initData = true;

  // controller
  EasyRefreshController _easyRefreshController = EasyRefreshController();

  @override
  void initState() {
    super.initState();
    future = getData(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.color_FFFFFF,
      appBar: AppBar(title: Text("企业"), centerTitle: true,),
      body: FutureBuilder<BaseListBean<MerchantItemBean>>(
        future: future,
        builder: (context, snap) {
          switch(snap.connectionState) {
            case ConnectionState.waiting:
              return new Center(child: CircularProgressIndicator(),);
              break;
            case ConnectionState.done:
              if(snap.hasData && initData) {
                BaseListBean<MerchantItemBean> bean = snap?.data;
                List<MerchantItemBean> _merchantList = bean.records??[];
                merchantList.clear();
                merchantList.addAll(_merchantList);
                initData = false;
              }
              return EasyRefresh(
                child: GridView.builder(
                  padding: EdgeInsets.all(Screen.w(20)),
                  primary: false,
                  //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //横轴元素个数
                      crossAxisCount: 2,
                      //纵轴间距
                      mainAxisSpacing: 10.0,
                      //横轴间距
                      crossAxisSpacing: 10.0,
                      //子组件宽高长度比例
                      childAspectRatio: 1.5),
                  itemBuilder: (context, index) {
                    return InkWell(child: itemRecommend("${merchantList[index].merchantLogo??""}", "${merchantList[index].merchantName??""}", "累计${merchantList[index].merchantTaskNum?? 0}个任务"), onTap: () {
                      NavigatorUtil.push(context, MerchantDetailPage(merchantId: "${merchantList[index]?.id?? ""}",));
                    },);
                  },
                  itemCount: merchantList?.length??0,
                ),
                onRefresh: () async {
                  index = 1;
                  getData(index).then((value) {
                    merchantList.clear();
                    merchantList.addAll(value.records);
                    _easyRefreshController.resetLoadState();
                    _easyRefreshController.finishLoad(success: true, noMore: value.current >= value.pages);
                    setState(() {});
                  });
                },
                onLoad: () async {
                  index ++;
                  getData(index).then((value) {
                    merchantList.addAll(value.records);
                    _easyRefreshController.finishLoad(success: true, noMore: value.current >= value.pages);
                    setState(() {});
                  });
                },
                controller: _easyRefreshController,
              );
              break;
            default:
              return new Text('');
              break;
          }
        },
      ),
    );
  }

  Future<BaseListBean<MerchantItemBean>> getData(int pageNum) async {
    return await apiService.getMerchantListPage(pageNum: pageNum);
  }

  /// 企业
  Widget itemRecommend(String imageUrl, String title, String content) => Container(
    padding: EdgeInsets.all(Screen.w(45)),
    color: AppColors.color_f8f8f8,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(Screen.w(20)),
          width: Screen.w(138),
          height: Screen.w(138),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(Screen.w(14)),
              color: AppColors.color_FFFFFF),
          child: ClipRRect(child: Image(image: NetworkImage(imageUrl), fit: BoxFit.cover), borderRadius: BorderRadius.circular(Screen.w(14)),),
        ),
        SizeDivider(height: Screen.h(14)),
        Text(title, style: TextStyle(color: AppColors.color_333333, fontSize: Screen.sp(35), fontWeight: FontWeight.bold)),
        Text(content, style: TextStyle(color: AppColors.color_999999, fontSize: Screen.sp(29))),
      ],
    ),
  );

}
