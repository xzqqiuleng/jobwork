import 'package:dio/dio.dart';

class MiviceRepository{

//  static String baseUrl = 'http://116.62.45.24/crawler/';      //开发

  static String baseUrl = 'http://192.168.1.14:8080/';      //开发
  static String socketUrl = 'ws://192.168.1.14:8080/ws/msg?';      //开发

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
  Future getFilterList(int page,int searchType,{String address,String education,String experience,String salary,int jobType,String searchText}) async {
    var response = await dio.post<Map>('/job/filterList', data: {

      'pageSize': 10,
      'page': page,
      'searchType': searchType,
      'address': address,
      'experience': experience,
      'education': education,
      'salary': salary,
      'jobType': jobType,
      'searchText': searchText

    });
    return response;
  }
  Future getMsgWorkList(int page,int searchType) async {
    var response = await dio.post<Map>('/job/randomList', data: {

      'pageSize': 10,
      'page': page,
      'searchType': searchType,
    });
    return response;
  }
  Future getCompanyList(int page,{int searchType,String searchText}) async {
    var response = await dio.post<Map>('/company/list', data: {

      'pageSize': 10,
      'page': page,
      'searchType': searchType,
      'searchText': searchText,
    });
    return response;
  }
  Future getJobDetail(int jobId) async {
    var response = await dio.post<Map>('/job/info',queryParameters: {

      'jobId': jobId,
    });
    return response;
  }
  Future getCompanyDetail(int jobId) async {
    var response = await dio.post<Map>('/company/info',queryParameters: {

      'comId': jobId,
    });
    return response;
  }


  // 0老板
  Future registerPd(String phone,String pwd,int type) async {
    var response = await dio.post<Map>('/user/register',data: {

      'user_mail': phone,
      'password': pwd,
      'type': type,
    });
    return response;
  }
  // 0老板
  Future forgetPd(String phone,String pwd,int type) async {
    var response = await dio.post<Map>('/user/forgetPassword',data: {

      'user_mail': phone,
      'password': pwd,
      'type': type,
    });
    return response;
  }
  // 0老板
  Future loginPd(String phone,String pwd,int type) async {
    var response = await dio.post<Map>('/user/login',data: {

      'user_mail': phone,
      'password': pwd,
      'type': type,
    });
    return response;
  }


  Future getFilterJlList(int page,{int searchType,String address,String education,String sex,String salary,int jobType,String searchText}) async {
    var response = await dio.post<Map>('/resume/list', data: {

      'pageSize': 10,
      'page': page,
      'searchType': searchType,  //4
      'address': address,
      'sex': sex,
      'education': education,
      'salary': salary,
      'jobType': jobType,   //3
      'searchText': searchText

    });
    return response;
  }

  Future getMessageList(String userId,int type) async {
    var response = await dio.post<Map>('/user/getMsgList', data: {

      'userId': userId,
      'type': type,
    });
    return response;
  }

  Future upDateJL(String json)async{
    var response = await dio.post<Map>('/user/getMsgList', data: {

      'userId': 10,
      'type': json,
    });
    return response;
  }

  Future pubResumen(Map map) async {
    var response = await dio.post<Map>('/resume/modify', data: {
      "province": map["province"],
      "type": map["type"],
      "education": map["education"],
      "info": map["info"],
      "head_img": map["head_img"],
      "user_mail": map["user_mail"]
    });
    return response;
  }

  Future getRusumen(String userMail) async {
    var response = await dio.get<Map>('/resume/getResume', queryParameters: {
    "userMail":userMail
    });
    return response;
  }
  Future getCompany(String userMail) async {
    var response = await dio.get<Map>('/company/getCompany', queryParameters: {
      "userMail":userMail
    });
    return response;
  }
  Future pubCompany(Map map) async {
    var response = await dio.post<Map>('/company/modify', data: map);
    return response;
  }
  Future pubJob(Map map) async {
    var response = await dio.post<Map>('/job/modify', data: map);
    return response;
  }


  Future updateUser(Map map) async {
    var response = await dio.post<Map>('/user/modify', data: map);
    return response;
  }

  static Future upLoadPicture(String path) async{
    var name = path.substring(path.lastIndexOf("/") + 1, path.length);
    var image = await MultipartFile.fromFile(
      path,
      filename: name,
    );
    FormData formData = FormData.fromMap({
      "file": image
    });
    var response = await Dio().post('http://62.60.174.78:8088/upload', data: formData);
    return response;
  }

  Future getToken() async {
    var response = await dio.get('/user/getToken');
    return response;
  }

  Future getAllMessage(String userId,String replyId) async {
    var response = await dio.post<Map>('/user/getMsgs', data: {
      "userId":userId,
      "replyId":replyId,
    });
    return response;
  }
}
