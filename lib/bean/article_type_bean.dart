/// id : "1332202937878327297"
/// articleType : 1
/// articleTypeName : "Android"

class ArticleTypeBean {
  String _id;
  int _articleType;
  String _articleTypeName;

  String get id => _id;

  int get articleType => _articleType;

  String get articleTypeName => _articleTypeName;

  ArticleTypeBean({String id, int articleType, String articleTypeName}) {
    _id = id;
    _articleType = articleType;
    _articleTypeName = articleTypeName;
  }

  ArticleTypeBean.fromJson(dynamic json) {
    _id = json["id"];
    _articleType = json["articleType"];
    _articleTypeName = json["articleTypeName"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["articleType"] = _articleType;
    map["articleTypeName"] = _articleTypeName;
    return map;
  }
}
