class BaseListBean<T> {
  int current;
  List<T> records;
  int pages;
  int size;
  int total;

  BaseListBean({this.current, this.records, this.pages, this.size, this.total});

  factory BaseListBean.fromJson(Map<String, dynamic> json) {
    return BaseListBean(
      current: json['current'],
      records: json['records'],
      pages: json['pages'],
      size: json['size'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current'] = this.current;
    data['records'] = this.records;
    data['pages'] = this.pages;
    data['size'] = this.size;
    data['total'] = this.total;
    return data;
  }
}
