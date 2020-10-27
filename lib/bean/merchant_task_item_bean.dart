/// id : "11"
/// merchantId : "11"
/// merchantName : "如意馄饨"
/// merchantLogo : "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=151472226,3497652000&fm=26&gp=0.jpg"
/// merchantTaskName : "一碗馄饨"
/// merchantTaskDesc : "馄饨的日子"
/// merchantTaskUnitPrice : 10

class MerchantTaskItemBean {
  String _id;
  String _merchantId;
  String _merchantName;
  String _merchantLogo;
  String _merchantTaskName;
  String _merchantTaskDesc;
  double _merchantTaskUnitPrice;

  String get id => _id;
  String get merchantId => _merchantId;
  String get merchantName => _merchantName;
  String get merchantLogo => _merchantLogo;
  String get merchantTaskName => _merchantTaskName;
  String get merchantTaskDesc => _merchantTaskDesc;
  double get merchantTaskUnitPrice => _merchantTaskUnitPrice;

  MerchantTaskItemBean({
      String id, 
      String merchantId, 
      String merchantName, 
      String merchantLogo, 
      String merchantTaskName, 
      String merchantTaskDesc,
      double merchantTaskUnitPrice}){
    _id = id;
    _merchantId = merchantId;
    _merchantName = merchantName;
    _merchantLogo = merchantLogo;
    _merchantTaskName = merchantTaskName;
    _merchantTaskDesc = merchantTaskDesc;
    _merchantTaskUnitPrice = merchantTaskUnitPrice;
}

  MerchantTaskItemBean.fromJson(dynamic json) {
    _id = json["id"];
    _merchantId = json["merchantId"];
    _merchantName = json["merchantName"];
    _merchantLogo = json["merchantLogo"];
    _merchantTaskName = json["merchantTaskName"];
    _merchantTaskDesc = json["merchantTaskDesc"];
    _merchantTaskUnitPrice = json["merchantTaskUnitPrice"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["merchantId"] = _merchantId;
    map["merchantName"] = _merchantName;
    map["merchantLogo"] = _merchantLogo;
    map["merchantTaskName"] = _merchantTaskName;
    map["merchantTaskDesc"] = _merchantTaskDesc;
    map["merchantTaskUnitPrice"] = _merchantTaskUnitPrice;
    return map;
  }

}