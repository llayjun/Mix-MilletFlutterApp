class BaseBean<T> {
  T data;
  int errorCode;
  String errorMsg;

  BaseBean({this.data, this.errorCode, this.errorMsg});

  factory BaseBean.fromJson(Map<String, dynamic> json) {
    return BaseBean(
      data: json['data'],
      errorCode: json['code'],
      errorMsg: json['msg'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['code'] = this.errorCode;
    data['msg'] = this.errorMsg;
    return data;
  }
}
