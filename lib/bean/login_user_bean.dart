/// id : ""
/// mobile : 13142667578
/// name : "name"
/// passWord : 12345678
/// sex : 1

class LoginUserBean {
  String _id;
  String _mobile;
  String _name;
  String _passWord;
  int _sex;
  String _authorization;

  String get id => _id;
  String get mobile => _mobile;
  String get name => _name;
  String get passWord => _passWord;
  int get sex => _sex;
  String get authorization => _authorization;

  LoginUserBean({
      String id,
      String mobile,
      String name,
      String passWord,
      int sex}){
    _id = id;
    _mobile = mobile;
    _name = name;
    _passWord = passWord;
    _sex = sex;
    _authorization = authorization;
}

  LoginUserBean.fromJson(dynamic json) {
    _id = json["id"];
    _mobile = json["mobile"];
    _name = json["name"];
    _passWord = json["passWord"];
    _sex = json["sex"];
    _authorization = json["authorization"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["mobile"] = _mobile;
    map["name"] = _name;
    map["passWord"] = _passWord;
    map["sex"] = _sex;
    map["authorization"] = _authorization;
    return map;
  }

}