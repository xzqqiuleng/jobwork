import 'package:dio/dio.dart';
import 'package:recruit_app/pages/share_helper.dart';

class MiviceRepository{

//  static String baseUrl = 'http://192.168.1.21:8080/';      //开发
//  static String socketUrl = 'ws://192.168.1.9:8080/ws/msg?';
  static String baseUrl = 'http://www.18pinpin.com/crawler/';      //开发
  static String socketUrl = 'ws://www.18pinpin.com/crawler/ws/msg?';      //开发

  static Dio dio;

  MiviceRepository(){
      print("初始化");


        dio = new Dio();
      dio.options.baseUrl = baseUrl;

  }

   Future getWorkList(int page,int searchType,{String address}) async {
      var response = await dio.post<Map>('/job/list', data: {

      'pageSize': 10,
      'page': page,
      'address': address,
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
  Future getJobDetail(int jobId,String userMail) async {
    var response = await dio.post<Map>('/job/info',queryParameters: {

      'jobId': jobId,
      'userMail': userMail,
    });
    return response;
  }
  Future getCompanyDetail(int jobId,String userMail) async {
    var response = await dio.post<Map>('/company/info',queryParameters: {
      'userMail': userMail,
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
  Future changePhone(String phone,String new_phone,int type) async {
    var response = await dio.post<Map>('/user/updateMobile',data: {

      'mobile': phone,
      'new_mobile': new_phone,
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
    print(map);
    var response = await dio.post<Map>('/resume/modify', data: {
      "province": map["province"],
      "type": map["type"],
      "education": map["education"],
      "info": map["info"],
      "head_img": map["head_img"],
      "user_mail": map["user_mail"],
      "job_id": map["job_id"]
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
    var response = await Dio().post('http://file.18pinpin.com/upApi/upload', data: formData);
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

  Future getResumeInfo(String jobId,String userMail) async {
    var response = await dio.get<Map>('/resume/info', queryParameters: {
      "jobId":jobId,
      'userMail': userMail,
    });
    return response;
  }

  Future getResumeList(String userMail) async {
    var response = await dio.post<Map>('/job/myPubList', data: {
      "userMail":userMail
    });
    return response;
  }
  Future agreeRe(Map map) async {
    var response = await dio.post<Map>('/user/updateSMsg', data: {
      "msg":map["msg"],
      "user_id":map["user_id"],
      "reply_id":map["reply_id"],
      "uuid":map["uuid"],
    });
    return response;
  }

  Future putFeed(Map map) async {
    var response = await dio.post<Map>('/user/feedback', data: {
      "user_id":map["user_id"],
      "title":map["title"],
      "content":map["content"],
      "feed_type":map["type"],  //种类    //0意见反馈， 1 工作举报。2公司举报，3聊天举报，4简历举报
      "img":map["img"],  //图片
      "q_id":map["q_id"],  //问题id


    });
    return response;
  }

  Future getFeed(String id) async {
    var response = await dio.post<Map>('/user/noticeList', data: {
      "user_id":id,

    });
    return response;
  }
  Future getHomeBaner() async {
    var response = await dio.post<Map>('/banner/getBanners');
    return response;
  }

  Future saveJobByType(Map map) async {
    var response = await dio.post<Map>('/collect/job', data: {
      "user_mail":map["user_mail"],
      "job_id":map["job_id"],
      "type":map["type"],
      "class":map["class"],
    });
    return response;
  }
  Future getJodSaveListByType(Map map) async {
    var response = await dio.post<Map>('/collect/getJobs', data: {
      "usermail":map["user_mail"],
      "class":map["class"],
    });
    return response;
  }

  Future saveResumeByType(Map map) async {
    var response = await dio.post<Map>('/collect/resume', data: {
      "user_mail":map["user_mail"],
      "resume_id":map["job_id"],
      "type":map["type"],
      "class":map["class"],
    });
    return response;
  }
  Future getResumeSaveListByType(Map map) async {
    var response = await dio.post<Map>('/collect/getResumes', data: {
      "usermail":map["user_mail"],
      "class":map["class"],
    });
    return response;
  }

  Future saveCom(Map map) async {
    var response = await dio.post<Map>('/collect/com', data: {
      "user_mail":map["user_mail"],
      "com_id":map["com_id"],
      "type":map["type"],
    });
    return response;
  }
  Future getComList(Map map) async {
    var response = await dio.post<Map>('/collect/getComs', data: {
      "usermail":map["user_mail"],
    });
    return response;
  }
}
