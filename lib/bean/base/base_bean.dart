class BaseBean<T> {
  T data;
  int errorCode;
  String errorMsg;

  BaseBean({this.data, this.errorCode, this.errorMsg});

  factory BaseBean.fromJson(Map<String, dynamic> json) {
    return BaseBean(
      data: json['data'],
      errorCode: json['errorCode'],
      errorMsg: json['errorMsg'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['errorCode'] = this.errorCode;
    data['errorMsg'] = this.errorMsg;
    return data;
  }
}
