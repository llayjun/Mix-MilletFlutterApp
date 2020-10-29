import 'package:MilletFlutterApp/bean/merchant_detail_bean.dart';
import 'package:MilletFlutterApp/constant/app_colors.dart';
import 'package:MilletFlutterApp/service/api_service.dart';
import 'package:MilletFlutterApp/util/screen_util.dart';
import 'package:MilletFlutterApp/widget/common_widget.dart';
import 'package:MilletFlutterApp/widget/head_view_widget.dart';
import 'package:MilletFlutterApp/widget/icon_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class MerchantDetailPage extends StatefulWidget {

  String merchantId;

  MerchantDetailPage({this.merchantId = "0", Key key}): super(key: key);

  @override
  _MerchantDetailPageState createState() => _MerchantDetailPageState();
}

class _MerchantDetailPageState extends State<MerchantDetailPage> {

  ApiService _apiService = new ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headView(context, ""),
      backgroundColor: AppColors.color_FFFFFF,
      body: FutureBuilder<MerchantDetailBean>(
        future: getMerchantDetail("${widget.merchantId}"),
        builder: (context, snap) {
          switch (snap.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator(),);
              break;
            case ConnectionState.done:
              if(snap.hasData) {
                MerchantDetailBean bean = snap?.data;
                return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(Screen.w(45)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          header("${bean?.merchantLogo?? ""}", "${bean?.merchantName?? ""}", "${bean?.city?? ""}", "${bean?.scale?? ""}", "${bean?.nature?? ""}"),
                          SizeDivider(height: Screen.h(60)),
                          SizeDivider(height: Screen.h(1), color: AppColors.color_e2e2e2),
                          Padding(
                            padding: EdgeInsets.only(top: Screen.h(45), bottom: Screen.h(45)),
                            child: IconText("${bean.location}", textAlign: TextAlign.center, icon: Icon(Icons.location_on, color: AppColors.color_999999,), iconSize: Screen.sp(45), style: TextStyle(fontSize: Screen.sp(35), color: AppColors.color_999999,)),
                          ),
                          SizeDivider(height: Screen.h(1), color: AppColors.color_e2e2e2),
                          SizeDivider(height: Screen.h(60)),
                          banner(bean.merchantPicList),
                          Padding(padding: EdgeInsets.only(top: Screen.h(45), bottom: Screen.h(20)), child: Text("基本信息", style: TextStyle(fontSize: Screen.sp(40), fontWeight: FontWeight.bold, color: AppColors.color_333333),),),
                          textItem("名         称", "${bean.merchantName}"),
                          textItem("规         模", "${bean.scale}"),
                          textItem("性         质", "${bean.nature}"),
                          textItem("成立时间", "${bean.establishTime}"),
                          textItem("注册资金", "${bean.funds}"),
                          textItem("经营范围", "${bean.merchantRange}"),
                          Padding(padding: EdgeInsets.only(top: Screen.h(45), bottom: Screen.h(20)), child: Text("任务列表（${bean.merchantTaskNum}）", style: TextStyle(fontSize: Screen.sp(40), fontWeight: FontWeight.bold, color: AppColors.color_333333),),),
                          ListView.separated(
                            itemBuilder: (context, index) {
                              return taskItem(bean?.merchantTaskList[index]?.merchantTaskName?? ""
                                  , bean?.merchantTaskList[index]?.taskLocation?? ""
                                  , bean?.merchantTaskList[index]?.createdTime?? ""
                                  , bean?.merchantTaskList[index]?.merchantTaskUnitPrice?.toString()?? "");
                            },
                            itemCount: bean?.merchantTaskList?.length?? 0,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) {
                              return SizeDivider(height: Screen.h(20));
                            },
                          ),
                        ],
                      ),
                    ));
              }
              return Text('');
              break;
            default:
              return Text('');
              break;
          }
        },
      ),
    );
  }

  Widget header(String imageUrl, String name, String city, String scale, String nature) =>
      Container(
        child: Row(
          children: [
            ClipRRect(borderRadius: BorderRadius.circular(5), child: Image.network(imageUrl, width: Screen.w(173), height: Screen.w(173), fit: BoxFit.cover,),),
            SizeDivider(width: Screen.w(30)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(name, style: TextStyle(fontSize: Screen.sp(52), color: AppColors.color_333333, fontWeight: FontWeight.bold),),
                      TextFill("已认证", 26, AppColors.color_FFFFFF, h: 20, v: 8, radius: 4, bg: AppColors.color_3edab6),
                    ],
                  ),
                  Text("$city | $scale | $nature", style: TextStyle(fontSize: Screen.sp(35), color: AppColors.color_999999),)
                ],
              ),
            )
          ],
        ),
      );

  Widget banner(List<MerchantPicList> list) => Container(
    height: Screen.h(432),
    child: Swiper(
      itemBuilder: (BuildContext context,int index){
        return Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), image: DecorationImage(
              image: NetworkImage("${list[index].picture?? ""}"),
              fit: BoxFit.cover
          )),
        );
      },
      loop: true,
      autoplay: true,
      scrollDirection: Axis.horizontal,
      itemCount: list?.length?? 0,
      pagination: SwiperPagination(// 分页指示器
          alignment: Alignment.bottomCenter,// 位置 Alignment.bottomCenter 底部中间
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),// 距离调整
          builder: DotSwiperPaginationBuilder( // 指示器构建
              space: ScreenUtil().setWidth(5),// 点之间的间隔
              size: ScreenUtil().setWidth(12), // 没选中时的大小
              activeSize: ScreenUtil().setWidth(15),// 选中时的大小
              color: Colors.black54,// 没选中时的颜色
              activeColor: Colors.white)),// 选中时的颜色
    ),
  );

  Widget textItem(String title, String content) => Container(
    child: Padding(
      padding: EdgeInsets.only(top: Screen.h(15), bottom: Screen.h(15)),
      child: Row(
        children: [
          Text(title, style: TextStyle(fontSize: Screen.sp(40), color: AppColors.color_999999,), textAlign: TextAlign.center,),
          SizeDivider(width: Screen.w(30)),
          Expanded(
            child: Text(content, style: TextStyle(fontSize: Screen.sp(40), color: AppColors.color_333333), textAlign: TextAlign.left,),
          )
        ],
      ),
    )
  );

  Widget taskItem(String taskName, String city, String time, String money) =>
      Container(
        padding: EdgeInsets.all(Screen.w(30)),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.color_f8f8f8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(taskName, style: TextStyle(fontSize: Screen.sp(40), color: AppColors.color_333333),),
                Text(city, style: TextStyle(fontSize: Screen.sp(35), color: AppColors.color_999999),),
              ],
            ),
            SizeDivider(height: Screen.h(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("发布日期：$time", style: TextStyle(fontSize: Screen.sp(35), color: AppColors.color_999999),),
                Text(money, style: TextStyle(fontSize: Screen.sp(35), color: AppColors.color_ed5445),),
              ],
            ),
          ],
        ),
      );

  Future<MerchantDetailBean> getMerchantDetail(String merchantId) async {
    return await _apiService.getMerchantDetail(merchantId);
  }

}
