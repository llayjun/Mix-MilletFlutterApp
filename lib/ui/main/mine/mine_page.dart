import 'package:MilletFlutterApp/constant/app_colors.dart';
import 'package:MilletFlutterApp/constant/app_images.dart';
import 'package:MilletFlutterApp/constant/constant.dart';
import 'package:MilletFlutterApp/util/screen_util.dart';
import 'package:MilletFlutterApp/widget/common_widget.dart';
import 'package:MilletFlutterApp/widget/icon_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MinePageState();
  }
}

class MinePageState extends State<MinePage> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true; //必须重写

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: Screen.w(),
                  decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage("https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2588111137,2818876915&fm=26&gp=0.jpg"), fit: BoxFit.cover),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: Screen.w(45), right: Screen.w(45), top: Screen.h(90), bottom: Screen.h(180)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconText("切换角色", padding: EdgeInsets.only(right: Screen.w(20)), textAlign: TextAlign.center, icon: Icon(Icons.add_link), iconSize: Screen.sp(55), style: TextStyle(fontSize: Screen.sp(46), color: AppColors.color_FFFFFF,)),
                            GestureDetector(
                              child: ImageIcon(AssetImage(AppImages.mySetting), color: AppColors.color_FFFFFF, size: Screen.sp(55),),
                              onTap: () {
                                _alertDialog();
                              },
                            )
                          ],
                        ),
                        SizeDivider(height: Screen.h(60)),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: Screen.w(173),
                              width: Screen.w(173),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(Constant.TestImage),
                              ),
                            ),
                            SizeDivider(width: Screen.h(60)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("蓝吧新人", style: TextStyle(fontSize: Screen.sp(46), color: AppColors.color_FFFFFF),),
                                Text("查看并编辑个人资料", style: TextStyle(fontSize: Screen.sp(29), color: AppColors.color_FFFFFF),),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizeDivider(height: Screen.h(150)),
                Padding(padding: EdgeInsets.all(Screen.w(45),), child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("我的任务", style: TextStyle(fontSize: Screen.sp(46), color: AppColors.color_333333, fontWeight: FontWeight.bold),),
                    Text("｜ 赶紧去做任务赚钱", style: TextStyle(fontSize: Screen.sp(29), color: AppColors.color_999999,),),
                  ],
                ),),
                topApply,
                Container(height: Screen.h(30), color: AppColors.color_f8f8f8),
                Padding(padding: EdgeInsets.all(Screen.w(45),), child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("帮助中心", style: TextStyle(fontSize: Screen.sp(46), color: AppColors.color_333333, fontWeight: FontWeight.bold),),
                  ],
                ),),
                bottomHelp,
              ],
            ),
            Positioned(
              top: Screen.h(420),
              left: Screen.w(45),
              right: Screen.w(45),
              child: topContainer,
            )
          ],
        ),
      ),
    );
  }

  /// 退出登录弹窗
  _alertDialog() async {
    var alertDialogs = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("提示"),
            content: Text("确定要退出吗"),
            actions: <Widget>[
              FlatButton(
                  child: Text("取消"),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              FlatButton(
                  child: Text("确定"),
                  onPressed: () async {
                    await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  }),
            ],
          );
        });
    return alertDialogs;
  }

  Widget get topContainer => Card(
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(Screen.w(14))),
        color: AppColors.color_FFFFFF,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          itemApply(AppImages.myTop1, "实名信息"),
          itemApply(AppImages.myTop2, "我的协议"),
          itemApply(AppImages.myTop3, "个人简历"),
          itemApply(AppImages.myTop4, "收款方式"),
        ],
      ),
    ),
  );

  Widget get topApply => Container(
    color: AppColors.color_FFFFFF,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        itemApply(AppImages.myApply1, "已申请"),
        itemApply(AppImages.myApply2, "申请通过"),
        itemApply(AppImages.myApply3, "进行中"),
        itemApply(AppImages.myApply4, "已完成"),
        itemApply(AppImages.myApply5, "已结算")
      ],
    ),
  );

  Widget get bottomHelp => Container(
    color: AppColors.color_FFFFFF,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        itemApply(AppImages.myHelp1, "客服咨询"),
        itemApply(AppImages.myHelp2, "投诉建议"),
        itemApply(AppImages.myHelp3, "关于我们"),
      ],
    ),
  );

  Widget itemApply(String image, String title) => Container(
    margin: EdgeInsets.all(Screen.w(45)),
    color: AppColors.color_FFFFFF,
    child: Column(
      children: [
        Image.asset(image, width: Screen.w(70), height: Screen.w(70),),
        SizeDivider(height: Screen.h(30)),
        Text(title, style: TextStyle(color: AppColors.color_666666, fontSize: Screen.sp(35))),
      ],
    ),
  );
}
