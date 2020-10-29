import 'package:MilletFlutterApp/bean/task_detail_bean.dart';
import 'package:MilletFlutterApp/constant/app_colors.dart';
import 'package:MilletFlutterApp/service/api_service.dart';
import 'package:MilletFlutterApp/util/navigator_util.dart';
import 'package:MilletFlutterApp/util/screen_util.dart';
import 'package:MilletFlutterApp/widget/common_widget.dart';
import 'package:MilletFlutterApp/widget/head_view_widget.dart';
import 'package:MilletFlutterApp/widget/icon_text.dart';
import 'package:MilletFlutterApp/widget/page/photo_gallery_view_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskDetailPage extends StatefulWidget {

  String taskId;

  TaskDetailPage({this.taskId = "0", Key key}): super(key: key);

  @override
  _TaskDetailPageState createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {

  ApiService _apiService = new ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headView(context, "任务详情"),
      backgroundColor: AppColors.color_FFFFFF,
      body: FutureBuilder<TaskDetailBean>(
        future: getTaskDetail("${widget.taskId}"),
        builder: (context, snap) {
          switch (snap.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator(),);
              break;
            case ConnectionState.done:
              if(snap.hasData) {
                TaskDetailBean bean = snap?.data;
                return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(Screen.w(45)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          header("${bean?.merchantLogo?? ""}", "${bean?.merchantTaskName?? ""}", "${bean?.taskLocation?? ""}", "${bean?.merchantTaskUnitPrice.toString()?? ""}"),
                          SizeDivider(height: Screen.h(60)),
                          SizeDivider(height: Screen.h(1), color: AppColors.color_e2e2e2),
                          Padding(
                            padding: EdgeInsets.only(top: Screen.h(45), bottom: Screen.h(45)),
                            child: IconText("${bean.taskLocation}", textAlign: TextAlign.center, icon: Icon(Icons.location_on, color: AppColors.color_999999,), iconSize: Screen.sp(45), style: TextStyle(fontSize: Screen.sp(35), color: AppColors.color_999999,)),
                          ),
                          SizeDivider(height: Screen.h(1), color: AppColors.color_e2e2e2),
                          Padding(padding: EdgeInsets.only(top: Screen.h(45), bottom: Screen.h(20)), child: Text("任务描述", style: TextStyle(fontSize: Screen.sp(40), fontWeight: FontWeight.bold, color: AppColors.color_333333),),),
                          Text("${bean.merchantTaskDesc?? ""}", style: TextStyle(fontSize: Screen.sp(35), color: AppColors.color_999999)),
                          SizeDivider(height: Screen.h(60)),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              //横轴元素个数
                                crossAxisCount: 3,
                                //纵轴间距
                                mainAxisSpacing: 10.0,
                                //横轴间距
                                crossAxisSpacing: 10.0,
                                //子组件宽高长度比例
                                childAspectRatio: 1),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                child: taskPic(bean?.taskPictureList[index].picture?? ""),
                                onTap: () {
                                  NavigatorUtil.push(context, PhotoGalleryPage(
                                    index: index,
                                    photoList: bean?.taskPictureList?.map((e) => e.picture)?.toList(),
                                  ));
                                },
                              );
                            },
                            itemCount: bean?.taskPictureList?.length?? 0,
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

  Widget header(String imageUrl, String taskName, String city, String money) =>
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
                      Text(taskName, style: TextStyle(fontSize: Screen.sp(52), color: AppColors.color_333333, fontWeight: FontWeight.bold),),
                      Text(city, style: TextStyle(fontSize: Screen.sp(26), color: AppColors.color_999999)),
                    ],
                  ),
                  Text("总费用：$money", style: TextStyle(fontSize: Screen.sp(35), color: AppColors.color_ed5445),)
                ],
              ),
            )
          ],
        ),
      );

  Widget taskPic(String url) =>
      Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.color_f8f8f8),
        child: ClipRRect(borderRadius: BorderRadius.circular(5), child: Image.network(url, width: Screen.w(173), height: Screen.w(173), fit: BoxFit.cover,),),
      );

  Future<TaskDetailBean> getTaskDetail(String taskId) async {
    return await _apiService.getTaskDetail(taskId);
  }

}
