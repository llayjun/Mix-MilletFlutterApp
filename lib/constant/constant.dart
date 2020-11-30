class Constant {
  /// debug
  static final bool Debug = true;

  /// base url
  // static final String BaseUrl = "http://192.168.10.16:8081/";
  // static final String BaseUrl = "http://351x29514o.zicp.vip/"; /// 内网穿透
  static final String BaseUrl = "http://139.224.40.178:8080/"; /// 服务器地址

  /// test image url
  static final String TestImage = "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2534506313,1688529724&fm=26&gp=0.jpg";

  /// pageSize
  static final int PAGE_SIZE = 10; // 默认十条
  static final int PAGE_SIZE_100 = 100; // 可以100条
  static final int PAGE_SIZE_1000 = 1000; // 可以1000条

}

class SpKeyUtil {
  static final String TokenKey = "TokenKey";
}
