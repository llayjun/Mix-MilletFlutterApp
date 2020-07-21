import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class MapUtil {
  /// 高德地图
  static Future<bool> gotoAMap(longitude, latitude) async {
    var url = '${Platform.isAndroid ? 'android' : 'ios'}amap://navi?sourceApplication=amap&lat=$latitude&lon=$longitude&dev=1&style=2';
    bool canLaunchUrl = await canLaunch(url);
    if (!canLaunchUrl) {
      Fluttertoast.showToast(msg: '未检测到高德地图~', gravity: ToastGravity.CENTER);
      return false;
    }
    await launch(url);
    return true;
  }

  /// 腾讯地图
  static Future<bool> gotoTencentMap(longitude, latitude) async {
    var url = 'qqmap://map/routeplan?type=drive&tocoord=$latitude,$longitude&referer=IXHBZ-QIZE4-ZQ6UP-DJYEO-HC2K2-EZBXJ';
    bool canLaunchUrl = await canLaunch(url);
    if (!canLaunchUrl) {
      Fluttertoast.showToast(msg: '未检测到腾讯地图~', gravity: ToastGravity.CENTER);
      return false;
    }
    await launch(url);
    return canLaunchUrl;
  }

  /// 百度地图
  static Future<bool> gotoBaiduMap(longitude, latitude) async {
    var url = 'baidumap://map/direction?destination=$latitude,$longitude&coord_type=bd09ll&mode=driving';
    bool canLaunchUrl = await canLaunch(url);
    if (!canLaunchUrl) {
      Fluttertoast.showToast(msg: '未检测到百度地图~', gravity: ToastGravity.CENTER);
      return false;
    }
    await launch(url);
    return canLaunchUrl;
  }

  /// 苹果地图
  static Future<bool> gotoAppleMap(String geo) async {
    var url = 'https://maps.apple.com/?sll=$geo&t=s';
    bool canLaunchUrl = await canLaunch(url);
    if (!canLaunchUrl) {
      Fluttertoast.showToast(msg: '打开失败~', gravity: ToastGravity.CENTER);
      return false;
    }
    await launch(url);
  }
}
