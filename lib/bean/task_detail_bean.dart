/// id : "11"
/// merchantId : "11"
/// merchantName : "如意馄饨"
/// merchantLogo : "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3484285671,3988413062&fm=26&gp=0.jpg"
/// merchantTaskName : "一碗馄饨"
/// merchantTaskDesc : "馄饨的日子"
/// merchantTaskUnitPrice : 10.0
/// taskLocation : "苏州"
/// createdTime : "2020-10-29 11:49:45"
/// taskPictureList : [{"id":"11","picture":"https://dss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3017084119,3290537556&fm=26&gp=0.jpg"},{"id":"12","picture":"https://dss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1352640652,935170192&fm=26&gp=0.jpg"},{"id":"13","picture":"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=867026591,4282317423&fm=26&gp=0.jpg"}]

class TaskDetailBean {
  String _id;
  String _merchantId;
  String _merchantName;
  String _merchantLogo;
  String _merchantTaskName;
  String _merchantTaskDesc;
  double _merchantTaskUnitPrice;
  String _taskLocation;
  String _createdTime;
  List<TaskPictureList> _taskPictureList;

  String get id => _id;
  String get merchantId => _merchantId;
  String get merchantName => _merchantName;
  String get merchantLogo => _merchantLogo;
  String get merchantTaskName => _merchantTaskName;
  String get merchantTaskDesc => _merchantTaskDesc;
  double get merchantTaskUnitPrice => _merchantTaskUnitPrice;
  String get taskLocation => _taskLocation;
  String get createdTime => _createdTime;
  List<TaskPictureList> get taskPictureList => _taskPictureList;

  TaskDetailBean({
      String id, 
      String merchantId, 
      String merchantName, 
      String merchantLogo, 
      String merchantTaskName, 
      String merchantTaskDesc, 
      double merchantTaskUnitPrice, 
      String taskLocation, 
      String createdTime, 
      List<TaskPictureList> taskPictureList}){
    _id = id;
    _merchantId = merchantId;
    _merchantName = merchantName;
    _merchantLogo = merchantLogo;
    _merchantTaskName = merchantTaskName;
    _merchantTaskDesc = merchantTaskDesc;
    _merchantTaskUnitPrice = merchantTaskUnitPrice;
    _taskLocation = taskLocation;
    _createdTime = createdTime;
    _taskPictureList = taskPictureList;
}

  TaskDetailBean.fromJson(dynamic json) {
    _id = json["id"];
    _merchantId = json["merchantId"];
    _merchantName = json["merchantName"];
    _merchantLogo = json["merchantLogo"];
    _merchantTaskName = json["merchantTaskName"];
    _merchantTaskDesc = json["merchantTaskDesc"];
    _merchantTaskUnitPrice = json["merchantTaskUnitPrice"];
    _taskLocation = json["taskLocation"];
    _createdTime = json["createdTime"];
    if (json["taskPictureList"] != null) {
      _taskPictureList = [];
      json["taskPictureList"].forEach((v) {
        _taskPictureList.add(TaskPictureList.fromJson(v));
      });
    }
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
    map["taskLocation"] = _taskLocation;
    map["createdTime"] = _createdTime;
    if (_taskPictureList != null) {
      map["taskPictureList"] = _taskPictureList.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "11"
/// picture : "https://dss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3017084119,3290537556&fm=26&gp=0.jpg"

class TaskPictureList {
  String _id;
  String _picture;

  String get id => _id;
  String get picture => _picture;

  TaskPictureList({
      String id, 
      String picture}){
    _id = id;
    _picture = picture;
}

  TaskPictureList.fromJson(dynamic json) {
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