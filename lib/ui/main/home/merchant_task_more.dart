import 'package:MilletFlutterApp/bean/base/base_list_bean.dart';
import 'package:MilletFlutterApp/bean/merchant_task_item_bean.dart';
import 'package:MilletFlutterApp/constant/app_colors.dart';
import 'package:MilletFlutterApp/service/api_service.dart';
import 'package:MilletFlutterApp/util/screen_util.dart';
import 'package:MilletFlutterApp/widget/common_widget.dart';
import 'package:MilletFlutterApp/widget/head_view_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class MerchantTaskMorePage extends StatefulWidget {
  @override
  _MerchantTaskMorePageState createState() => _MerchantTaskMorePageState();
}

class _MerchantTaskMorePageState extends State<MerchantTaskMorePage> {

  ApiService apiService = ApiService();

  List<MerchantTaskItemBean> merchantTaskList = [];

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
      appBar: headView(context, "任务"),
      body: FutureBuilder<BaseListBean<MerchantTaskItemBean>>(
        future: future,
        builder: (context, snap) {
          switch(snap.connectionState) {
            case ConnectionState.waiting:
              return new Center(child: CircularProgressIndicator(),);
              break;
            case ConnectionState.done:
              if(snap.hasData && initData) {
                BaseListBean<MerchantTaskItemBean> bean = snap?.data;
                List<MerchantTaskItemBean> _merchantTaskList = bean.records??[];
                merchantTaskList.clear();
                merchantTaskList.addAll(_merchantTaskList);
                initData = false;
              }
              return EasyRefresh(
                child: ListView.separated(
                  primary: false,
                  separatorBuilder: (context, index) {
                    return Container(height: Screen.h(2), color: AppColors.color_f8f8f8);
                  },
                  itemBuilder: (context, index) {
                    return InkWell(child: _itemRecommendTask("${merchantTaskList[index].merchantLogo?? ""}", "${merchantTaskList[index].merchantTaskName?? ""}", "${merchantTaskList[index].merchantTaskDesc?? ""}", "${merchantTaskList[index].merchantName?? ""}", "${merchantTaskList[index].merchantTaskUnitPrice?? 0}"), onTap: () {

                    },);
                  },
                  itemCount: merchantTaskList?.length??0,
                ),
                onRefresh: () async {
                  index = 1;
                  getData(index).then((value) {
                    merchantTaskList.clear();
                    merchantTaskList.addAll(value.records);
                    _easyRefreshController.resetLoadState();
                    _easyRefreshController.finishLoad(success: true, noMore: value.current >= value.pages);
                    setState(() {});
                  });
                },
                onLoad: () async {
                  index ++;
                  getData(index).then((value) {
                    merchantTaskList.addAll(value.records);
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

  Future<BaseListBean<MerchantTaskItemBean>> getData(int pageNum) async {
    return await apiService.getMerchantTaskListPage(pageNum: pageNum);
  }

  /// 推荐任务
  Widget _itemRecommendTask(String imageUrl, String taskName, String taskDesc, String merchantName, String unitPrice) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(borderRadius: BorderRadius.circular(5), child: Image.network(imageUrl, width: 60, height: 60, fit: BoxFit.cover,),),
          Expanded(
            child:Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("$taskName", style: TextStyle(fontSize: 14, color: Colors.black)),
                  SizedBox(height: 10,),
                  Container(alignment: Alignment.centerLeft, child: Padding(padding: const EdgeInsets.all(5.0), child: Text("$taskDesc", style: TextStyle(fontSize: 10, color: AppColors.color_999999), overflow: TextOverflow.ellipsis, maxLines: 3,),), width: double.infinity, decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)), color: AppColors.color_f8f8f8),),
                  SizedBox(height: 10,),
                  Row(children: [
                    Expanded(child: Text("$merchantName", style: TextStyle(fontSize: 12, color: Colors.black54),)),
                    Text("￥", style: TextStyle(fontSize: 12, color: Colors.red),),
                    Text("$unitPrice", style: TextStyle(fontSize: 16, color: Colors.red),)
                  ],),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
