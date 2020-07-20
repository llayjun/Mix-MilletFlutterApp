/// 公共App配置
/// 初始化后，通过[Config.inst]获取实例
class Config {
  static final Config inst = Config._();

  /// 是否是debug模式
  bool debug;

  /// 本地存储数据库名称
  String dbName;

  /// 网络url
  String apiUrl;

  Config._();

  factory Config.fill({
    bool debug = false,
    String dbName = "demo",
    String apiUrl,
  }) {
    inst.debug = debug;
    inst.dbName = dbName;
    inst.apiUrl = apiUrl;
    return inst;
  }
}
