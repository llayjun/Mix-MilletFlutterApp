import 'package:MilletFlutterApp/bean/banner_image_bean.dart';
import 'package:MilletFlutterApp/constant/app_colors.dart';
import 'package:MilletFlutterApp/constant/app_images.dart';
import 'package:MilletFlutterApp/constant/constant.dart';
import 'package:MilletFlutterApp/ui/article/article_page.dart';
import 'package:MilletFlutterApp/ui/main/home/home_vm.dart';
import 'package:MilletFlutterApp/ui/main/home/merchant_more.dart';
import 'package:MilletFlutterApp/ui/merchant_detail/merchant_detail_page.dart';
import 'package:MilletFlutterApp/ui/task_detail_page/task_detail_page.dart';
import 'package:MilletFlutterApp/util/navigator_util.dart';
import 'package:MilletFlutterApp/util/screen_util.dart';
import 'package:MilletFlutterApp/widget/base/loading_container.dart';
import 'package:MilletFlutterApp/widget/common_widget.dart';
import 'package:MilletFlutterApp/widget/icon_text.dart';
import 'package:MilletFlutterApp/widget/page/photo_gallery_view_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'merchant_task_more.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true; //必须重写

  @override
  Widget build(BuildContext context) {
    return LoadingContainer<HomeVModel>(
        onModelReady: (model) {
          model.getBannerList(context);
          model.getMerchantList(context);
          model.getMerchantTaskList(context);
          model.setSuccess();
        },
        successChild: (data) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage('https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=314202116,1401007204&fm=26&gp=0.jpg'), fit: BoxFit.cover),),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: Screen.w(45), right: Screen.w(45), top: Screen.h(90)),
                          child: Row(
                            children: [
                              IconText("苏州", textAlign: TextAlign.center, icon: Icon(Icons.location_on, color: AppColors.color_FFFFFF,), iconSize: Screen.sp(55), style: TextStyle(fontSize: Screen.sp(46), color: AppColors.color_FFFFFF,)),
                              SizeDivider(width: Screen.h(30)),
                              Expanded(child: topSearch,),
                              SizeDivider(width: Screen.h(30)),
                              InkWell(
                                child: Text("我的文章", style: TextStyle(color: AppColors.color_FFFFFF, fontSize: Screen.sp(46))),
                                onTap: () {
                                  NavigatorUtil.push(context, ArticlePage());
                                },
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(Screen.w(45)),
                          height: Screen.h(432),
                          child: Swiper(
                            itemBuilder: (BuildContext context,int index){
                              return GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), image: DecorationImage(
                                      image: NetworkImage("${data.bannerList[index].imageUrl}"),
                                      fit: BoxFit.cover
                                  )),
                                ),
                                onTap: () {
                                  NavigatorUtil.push(context, PhotoGalleryPage(
                                    index: index,
                                    photoList: data.bannerList.map((e) => e.imageUrl).toList(),
                                  ));
                                },
                              );
                            },
                            autoplay: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: data.bannerList.length,
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
                        ),
                      ],
                    ),
                  ),
                  topTask,
                  itemTitle("推荐企业", () {
                    NavigatorUtil.push(context, MerchantMorePage());
                  }),
                  Container(
                    margin: EdgeInsets.all(Screen.w(45)),
                    height: Screen.h(300),
                    constraints: BoxConstraints(minHeight: Screen.h(300)),
                    alignment: Alignment.centerLeft,
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: itemRecommend("${data.merchantItemList[index].merchantLogo?? ""}", "${data.merchantItemList[index].merchantName?? ""}", "累计${data.merchantItemList[index].merchantTaskNum?? 0}个任务"),
                          onTap: () {
                            NavigatorUtil.push(context, MerchantDetailPage(merchantId: "${data?.merchantItemList[index]?.id?? ""}",));
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizeDivider(width: Screen.h(30));
                      },
                      itemCount: data.merchantItemList.length?? 0,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,),
                  ),
                  itemTitle("推荐任务", () {
                    NavigatorUtil.push(context, MerchantTaskMorePage());
                  }),
                  ListView.separated(
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: _itemRecommendTask("${data.merchantTaskItemList[index].merchantLogo?? ""}", "${data.merchantTaskItemList[index].merchantTaskName?? ""}", "${data.merchantTaskItemList[index].merchantTaskDesc?? ""}", "${data.merchantTaskItemList[index].merchantName?? ""}", "${data.merchantTaskItemList[index].merchantTaskUnitPrice?? 0}"),
                        onTap: () {
                          NavigatorUtil.push(context, TaskDetailPage(taskId: "${data?.merchantTaskItemList[index]?.id?? ""}",));
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Container(height: Screen.h(2), color: AppColors.color_f8f8f8);
                    },
                    itemCount: data.merchantTaskItemList.length?? 0,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,),
                ],
              ),
            ),
          );
        },
        model: HomeVModel());
  }

  Widget get topSearch => SizedBox(
    child: Container(
        constraints: BoxConstraints(minWidth: Screen.w(605)),
        padding: EdgeInsets.only(left: Screen.w(30), top: Screen.h(25), bottom: Screen.h(25)),
        decoration: BoxDecoration (
          borderRadius: BorderRadius.circular(43),
          color: AppColors.color_FFFFFF,
        ),
        child: IconText("搜索职位名称", icon: Icon(Icons.search), iconSize: Screen.sp(40), style: TextStyle(fontSize: Screen.sp(35), color: AppColors.color_bdbdbd),)
    ),
  );

  Widget get topTask => Container(
    color: AppColors.color_FFFFFF,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(child: itemTop(AppImages.homeTop1, "优质任务", "各种高质量的任务"), onTap: () {
          NavigatorUtil.push(context, MerchantTaskMorePage());
        },),
        GestureDetector(child: itemTop(AppImages.homeTop2, "高薪兼职", "有着丰厚报酬"), onTap: () {
          NavigatorUtil.push(context, MerchantMorePage());
        },),
        GestureDetector(child: itemTop(AppImages.homeTop3, "企业任务", "合作企业发布的任务"), onTap: () {
          NavigatorUtil.push(context, MerchantTaskMorePage());
        },),
      ],
    ),
  );

  Widget itemTop(String image, String title, String content) => Container(
      margin: EdgeInsets.all(Screen.w(45)),
      color: AppColors.color_FFFFFF,
      child: Column(
        children: [
          Image.asset(image, width: Screen.w(100), height: Screen.w(100),),
          SizeDivider(height: Screen.h(14)),
          Text(title, style: TextStyle(color: AppColors.color_333333, fontSize: Screen.sp(40), fontWeight: FontWeight.bold)),
          Text(content, style: TextStyle(color: AppColors.color_999999, fontSize: Screen.sp(29))),
        ],
      ),
  );

  Widget itemTitle(String title, GestureTapCallback callback) => Container(
    padding: EdgeInsets.only(left: Screen.w(45), right: Screen.w(45)),
    child: Row(
      children: [
        Expanded(child: Text("$title", style: TextStyle(color: AppColors.color_333333, fontSize: Screen.sp(46), fontWeight: FontWeight.bold)),),
        GestureDetector(child: Text("查看更多", style: TextStyle(color: AppColors.color_333333, fontSize: Screen.sp(35))), onTap: callback,)
      ],
    ),
  );

  /// 推荐企业
  Widget itemRecommend(String imageUrl, String title, String content) => Container(
    width: Screen.w(346),
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

  /// 推荐任务
  Widget _itemRecommendTask(String imageUrl, String taskName, String taskDesc,  String merchantName, String unitPrice) {
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
                  Container(alignment: Alignment.centerLeft, child: Padding(padding: const EdgeInsets.all(5.0), child: Text("$taskDesc", style: TextStyle(fontSize: 10, color: AppColors.color_999999), overflow: TextOverflow.ellipsis, maxLines: 2,),), width: double.infinity, decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)), color: AppColors.color_f8f8f8),),
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
