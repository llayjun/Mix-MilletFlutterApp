/// id : "11"
/// merchantName : "如意馄饨"
/// merchantLogo : "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=151472226,3497652000&fm=26&gp=0.jpg"
/// merchantTaskNum : 2

class MerchantItemBean {
  String _id;
  String _merchantName;
  String _merchantLogo;
  int _merchantTaskNum;

  String get id => _id;
  String get merchantName => _merchantName;
  String get merchantLogo => _merchantLogo;
  int get merchantTaskNum => _merchantTaskNum;

  MerchantItemBean({
      String id, 
      String merchantName, 
      String merchantLogo, 
      int merchantTaskNum}){
    _id = id;
    _merchantName = merchantName;
    _merchantLogo = merchantLogo;
    _merchantTaskNum = merchantTaskNum;
}

  MerchantItemBean.fromJson(dynamic json) {
    _id = json["id"];
    _merchantName = json["merchantName"];
    _merchantLogo = json["merchantLogo"];
    _merchantTaskNum = json["merchantTaskNum"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["merchantName"] = _merchantName;
    map["merchantLogo"] = _merchantLogo;
    map["merchantTaskNum"] = _merchantTaskNum;
    return map;
  }

}