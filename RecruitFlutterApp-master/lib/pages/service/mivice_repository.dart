import 'package:dio/dio.dart';

class MiviceRepository{

  static String baseUrl = 'http://192.168.1.14:8080/';      //开发

  static Dio dio;

  MiviceRepository(){
      print("初始化");


        dio = new Dio();
      dio.options.baseUrl = baseUrl;

  }

   Future getWorkList(int sortId) async {
      var response = await dio.post<Map>('/job/list', data: {

      'pageSize': 10,
      'sortId': sortId,
    });
    return response;
  }


}