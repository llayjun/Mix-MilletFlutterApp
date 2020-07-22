class BaseListBean<T> {
  int curPage;
  List<T> datas;
  int offset;
  bool over;
  int pageCount;
  int size;
  int total;

  BaseListBean(
      {this.curPage,
      this.datas,
      this.offset,
      this.over,
      this.pageCount,
      this.size,
      this.total});

  factory BaseListBean.fromJson(Map<String, dynamic> json) {
    return BaseListBean(
      curPage: json['curPage'],
      datas: json['datas'],
      offset: json['offset'],
      over: json['over'],
      pageCount: json['pageCount'],
      size: json['size'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['curPage'] = this.curPage;
    data['datas'] = this.datas;
    data['offset'] = this.offset;
    data['over'] = this.over;
    data['pageCount'] = this.pageCount;
    data['size'] = this.size;
    data['total'] = this.total;
    return data;
  }
}
