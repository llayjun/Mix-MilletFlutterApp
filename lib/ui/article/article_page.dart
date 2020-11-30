import 'package:MilletFlutterApp/bean/article_type_bean.dart';
import 'package:MilletFlutterApp/constant/app_colors.dart';
import 'package:MilletFlutterApp/service/api_service.dart';
import 'package:MilletFlutterApp/ui/article/article_list_page.dart';
import 'package:MilletFlutterApp/util/screen_util.dart';
import 'package:MilletFlutterApp/widget/head_view_widget.dart';
import 'package:flutter/material.dart';

class ArticlePage extends StatefulWidget {
  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage>
    with SingleTickerProviderStateMixin {

  ApiService _apiService = new ApiService();

  TabController mController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    mController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headView(context, "我的文章"),
      body: FutureBuilder<List<ArticleTypeBean>>(
        future: getArticleTypeBean(),
        builder: (context, snap)
        {
          switch (snap.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator(),);
              break;
            case ConnectionState.done:
              if(snap.hasData) {
                List<ArticleTypeBean> list = snap?.data;
                mController = TabController(
                  length: list.length,
                  vsync: this,
                );
                return Column(
                  children: <Widget>[
                    Container(
                      color: AppColors.color_FFFFFF,
                      width: double.maxFinite,
                      height: Screen.h(120),
                      child: TabBar(
                        controller: mController,
                        labelColor: AppColors.color_2d84eb,
                        indicatorColor: AppColors.color_2d84eb,
                        unselectedLabelColor: AppColors.color_434343,
                        labelStyle: TextStyle(fontSize: Screen.sp(46)),
                        tabs: list.map((item) {
                          return Tab(text: item.articleTypeName,);}).toList(),
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: mController,
                        children: list.map((item) {
                          return ArticleListPage(item.articleType,);
                        }).toList(),
                      ),
                    )
                  ],
                );
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

  Future<List<ArticleTypeBean>> getArticleTypeBean() async {
    return await _apiService.getArticleTypeList();
  }

}
