import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:oktoast/oktoast.dart';
import 'package:recruit_app/pages/constant.dart';
import 'package:recruit_app/pages/provider/update_info.dart';
/// App相关接口
class AppRepository {
  static Dio dio;
//  static String baseUrl = 'http://116.62.45.24/crawler/';      //开发

  static String baseUrl = 'http://www.18pinpin.com/crawler/';    //开发
  AppRepository(){



    dio = new Dio();
    dio.options.baseUrl = baseUrl;

  }
   Future<AppUpdateInfo> checkUpdate(String version) async {
    debugPrint('检查更新,当前版本为===>$version');
    var response = await dio.get('version/last', queryParameters: {
      'version': version,
    });
   var jsroStr =  json.decode(response.toString());

    if(jsroStr["status"] =="success"){
      var result = AppUpdateInfo.fromMap(jsroStr["result"]);
      debugPrint('发现新版本===>');
      return result;
    }

    return null;
  }
}
