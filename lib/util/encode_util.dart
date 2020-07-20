import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'dart:io';

class EncodeUtil {
  /*
  * Md5加密
  * */
  static String generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    return digest.toString();
  }

  /*
  * Base64加密
  */
  static String encodeBase64(String data) {
    var content = utf8.encode(data);
    var digest = base64Encode(content);
    return digest;
  }

  /*
  * Base64解密
  */
  static String decodeBase64(String data) {
    return String.fromCharCodes(base64Decode(data));
  }

  /*
  * 通过图片路径将图片转换成Base64字符串
  */
  static Future image2Base64(String path) async {
    File file = new File(path);
    List<int> imageBytes = await file.readAsBytes();
    return base64Encode(imageBytes);
  }
}
