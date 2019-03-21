import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';

//通用的请求
Future request(url, {formData}) async {
  try {
    print('开始获取$url数据......1');
    Response response;
    Dio dio = Dio();
    //设置contentType
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded");
    if (formData == null) {
      //请求参数
      response = await dio.post(servicePath[url]);
    } else {
      //请求参数
      response = await dio.post(servicePath[url], data: formData);
    }
    if (response.statusCode == 200) {
      print("请求结果是否是Map 1${response.data is Map}");
      return response.data;
    } else {
      throw Exception("后端接口出现异常，请检查代码和服务器情况......");
    }
  } catch (e) {
    return print('ERROR:=======>$e');
  }
}


