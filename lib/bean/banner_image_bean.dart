/// id : "1"
/// imageUrl : "https://dss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2534506313,1688529724&fm=26&gp=0.jpg"

class BannerImageBean {
  String _id;
  String _imageUrl;

  String get id => _id;
  String get imageUrl => _imageUrl;

  BannerImageBean({
      String id, 
      String imageUrl}){
    _id = id;
    _imageUrl = imageUrl;
}

  BannerImageBean.fromJson(dynamic json) {
    _id = json["id"];
    _imageUrl = json["imageUrl"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["imageUrl"] = _imageUrl;
    return map;
  }

}