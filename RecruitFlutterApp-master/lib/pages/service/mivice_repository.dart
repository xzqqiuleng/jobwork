import 'package:dio/dio.dart';

class MiviceRepository{

  static String baseUrl = 'http://116.62.45.24/crawler/';      //开发

  static Dio dio;

  MiviceRepository(){
      print("初始化");


        dio = new Dio();
      dio.options.baseUrl = baseUrl;

  }

   Future getWorkList(int page,int searchType) async {
      var response = await dio.post<Map>('/job/list', data: {

      'pageSize': 10,
      'page': page,
      'searchType': searchType,
    });
    return response;
  }
  Future getCompanyList(int sortId) async {
    var response = await dio.post<Map>('/company/list', data: {

      'pageSize': 10,
      'sortId': sortId,
    });
    return response;
  }

}