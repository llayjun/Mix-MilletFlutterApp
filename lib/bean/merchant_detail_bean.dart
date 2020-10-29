/// id : "12"
/// merchantName : "肯德基"
/// merchantLogo : "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3170817482,3417439457&fm=26&gp=0.jpg"
/// city : "苏州"
/// location : "苏州凯马广场"
/// scale : "20人"
/// establishTime : "2020-10-28T10:39:02"
/// nature : "私营"
/// funds : "100万"
/// range : null
/// merchantTaskNum : 1
/// merchantPicList : [{"id":"14","picture":"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1603863241368&di=41ff3817bd8073b7eeaeac9ec2c56036&imgtype=0&src=http%3A%2F%2Fuploads.qj.com.cn%2Fimage2017%2F20170909%2F1504927368795069317.jpg"},{"id":"15","picture":"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=297395008,3732625364&fm=26&gp=0.jpg"}]
/// merchantTaskList : [{"id":"13","merchantId":"12","merchantName":"肯德基","merchantLogo":"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3170817482,3417439457&fm=26&gp=0.jpg","merchantTaskName":"吮指原味鸡","merchantTaskDesc":"原味鸡的味道","merchantTaskUnitPrice":30}]

class MerchantDetailBean {
  String _id;
  String _merchantName;
  String _merchantLogo;
  String _city;
  String _location;
  String _scale;
  String _establishTime;
  String _nature;
  String _funds;
  String _merchantRange;
  int _merchantTaskNum;
  List<MerchantPicList> _merchantPicList;
  List<MerchantTaskList> _merchantTaskList;

  String get id => _id;
  String get merchantName => _merchantName;
  String get merchantLogo => _merchantLogo;
  String get city => _city;
  String get location => _location;
  String get scale => _scale;
  String get establishTime => _establishTime;
  String get nature => _nature;
  String get funds => _funds;
  String get merchantRange => _merchantRange;
  int get merchantTaskNum => _merchantTaskNum;
  List<MerchantPicList> get merchantPicList => _merchantPicList;
  List<MerchantTaskList> get merchantTaskList => _merchantTaskList;

  MerchantDetailBean({
      String id, 
      String merchantName, 
      String merchantLogo, 
      String city, 
      String location, 
      String scale, 
      String establishTime, 
      String nature, 
      String funds, 
      String merchantRange,
      int merchantTaskNum, 
      List<MerchantPicList> merchantPicList, 
      List<MerchantTaskList> merchantTaskList}){
    _id = id;
    _merchantName = merchantName;
    _merchantLogo = merchantLogo;
    _city = city;
    _location = location;
    _scale = scale;
    _establishTime = establishTime;
    _nature = nature;
    _funds = funds;
    _merchantRange = merchantRange;
    _merchantTaskNum = merchantTaskNum;
    _merchantPicList = merchantPicList;
    _merchantTaskList = merchantTaskList;
}

  MerchantDetailBean.fromJson(dynamic json) {
    _id = json["id"];
    _merchantName = json["merchantName"];
    _merchantLogo = json["merchantLogo"];
    _city = json["city"];
    _location = json["location"];
    _scale = json["scale"];
    _establishTime = json["establishTime"];
    _nature = json["nature"];
    _funds = json["funds"];
    _merchantRange = json["merchantRange"];
    _merchantTaskNum = json["merchantTaskNum"];
    if (json["merchantPicList"] != null) {
      _merchantPicList = [];
      json["merchantPicList"].forEach((v) {
        _merchantPicList.add(MerchantPicList.fromJson(v));
      });
    }
    if (json["merchantTaskList"] != null) {
      _merchantTaskList = [];
      json["merchantTaskList"].forEach((v) {
        _merchantTaskList.add(MerchantTaskList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["merchantName"] = _merchantName;
    map["merchantLogo"] = _merchantLogo;
    map["city"] = _city;
    map["location"] = _location;
    map["scale"] = _scale;
    map["establishTime"] = _establishTime;
    map["nature"] = _nature;
    map["funds"] = _funds;
    map["merchantRange"] = _merchantRange;
    map["merchantTaskNum"] = _merchantTaskNum;
    if (_merchantPicList != null) {
      map["merchantPicList"] = _merchantPicList.map((v) => v.toJson()).toList();
    }
    if (_merchantTaskList != null) {
      map["merchantTaskList"] = _merchantTaskList.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "13"
/// merchantId : "12"
/// merchantName : "肯德基"
/// merchantLogo : "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3170817482,3417439457&fm=26&gp=0.jpg"
/// merchantTaskName : "吮指原味鸡"
/// merchantTaskDesc : "原味鸡的味道"
/// merchantTaskUnitPrice : 30

class MerchantTaskList {
  String _id;
  String _merchantId;
  String _merchantName;
  String _merchantLogo;
  String _merchantTaskName;
  String _merchantTaskDesc;
  double _merchantTaskUnitPrice;
  String _taskLocation;
  String _createdTime;

  String get id => _id;
  String get merchantId => _merchantId;
  String get merchantName => _merchantName;
  String get merchantLogo => _merchantLogo;
  String get merchantTaskName => _merchantTaskName;
  String get merchantTaskDesc => _merchantTaskDesc;
  double get merchantTaskUnitPrice => _merchantTaskUnitPrice;
  String get taskLocation => _taskLocation;
  String get createdTime => _createdTime;

  MerchantTaskList({
      String id, 
      String merchantId, 
      String merchantName, 
      String merchantLogo, 
      String merchantTaskName, 
      String merchantTaskDesc,
      String taskLocation,
      String createdTime,
      double merchantTaskUnitPrice}){
    _id = id;
    _merchantId = merchantId;
    _merchantName = merchantName;
    _merchantLogo = merchantLogo;
    _merchantTaskName = merchantTaskName;
    _merchantTaskDesc = merchantTaskDesc;
    _taskLocation = taskLocation;
    _createdTime = createdTime;
    _merchantTaskUnitPrice = merchantTaskUnitPrice;
}

  MerchantTaskList.fromJson(dynamic json) {
    _id = json["id"];
    _merchantId = json["merchantId"];
    _merchantName = json["merchantName"];
    _merchantLogo = json["merchantLogo"];
    _merchantTaskName = json["merchantTaskName"];
    _merchantTaskDesc = json["merchantTaskDesc"];
    _taskLocation = json["taskLocation"];
    _createdTime = json["createdTime"];
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
    map["taskLocation"] = _taskLocation;
    map["createdTime"] = _createdTime;
    map["merchantTaskUnitPrice"] = _merchantTaskUnitPrice;
    return map;
  }

}

/// id : "14"
/// picture : "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1603863241368&di=41ff3817bd8073b7eeaeac9ec2c56036&imgtype=0&src=http%3A%2F%2Fuploads.qj.com.cn%2Fimage2017%2F20170909%2F1504927368795069317.jpg"

class MerchantPicList {
  String _id;
  String _picture;

  String get id => _id;
  String get picture => _picture;

  MerchantPicList({
      String id, 
      String picture}){
    _id = id;
    _picture = picture;
}

  MerchantPicList.fromJson(dynamic json) {
    _id = json["id"];
    _picture = json["picture"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["picture"] = _picture;
    return map;
  }

}