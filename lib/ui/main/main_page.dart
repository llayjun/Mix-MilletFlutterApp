import 'package:MilletFlutterApp/constant/app_colors.dart';
import 'package:MilletFlutterApp/constant/app_images.dart';
import 'package:MilletFlutterApp/ui/main/find/find_page.dart';
import 'package:MilletFlutterApp/ui/main/mine/mine_page.dart';
import 'package:MilletFlutterApp/ui/main/shop/shop_page.dart';
import 'package:MilletFlutterApp/util/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'home/home_page.dart';

class MainPage extends StatefulWidget {
  int initPage;

  MainPage({this.initPage = 0});

  @override
  State<StatefulWidget> createState() {
    return new MainPageState();
  }
}

class MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    _currentIndex = widget.initPage;
    _pageController = PageController(initialPage: widget.initPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          new Scaffold(
            body: new WillPopScope(
                child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  children: <Widget>[
                    new HomePage(),
                    new FindPage(),
                    new ShopPage(),
                    new MinePage(),
                  ],
                ),
                onWillPop: _exitApp),
            bottomNavigationBar: BottomAppBar(
              color: AppColors.color_FFFFFF,
              shape: CircularNotchedRectangle(),
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
                child: new Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child: setBottomState(0),
                      flex: 1,
                    ),
                    Expanded(
                      child: setBottomState(1),
                      flex: 1,
                    ),
                    Expanded(
                      child: setBottomState(2),
                      flex: 1,
                    ),
                    Expanded(
                      child: setBottomState(3),
                      flex: 1,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onTap(int index) {
    _pageController.jumpToPage(index);
    _currentIndex = index;
    setState(() {});
  }

  /// 设置底部状态
  Widget setBottomState(int index) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          onTap(index);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Image.asset(
              getBottomStateImage(index),
              width: Screen.w(60),
              height: Screen.w(60),
            ),
            Text(getBottomStateString(index),
                style: TextStyle(
                  color: _currentIndex == index
                      ? AppColors.color_ff0000
                      : AppColors.color_434343,
                  fontSize: Screen.sp(30),
                ))
          ],
        ));
  }

  /// 获取底部图片
  String getBottomStateImage(int index) {
    String image;
    switch (index) {
      case 0:
        image = _currentIndex == index
            ? AppImages.assetsHomeActive
            : AppImages.assetsHomeInActive;
        break;
      case 1:
        image = _currentIndex == index
            ? AppImages.assetsCategoryActive
            : AppImages.assetsCategoryInActive;
        break;
      case 2:
        image = _currentIndex == index
            ? AppImages.assetsCartActive
            : AppImages.assetsCartInActive;
        break;
      case 3:
        image = _currentIndex == index
            ? AppImages.assetsMineActive
            : AppImages.assetsMineInActive;
        break;
    }
    return image;
  }

  /// 获取底部文字
  String getBottomStateString(int index) {
    String value;
    switch (index) {
      case 0:
        value = '首页';
        break;
      case 1:
        value = '工作';
        break;
      case 2:
        value = '发现';
        break;
      case 3:
        value = '我的';
        break;
    }
    return value;
  }

  /// 底部导航item
  BottomNavigationBarItem _bottomItem(String title, int index) {
    switch (index) {
      case 0:
        return BottomNavigationBarItem(
            icon: new Image.asset(
              AppImages.assetsHomeInActive,
              width: Screen.w(20),
              height: Screen.w(20),
            ),
            activeIcon: new Image.asset(
              AppImages.assetsHomeActive,
              width: Screen.w(20),
              height: Screen.w(20),
            ),
            title: Text(title,
                style: TextStyle(
                  color: AppColors.color_434343,
                  fontSize: Screen.sp(13),
                )));
        break;
      case 1:
        return BottomNavigationBarItem(
            icon: new Image.asset(
              AppImages.assetsCategoryInActive,
              width: Screen.w(20),
              height: Screen.w(20),
            ),
            activeIcon: new Image.asset(
              AppImages.assetsCategoryActive,
              width: Screen.w(20),
              height: Screen.w(20),
            ),
            title: Text(title,
                style: TextStyle(
                  color: AppColors.color_434343,
                  fontSize: Screen.sp(13),
                )));
        break;
      case 2:
        return BottomNavigationBarItem(
            icon: new Image.asset(
              AppImages.assetsCategoryInActive,
              width: Screen.w(20),
              height: Screen.w(20),
            ),
            activeIcon: new Image.asset(
              AppImages.assetsCategoryActive,
              width: Screen.w(20),
              height: Screen.w(20),
            ),
            title: Text(title,
                style: TextStyle(
                  color: AppColors.color_434343,
                  fontSize: Screen.sp(13),
                )));
        break;
      case 3:
        return BottomNavigationBarItem(
            icon: new Image.asset(
              AppImages.assetsCartInActive,
              width: Screen.w(20),
              height: Screen.w(20),
            ),
            activeIcon: new Image.asset(
              AppImages.assetsCartActive,
              width: Screen.w(20),
              height: Screen.w(20),
            ),
            title: Text(title,
                style: TextStyle(
                  color: AppColors.color_434343,
                  fontSize: Screen.sp(13),
                )));
        break;
      case 4:
        return BottomNavigationBarItem(
            icon: new Image.asset(
              AppImages.assetsMineInActive,
              width: Screen.w(20),
              height: Screen.w(20),
            ),
            activeIcon: new Image.asset(
              AppImages.assetsMineActive,
              width: Screen.w(20),
              height: Screen.w(20),
            ),
            title: Text(title,
                style: TextStyle(
                  color: AppColors.color_434343,
                  fontSize: Screen.sp(13),
                )));
        break;
    }
    return null;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  DateTime _lastPressedAt;

  /// 上次点击时间
  /// 退出app
  Future<bool> _exitApp() {
    if (_lastPressedAt == null ||
        DateTime.now().difference(_lastPressedAt) > Duration(seconds: 2)) {
      Fluttertoast.showToast(msg: '再按一次退出应用');
      //两次点击间隔超过2秒则重新计时
      _lastPressedAt = DateTime.now();
      return Future.value(false);
    }
    return Future.value(true);
  }
}
