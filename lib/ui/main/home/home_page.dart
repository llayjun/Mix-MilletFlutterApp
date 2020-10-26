import 'package:MilletFlutterApp/bean/banner_image_bean.dart';
import 'package:MilletFlutterApp/constant/app_colors.dart';
import 'package:MilletFlutterApp/constant/app_images.dart';
import 'package:MilletFlutterApp/constant/constant.dart';
import 'package:MilletFlutterApp/ui/main/home/home_vm.dart';
import 'package:MilletFlutterApp/util/screen_util.dart';
import 'package:MilletFlutterApp/widget/base/loading_container.dart';
import 'package:MilletFlutterApp/widget/common_widget.dart';
import 'package:MilletFlutterApp/widget/icon_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return LoadingContainer<HomeVModel>(
        onModelReady: (model) {
          // model.getBannerList(context);
          model.bannerList.add(BannerImageBean(id: "1", imageUrl: Constant.TestImage));
          model.bannerList.add(BannerImageBean(id: "1", imageUrl: Constant.TestImage));
          model.bannerList.add(BannerImageBean(id: "1", imageUrl: Constant.TestImage));
          model.setSuccess();
        },
        successChild: (data) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: Screen.h(620),
                    decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage('https://img.zcool.cn/community/0372d195ac1cd55a8012062e3b16810.jpg'), fit: BoxFit.cover),),
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
                              Text("我的简历", style: TextStyle(color: AppColors.color_FFFFFF, fontSize: Screen.sp(46))),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(Screen.w(45)),
                          height: Screen.h(432),
                          child: Swiper(
                            itemBuilder: (BuildContext context,int index){
                              return Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), image: DecorationImage(
                                  image: NetworkImage("${data.bannerList[index].imageUrl}"),
                                  fit: BoxFit.cover
                                )),
                              );
                            },
                            loop: true,
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
        itemTop(AppImages.homeTop1, "优质任务", "各种高质量的任务"),
        itemTop(AppImages.homeTop2, "高薪兼职", "有着丰厚报酬"),
        itemTop(AppImages.homeTop3, "企业任务", "合作企业发布的任务"),
      ],
    ),
  );

  Widget itemTop(String image, String title, String content) => Container(
      margin: EdgeInsets.all(Screen.w(45)),
      color: AppColors.color_FFFFFF,
      child: Column(
        children: [
          Image.asset(image, width: Screen.w(100), height: Screen.w(100),),
          SizeDivider(width: Screen.h(14)),
          Text(title, style: TextStyle(color: AppColors.color_333333, fontSize: Screen.sp(40))),
          Text(content, style: TextStyle(color: AppColors.color_999999, fontSize: Screen.sp(29))),
        ],
      ),
  );



}
