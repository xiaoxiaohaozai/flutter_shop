import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';
import 'dart:convert';

//获取首页信息
Future getHomePageContent() async {
  try {
    print('开始获取首页数据......');
    Response response;
    Dio dio = Dio();
    //设置contentType
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded");
    //请求参数
    var formData = {'lon': '115.02932', 'lat': '35.76189'};
    response = await dio.post(servicePath['homePageContent'], data: formData);
    if (response.statusCode == 200) {
      print( "123${response.data is Map}");
      return response.data;
    } else {
      throw Exception("后端接口出现异常，请检查代码和服务器情况......");
    }
  } catch (e) {
    return print('ERROR:=======>$e');
  }
}
