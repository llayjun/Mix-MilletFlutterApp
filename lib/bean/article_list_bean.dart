/// id : "1332252043250274305"
/// articleType : 1
/// articleTitle : "ListView 与 RecyclerView 你应该弄懂的都在这里了"
/// articleUrl : "https://juejin.cn/post/6899614958632812557"
/// readState : 0

class ArticleListBean {
  String _id;
  int _articleType;
  String _articleTitle;
  String _articleUrl;
  int _readState;

  String get id => _id;
  int get articleType => _articleType;
  String get articleTitle => _articleTitle;
  String get articleUrl => _articleUrl;
  int get readState => _readState;

  ArticleListBean({
      String id, 
      int articleType, 
      String articleTitle, 
      String articleUrl, 
      int readState}){
    _id = id;
    _articleType = articleType;
    _articleTitle = articleTitle;
    _articleUrl = articleUrl;
    _readState = readState;
}

  ArticleListBean.fromJson(dynamic json) {
    _id = json["id"];
    _articleType = json["articleType"];
    _articleTitle = json["articleTitle"];
    _articleUrl = json["articleUrl"];
    _readState = json["readState"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["articleType"] = _articleType;
    map["articleTitle"] = _articleTitle;
    map["articleUrl"] = _articleUrl;
    map["readState"] = _readState;
    return map;
  }

}