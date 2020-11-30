import 'package:MilletFlutterApp/bean/article_list_bean.dart';
import 'package:MilletFlutterApp/bean/base/base_list_bean.dart';
import 'package:MilletFlutterApp/constant/app_colors.dart';
import 'package:MilletFlutterApp/service/api_service.dart';
import 'package:MilletFlutterApp/ui/web_view/web_view_page.dart';
import 'package:MilletFlutterApp/util/date_util.dart';
import 'package:MilletFlutterApp/util/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:MilletFlutterApp/util/navigator_util.dart';

class ArticleListPage extends StatefulWidget {

  int articleType;

  ArticleListPage(this.articleType, {Key key}): super(key: key);

  @override
  _ArticleListPageState createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleListPage> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true; //必须重写

  ApiService apiService = ApiService();

  List<ArticleListBean> articleList = [];

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
    future = getData(widget.articleType, index);
  }

  Future<BaseListBean<ArticleListBean>> getData(int articleType, int pageNum) async {
    return await apiService.getArticleListPage(articleType: articleType, pageNum: pageNum);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BaseListBean<ArticleListBean>>(
      future: future,
      builder: (context, snap) {
        switch(snap.connectionState) {
          case ConnectionState.waiting:
            return new Center(child: CircularProgressIndicator(),);
            break;
          case ConnectionState.done:
            if(snap.hasData && initData) {
              BaseListBean<ArticleListBean> bean = snap?.data;
              List<ArticleListBean> _articleList = bean.records??[];
              articleList.clear();
              articleList.addAll(_articleList);
              initData = false;
            }
            return EasyRefresh(
              child: ListView.separated(
                primary: false,
                separatorBuilder: (context, index) {
                  return Container(height: Screen.h(2), color: AppColors.color_f8f8f8);
                },
                itemBuilder: (context, index) {
                  return InkWell(
                    child: _itemArticle('${articleList[index].articleTitle??""}', '${DateUtil.getDateStrByDateTime(DateTime.now(), format: DateFormat.YEAR_MONTH)??""}'),
                    onTap: () {
                      NavigatorUtil.push(context, WebViewPage(title: '${articleList[index].articleTitle??""}',url: '${articleList[index].articleUrl??""}'));
                    },);
                },
                itemCount: articleList?.length??0,
              ),
              onRefresh: () async {
                index = 1;
                getData(widget.articleType, index).then((value) {
                  articleList.clear();
                  articleList.addAll(value.records);
                  _easyRefreshController.resetLoadState();
                  _easyRefreshController.finishLoad(success: true, noMore: value.current >= value.pages);
                  setState(() {});
                });
              },
              onLoad: () async {
                index ++;
                getData(widget.articleType, index).then((value) {
                  articleList.addAll(value.records);
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
    );
  }

  Widget _itemArticle(String title, String time) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(Screen.w(45)),
        child: Row(
          children: [
            CircleAvatar(
              child: Text('${title.characters.first}'),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: Screen.w(45)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$title', style: TextStyle(color: AppColors.color_000000, fontSize: Screen.sp(46)), maxLines: 2, overflow: TextOverflow.ellipsis,),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text('$time', style: TextStyle(color: AppColors.color_000000, fontSize: Screen.sp(40)),),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}
